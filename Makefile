system:
	sudo nixos-rebuild switch --flake .#$(hostname)

update:
	nix flake update

install:
	nix profile add .

check:
	nix flake check

list:
	nix run .#list-machines
