# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-initialize-direnv-when-using-instant-prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-initialize-direnv-when-using-instant-prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

