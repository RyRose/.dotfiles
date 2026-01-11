# Initialize opam if available
[ -f ~/.opam/opam-init/init.zsh ] && source ~/.opam/opam-init/init.zsh

# Initialize env if available.
[ -f ~/.local/bin/env ] && . ~/.local/bin/env

# Initialize home-manager session variables if available.
[ -f /etc/profiles/per-user/"${USER}"/etc/profile.d/hm-session-vars.sh ] && source /etc/profiles/per-user/"${USER}"/etc/profile.d/hm-session-vars.sh
