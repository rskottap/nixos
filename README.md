# Nixos

Always optimize your setup and workflows to make it super easy to get started, improve and iterate. 


OBEY ME.
🕶️✌️

---
## Install Nix and Home Manager

Uses the official nix installer:
```bash
./install-nix-package-manager.sh install
sudo reboot
./install-nix-package-manager.sh channel
./install-nix-package-manager.sh home-manager
```

## NixOS

On NixOS simply symlink /etc/nixos to your repo:
```bash
sudo rm -rf /etc/nixos
ln -svf $PWD /etc/nixos
```

Inside /etc/nixos run:
```bash
nixos-rebuild switch
```

## Nix Packages

All my core common packages (devtools, apps, python, fonts etc.,) in one place so I can install them using nix on any OS. See `flake.nix` for included OSes.

Same packages included in configuration.nix for NixOS.

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

## Completely Uninstall Nix
```bash
nix profile wipe-history
nix store gc # garbage collect
rm -rf ~/.nix-profile ~/.nix-defexpr ~/.cache/nix ~/.local/state/nix ~/.nix* ~/.config/nixpkgs
sudo rm -rf /nix /etc/nix
sudo rm -f /etc/profile.d/nix.sh
sudo rm -f /etc/bashrc.d/nix.sh
sudo rm -f /etc/zshrc.nix
sudo rm -rf /etc/tmpfiles.d/nix-daemon.conf

# Linux with systemd
sudo systemctl stop nix-daemon.service
sudo systemctl disable nix-daemon.socket nix-daemon.service
sudo systemctl daemon-reload

# Remove Nix build users and their group
for i in $(seq 1 32); do sudo userdel nixbld$i; done
sudo groupdel nixbld

# MacOS
# Edit fstab to remove the Nix Store volume mount:
# Use sudo vifs to edit /etc/fstab and remove the line mounting /nix.
# Edit /etc/synthetic.conf:
# Remove the nix line from /etc/synthetic.conf or if it's the only line, you can delete the file.

# reboot
```
