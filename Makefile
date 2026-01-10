.PHONY: all test

.PHONY: help
help:
	@echo "Makefile targets:"
	@echo "  make clean    - Remove all configurations"
	@echo "  make laptop   - Apply laptop-specific configuration"
	@echo "  make home     - Apply home-specific configuration"
	@echo "  make nas      - Apply NAS-specific configuration"

.PHONY: clean
clean:
	stow --delete base
	stow --delete basedirs
	stow --delete home
	stow --delete laptop
	stow --delete nas

.PHONY: base
base: clean
	stow --no-folding --restow basedirs
	stow --restow base


.PHONY: laptop
laptop: base
	stow --restow laptop

.PHONY: home
home: base
	stow --restow home

.PHONY: nas
nas: base
	stow --restow nas
