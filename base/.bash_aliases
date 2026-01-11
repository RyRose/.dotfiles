# Load bash configuration.
for file in ~/.config/bash/*.sh; do
	[ -f "$file" ] && source "$file"
done
