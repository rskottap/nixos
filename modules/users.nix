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

}
