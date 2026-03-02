{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager.cinnamon.enable = true;
    displayManager.lightdm.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      #options = "caps:escape";
    };
  };

  # make Caps=Esc also work on TTY/console
  #console.useXkbConfig = true;
}
