{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Enable Lightdm and Cinnamon
    desktopManager.cinnamon.enable = true;

    displayManager.lightdm = {
      enable = true;
    };

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
};
}
