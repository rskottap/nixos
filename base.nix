{ pkgs }: with pkgs; [
  vim
  acpi
  gpm
  nettools
  alsa-utils
  alsa-lib
  wget
  rsync
  unzip
  openssh
  whois
  man
  man-pages
  arp-scan
  nmap
  tor
  torsocks
  lsof
  mlocate
  plocate
  tree
  figlet
  cowsay
  xcowsay
  toilet
  asciiquarium
  cmatrix
  fbida
  dos2unix
  xclip
  xdotool
  mesa
  conky
  hwinfo
  inotify-tools
  inetutils
  dconf-editor
  evince
  eog
  gimp
  gparted
  dosfstools
  libreoffice
  vlc
  scrot
  gnome-screenshot
  ffmpegthumbnailer
  gedit
  meld
  lightdm-gtk-greeter
  lightdm-slick-greeter
  pavucontrol
  gnome-disk-utility
  sshfs
  
  ### Make it pretty
  neofetch

  ### Videos and Editing
  yt-dlp
  simplescreenrecorder
  
  ### Ibus
  ibus
  #ibus-anthy
  #ibus-hangul
  #ibus-libpinyin
  
  ### Other
  htop
  imagemagick
  networkmanager
  autoconf
  automake
  bash-completion
  cmake
  coreutils
  dconf
  usbutils
  xorg.libXrandr
  git
  github-cli
  jq
  strace
  ltrace
  binutils #strings
]