system:
	sudo nixos-rebuild --print-build-logs switch --flake .#$(hostname)

update:
	nix flake update

install:
	nix profile add .

check:
	nix flake check

list:
	nix run .#list-machines
