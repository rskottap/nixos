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
│   ├── church/                  # Desktop machine
│   │   ├── default.nix         # Machine config
│   │   └── hardware.nix        # Hardware config
│   └── curry/                   # Another machine
│       ├── default.nix         # Machine config
│       └── hardware.nix        # Hardware config
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

---

## Adding New Machines

### Manual Setup

1. **Create machine directory:**
   ```bash
   mkdir -p machines/my-new-machine
   ```

2. **Create `machines/my-new-machine/default.nix`:**
   ```nix
   { config, pkgs, ... }:
   {
     imports = [
       ./hardware.nix
       ../../modules/common.nix
       ../../modules/desktop.nix
       ../../modules/users.nix
     ];
     
     networking.hostName = "my-new-machine";
     # Add machine-specific settings here
   }
   ```

3. **Create `machines/my-new-machine/hardware.nix`:**
   - Run `sudo nixos-generate-config --show-hardware-config` on the target machine
   - Copy the output to this file

4. **Add to `flake.nix`:**
   ```nix
   machines = {
     # ... existing machines ...
     my-new-machine = {
       name = "my-new-machine";
       system = "x86_64-linux";
     };
   };
   ```

5. **Deploy:**
   ```bash
   sudo nixos-rebuild switch --flake .#my-new-machine
   ```

---

## Machine-Specific Configurations

Each machine can have its own settings in `machines/<name>/default.nix`:

```nix
{ config, pkgs, ... }:
{
  imports = [ /* ... */ ];
  
  networking.hostName = "work-laptop";
  
  # Work-specific timezone
  time.timeZone = "America/New_York";
  
  # Work-specific packages (ADDS to base packages, doesn't replace them)
  machine.additionalPackages = with pkgs; [
    teams-for-linux  # Use teams-for-linux on Linux, teams on macOS
    thunderbird      # Email client
    slack
    # other work tools
  ];
  
  # Work-specific services
  services.openvpn.servers = {
    work-vpn = {
      config = "/etc/openvpn/work.conf";
    };
  };
}
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

## Supported Systems

- `x86_64-linux` (Intel/AMD 64-bit Linux)
- `aarch64-linux` (ARM 64-bit Linux)
- `x86_64-darwin` (Intel Mac)

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

# MacOS
# Edit fstab to remove the Nix Store volume mount:
# Use sudo vifs to edit /etc/fstab and remove the line mounting /nix.
# Edit /etc/synthetic.conf:
# Remove the nix line from /etc/synthetic.conf or if it's the only line, you can delete the file.

# reboot
