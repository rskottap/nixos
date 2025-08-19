# NixOS Modular Configuration

Always optimize your setup and workflows to make it super easy to get started, improve and iterate. 

OBEY ME.
🕶️✌️

---

## Repository Structure

This repository provides a modular NixOS configuration that supports:
- Multiple machines with different hardware configurations
- Machine-specific settings (hostname, timezone, packages, etc.)
- Shared modules for common functionality
- Easy addition of new machines

```
nixos/
├── flake.nix                    # Main flake with all machine configs
├── configuration.nix            # Legacy compatibility (points to church)
├── base/                        # Shared packages
├── overlay/                     # Shared overlays
├── machines/                    # Machine-specific configurations
│   ├── church/                  
│   │   ├── default.nix         # Machine config
│   │   └── hardware.nix        # Hardware config
│   └── curry/                   
│       ├── default.nix         
│       └── hardware.nix        
└── modules/                     # Shared NixOS modules
    ├── common.nix              # Common system configuration
    ├── desktop.nix             # Desktop environment
    └── users.nix               # User management
```

---

## NixOS Installation

### Initial Setup

Clone the repository and set up the symlink:
```bash
mkdir -pv ~/Desktop/repos
cd ~/Desktop/repos
git clone https://github.com/rskottap/nixos.git
cd nixos
sudo rm -rf /etc/nixos
ln -svf $PWD /etc/nixos
```
Setup NixOS configuration for your machine:
```
make update
make
```

---

## Nix Packages (Non-NixOS)

All core packages can be installed on any OS using Nix.

### Setup

In `/etc/nix/nix.conf` add:
```
experimental-features = nix-command flakes
```

### Install Packages

```bash
# Install all packages
nix profile add .

# Temporary development shell
nix develop .
```

---

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

# reboot
