#!/usr/bin/env python3

import os
import shutil
from optparse import OptionParser


def adjust_mac_address(mac_address):
    """Adjust the MAC address (hex value) by decreasing it by one, accounting for overflow."""
    mac_parts = mac_address.split(":")

    # Convert the MAC address to a 48-bit integer
    mac_int = 0
    for part in mac_parts:
        mac_int = (mac_int << 8) | int(part, 16)

    # Decrease the integer by 1
    mac_int -= 1

    # Convert the integer back to a MAC address (6 octets)
    adjusted_mac_parts = []
    for _ in range(6):
        adjusted_mac_parts.append(f"{mac_int & 0xFF:02X}")
        mac_int >>= 8

    # Return the adjusted MAC address
    return ":".join(reversed(adjusted_mac_parts))


def prompt_for_overwrite(src_file, dest_file):
    """Prompt the user for confirmation before overwriting an existing file."""
    while True:
        response = (
            input(
                f"File {dest_file} exists and will be overwritten with {src_file}. Do you want to overwrite it? (y/n): "
            )
            .strip()
            .lower()
        )
        if response in ["y", "n"]:
            return response == "y"
        else:
            print("Invalid input. Please enter 'y' for yes or 'n' for no.")


def copy_info_files(src_base, dest_base):
    for root, _, files in os.walk(src_base):
        for file in files:
            if file != "info":
                continue

            # Construct the full source file path
            src_file = os.path.join(root, file)

            # Extract the MAC address directory (the one before "info")
            src_head, src_dir = os.path.split(root)

            # Adjust the MAC address for the destination directory
            dest_dir_decremented = adjust_mac_address(src_dir)

            # Calculate the relative path and construct the destination file path
            relative_path = os.path.relpath(src_file, src_base)
            dest_file_decremented = os.path.join(
                dest_base,
                os.path.relpath(src_head, src_base),
                dest_dir_decremented,
                "info",
            )
            dest_file_exact = os.path.join(
                dest_base,
                os.path.relpath(src_head, src_base),
                src_dir,
                "info",
            )

            # Ensure the destination directories exist
            dest_dir_full_decremented = os.path.dirname(dest_file_decremented)
            dest_dir_full_exact = os.path.dirname(dest_file_exact)

            # Check if the destination file exists
            if os.path.exists(dest_file_exact):
                if prompt_for_overwrite(src_file, dest_file_exact):
                    print(f"Copying {src_file} to {dest_file_exact}")
                    # Copy the file, overwriting the destination file
                    shutil.copy2(src_file, dest_file_exact)
                else:
                    print(f"Skipping {src_file}.")
            elif os.path.exists(dest_file_decremented):
                if prompt_for_overwrite(src_file, dest_file_decremented):
                    print(f"Copying {src_file} to {dest_file_decremented}")
                    # Copy the file, overwriting the destination file
                    # Rename the directory to exact MAC address.
                    shutil.copy2(src_file, dest_file_decremented)
                    os.rename(dest_dir_full_decremented, dest_dir_full_exact)
                else:
                    print(f"Skipping {src_file}.")


def main():
    # Set up option parsing using optparse
    parser = OptionParser(usage="usage: %prog [options]")
    parser.add_option(
        "--src_base",
        dest="src_base",
        help="The base directory of source files.",
    )
    parser.add_option(
        "--dest_base",
        dest="dest_base",
        default="/var/lib/bluetooth",
        help="The base directory for destination files (default: /var/lib/bluetooth).",
    )

    # Parse the command-line options
    options, _ = parser.parse_args()

    # Ensure the src_base is provided
    if not options.src_base:
        parser.print_help()
        exit(1)

    # Run the function with the parsed options
    copy_info_files(options.src_base, options.dest_base)


if __name__ == "__main__":
    # Call the main function
    main()
