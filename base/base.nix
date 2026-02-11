{ pkgs }: with pkgs; [
  # System utilities
  acpi
  hwinfo
  usbutils
  inotify-tools
  lsof
  htop
  neofetch
  tree
  plocate

  # Text editors and viewers
  vim
  gedit
  evince
  eog

  # Terminal and console
  gpm
  bash-completion
  coreutils

  ## man pages
  man
  man-pages
  linux-manual

  # Network tools
  nettools
  wget
  rsync
  openssh
  whois
  arp-scan
  nmap
  tor
  torsocks
  inetutils
  networkmanager
  openvpn3
  sshfs

  # Archive and file tools
  unzip
  dos2unix
  xclip
  xdotool
  file

  # Audio
  alsa-utils
  alsa-lib
  pavucontrol

  # Graphics and display
  mesa
  conky
  xorg.libXrandr
  scrot
  ffmpegthumbnailer

  # Image editing and viewing
  gimp
  imagemagick

  pdftotext

  # Office and productivity
  libreoffice

  # System configuration
  dconf
  dconf-editor

  # Disk and filesystem
  gparted
  dosfstools
  gnome-disk-utility

  # Media and video
  vlc
  yt-dlp
  simplescreenrecorder

  # Dev tools
  git
  github-cli
  gcc
  gnumake
  autoconf
  automake
  cmake
  binutils # strings
  jq
  strace
  ltrace

  # Games
  sl
  figlet
  cowsay
  xcowsay
  toilet
  asciiquarium
  cmatrix

  # Diff and merge tools
  meld

  # Input methods (Ibus)
  ibus
  #ibus-anthy
  #ibus-hangul
  #ibus-libpinyin

  # Nix
  nix-prefetch-github
  nixpkgs-review
  nixpkgs-lint

  # n8n
  nodejs

  zoom-us

  awscli2
]
