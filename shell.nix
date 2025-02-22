{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    packages = with pkgs; [
        stow
        git
        python3 # Python 3 programming language
        chntpw # Windows registry editor, for dual boot setup.
    ];
}
