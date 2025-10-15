# My dotfiles

These are my personal dotfiles. To use, install
[GNU Stow](https://www.gnu.org/software/stow) and clone this repository to the
home directory. Then, with this repo as your current working directory, use
`stow` for any of the following directories. I use `--no-folding` to avoid directory symlinking,
which can have problems when other tools store data in symlinked directories.

## dotfiles

### `base`

```console
stow --no-folding base
```

Base configuration for all environments.

### `home`

```console
stow --no-folding home
```

Configuration for home desktop.

### `nas`

```console
stow --no-folding nas
```

Configuration for Synology NAS.

## bootstrap steps

1. Clone the repository. If using nix, run `nix-shell -p git` to grab Git.

```console
git clone https://github.com/RyRose/.dotfiles.git ~/.dotfiles
```

1. `stow` the base and either home/nas/some other configuration. For nixos, run
   `nix develop` (alternatively `nix-shell`) to make `stow` available along with
   any other dependencies.
1. For write access to this repo, run `./utils/update_remote_to_ssh.sh` to update the
   git url to ssh and run `./utils/gen_github_key.sh` to generate an SSH key for
   github. Add this key here: <https://github.com/settings/keys>
1. For bootstrapping nixos, run `reload_nixos` to use the environment-specific
   script to reload nix at ~/.local/bin/reload_nixos.
