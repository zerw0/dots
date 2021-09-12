# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


  let
    unstableTarball =
      fetchTarball
        https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;

in	
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # add home manager
      "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.editor = false;

  # ZFS Support
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.requestEncryptionCredentials = true;
  
  networking.hostId = "5ffde780";
  networking.hostName = "nix"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Sofia";
 
  # Doas
  security.doas.enable = true;
  security.doas.extraRules = [{
      groups = [ "wheel" ];
      keepEnv = true;
   }];

  # Browsing samba shares with GVFS
  services.gvfs.enable = true;

  # ADB
  programs.adb.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  #networking.useDHCP = false;
  #networking.interfaces.enp0s25.useDHCP = true;
  #networking.interfaces.wlo1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.hsphfpd.enable = true;

  # Pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
 };
  
  # TLP
  services.tlp.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dot = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" "libvirtd" "wireshark" "adbusers" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "";
    shell = pkgs.fish;
  };
  
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
    allowUnfree = true;
  };

  # Fonts
    fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerdfonts
  ];
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    
    # cli
    neovim
    coreutils
    wget
    man
    mkpasswd
    git
    fd
    bat
    stow
    doas
    neofetch
    htop
    xorg.xkill
    jdk11
    xclip
    exa
    newsboat
    ddgr
    googler
    wireguard-tools
    nmap
    any-nix-shell

    # gui
    firefox
    zathura
    sxiv
    libreoffice-still
    vscodium
    obs-studio
    dino
    discord
    viber
    bitwarden
    element-desktop
    gimp
    teams
    flameshot
    anydesk
    ungoogled-chromium
    kotatogram-desktop
    krita
    onionshare-gui
    tor-browser-bundle-bin
    remmina
    syncthing
    wireshark
    virt-manager
    kate
    zip
    unzip
    inkscape

    # media
    mpv
    youtube-dl
    ffmpeg
    qbittorrent
    audacity
    spotify
    ncspot
    jellyfin-mpv-shim
    jellyfin-media-player
    handbrake

    # dev
    nodejs
    python39Full

    # gaming
    steam
    minecraft
    lutris
    wine-staging

  ];

  # Fish
  programs.fish.enable = true;
  programs.fish.promptInit = ''
    any-nix-shell fish --info-right | source
  '';

  # QEMU/KVM
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  # Home Manager
  home-manager.users.dot = {pkgs, ... }: {

  programs.info.enable = true;

  home.packages = with pkgs; [
    capitaine-cursors
    papirus-icon-theme
    dracula-theme
    whitesur-icon-theme

  ];

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

 };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # ZFS Services
  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  

  nix.gc.automatic = true;
  nix.gc.dates = "00:00";
  system.autoUpgrade.enable = true;
  system.stateVersion = "21.05"; # Did you read the comment?

}

