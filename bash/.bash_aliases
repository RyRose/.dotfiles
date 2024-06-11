if [ -d .bash ]; then
  for file in .bash/*.sh; do
    if [ -f ${file} ]; then
      source "${file}"
    fi
  done
fi

alias ..='cd ..'
alias :q="exit"
alias :wq="exit"
alias blaze='bazel'
alias idate="date --iso-8601"
alias jl='jupyter lab'
alias jn='jupyter notebook'
alias sl='ls'

alias vim='nvim'
