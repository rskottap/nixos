# Nix Packages

All my core common packages (devtools, apps, python, fonts etc.,) in one place so I can install them using nix on any OS. See `flake.nix` for included OSes.

In `/etc/nix/nix.conf` add:
```
experimental-features = nix-command flakes
```

After installing nix on the system, run:
```bash
nix profile add .
```

For a temp dev shell:
```bash
nix develop .
```

Completely uninstall everything nix:
```bash
nix profile wipe-history
nix store gc # garbage collect
rm -rf ~/.nix-profile ~/.nix-defexpr ~/.cache/nix ~/.local/state/nix ~/.nix* ~/.config/nixpkgs
sudo rm -rf /nix/
sudo rm -f /etc/profile.d/nix.sh
sudo rm -f /etc/bashrc.d/nix.sh
sudo rm -f /etc/zshrc.nix
```
