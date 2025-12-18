####
## helper
####

V ?= 0
DRY ?= 0
PREFIX ?= ~/bin

echo := @echo
symlink := ln -rsf
rm := rm


####
## files
####

# format: <target>=<source>
files += \
	$(PREFIX)/git-all-push=git-all-push \
	$(PREFIX)/git-all-status=git-all-status \
	$(PREFIX)/git-reauther=git-reauthor \
	$(PREFIX)/git-versiontree=git-versiontree


####
## targets
####

help:
	$(echo) "Install files user local (install-user) or on system level (install-system).\n"
	$(echo) "Variables:"
	$(echo) "    V       enable verbose output"
	$(echo) "    DRY     print install commands without executing them"
	$(echo) "    PREFIX  user bin-directory prefix, default=$(PREFIX)"

.PHONY: install
install:
	@for pair in $(files); do \
		tgt=$$(echo $${pair} | cut -d '=' -f 1); \
		src=$$(echo $${pair} | cut -d '=' -f 2); \
		mkdir -p $$(dirname $${tgt}); \
		[ ! $V -eq 0 -o ! $(DRY) -eq 0 ] && echo [INSTALL] $${src} $${tgt}; \
		[ ! $(DRY) -eq 0 ] && true || $(symlink) $${src} $${tgt}; \
	done

.PHONY: uninstall
uninstall:
	@for pair in $(files); do \
		tgt=$$(echo $${pair} | cut -d '=' -f 1); \
		src=$$(echo $${pair} | cut -d '=' -f 2); \
		[ ! $V -eq 0 -o ! $(DRY) -eq 0 ] && echo [UNINSTALL] $${tgt}; \
		[ ! $(DRY) -eq 0 ] && true || $(rm) $${tgt}; \
	done
