.PHONY: all test

.PHONY: clean
clean:
	stow --delete base home laptop nas

.PHONY: base
base:
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
