{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/common.nix
    ../../modules/desktop.nix
    ../../modules/users.nix
  ];

  # Machine-specific settings
  networking.hostName = "church";

  # Machine-specific configurations can go here
  # For example, if this machine needs specific services or hardware support

  machine.additionalPackages = with pkgs; [
    kdePackages.kdenlive
    # Nvidia packages for church machine
    #linuxPackages.nvidia_x11 # Xorg driver and kernel module, includes nvidia-smi + nvidia-settings
    #cudatoolkit
    #cudaPackages.cudnn
    #cudaPackages.cuda_nvcc
  ];

  #services.xserver.videoDrivers = [ "nvidia" ];

  #hardware = {
  #  opengl.enable = true;
  #  nvidia = {
  #    modesetting.enable = true;
  #    powerManagement.enable = true;
  #    nvidiaPersistenced = true;
  #    open = false;  # use the proprietary driver (recommended for CUDA)
  #  };
  #};

  # Boot kernel modules
  #boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  #boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
}
