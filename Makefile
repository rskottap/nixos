system:
	sudo nixos-rebuild --print-build-logs switch --flake .#$(hostname)

update:
	nix flake update

home:
	nix flake update ramya-home

install:
	nix profile add .

check:
	nix flake check

list:
	nix run .#list-machines
