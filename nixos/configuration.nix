{ inputs, outputs, config, lib, pkgs, username, ... }:

{
  imports = [ 
    # use modules from your own flake exports (modules/nixos):
    outputs.nixosModules.asus-service
    outputs.nixosModules.boot-grub
    outputs.nixosModules.fonts
    outputs.nixosModules.sddm-theme
    outputs.nixosModules.container

    ./hardware-configuration.nix

  ];


  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;  

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Xserver
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.desktopManager.plasma6.enable = true;


  # Enable Hyprland
  # programs.hyprland.enable = true;

  # Udisks
  # services.udisks2.enable = true;
  # services.udisks2.mountOnMedia = true;
  # services.udisks2.settings = {
  # "udisks2.conf" = {
  #     defaults.encryption = "luks2";
  #     udisks2.modules = [ "*" ];
  #     udisks2.modules_load_preferences = "ondemand";
  #   };
  # };

  # Audio Service.
  security.rtkit.enable = true;
  
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  # Video Support
  hardware.graphics.enable = true;

  # Mount, trash, other functionalities
  services.gvfs.enable = true;

  # Define a user account. 
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; 
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
 
  # Fish shell
  programs.fish.enable = true;

  # Polkit authentication	
  # security.polkit.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    git
    neovim
    kitty
    nix-prefetch-git
    home-manager
    dotnet-sdk_10
    python315
  ];

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.plasma-browser-integration
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
  ];

  system.stateVersion = "25.11"; 

}

