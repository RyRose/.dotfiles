# My dotfiles

These are my personal dotfiles. To use, install
[GNU Stow](https://www.gnu.org/software/stow) and clone this repository to the
home directory. Then, with this repo as your current working directory, use
`stow` for any of the following directories.

## Setup

1. Clone the repository. If using nix, run `nix-shell -p git` to grab Git.

```console
git clone https://github.com/RyRose/.dotfiles.git ~/.dotfiles
```

1. Run `make ${ENV}` where `ENV` is one of laptop/home/nas. For nixos, run
   `nix develop` (alternatively `nix-shell`) to make `stow` available along with
   any other dependencies.
1. For write access to this repo, run `./utils/update_remote_to_ssh.sh` to update the
   git url to ssh and run `./utils/gen_github_key.sh` to generate an SSH key for
   github. Add this key here: <https://github.com/settings/keys>
1. For bootstrapping nixos, run `reload_nixos` to use the environment-specific
   script to reload nix at ~/.local/bin/reload_nixos.

## Environments

### `base`

```console
make base
```

Base configuration for all environments.

### `home`

```console
make home
```

Configuration for home desktop.

### `nas`

```console
make nas
```

Configuration for NAS.

### `laptop`

```console
make laptop
```

Configuration for laptop.
