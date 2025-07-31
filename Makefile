system:
	sudo nixos-rebuild switch --flake .#

update-home:
	nix flake lock --update-input ramya-home

install:
	nix profile add .
