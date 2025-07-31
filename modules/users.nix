{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.ramya = {
    isNormalUser = true;
    description = "Ramya";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    ];
  };

  # groups
  users.extraGroups.plocate.members = [ "ramya" ];

  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "ramya" ];
        commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; }
        ];
      }
    ];
  };

}
