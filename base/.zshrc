# Load zsh configuration.
for file in ~/.config/zsh/*.zsh; do
	[ -f "$file" ] && source "$file"
done
