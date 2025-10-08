{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [ 
    # use modules from your own flake exports (modules/nixos):
    outputs.nixosModules.sddm-theme
    
    ./hardware-configuration.nix

  ];

  # Boot Loader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub = { 
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
    theme = pkgs.stdenv.mkDerivation {
      pname = "distro-grub-themes";
      version = "3.1";
      src = pkgs.fetchFromGitHub {
        owner = "AdisonCavani";
        repo = "distro-grub-themes";
        rev = "v3.1";
        hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
      };
      installPhase = "cp -r customize/nixos $out";
    };
  };

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


  # Enable Hyprland
  programs.hyprland.enable = true;
 
  # Udisks
  services.udisks2.enable = true;
  services.udisks2.mountOnMedia = true;
  services.udisks2.settings = {
    "udisks2.conf" = {
      defaults.encryption = "luks2";
      udisks2.modules = [ "*" ];
      udisks2.modules_load_preferences = "ondemand";
    };
  };

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
  users.users.astro = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; 
    packages = with pkgs; [];
    shell = pkgs.fish;
    useDefaultShell = true;
  };
 
  # Fish shell
  programs.fish.enable = true;

  # Polkit authentication	
  security.polkit.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    git
    neovim
    kitty
    nix-prefetch-git
    home-manager
  ];

  # Docker rootless
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;

  # Asus services
  #services.asusd.enable = true;
  #programs.rog-control-center.enable = true;

  # CPU mode
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";  # "ondemand", "powersave", "performance"
    
  # i2c for https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver
  hardware.i2c.enable = true;
  systemd.services.asus-touchpad-numpad.path = [ pkgs.i2c-tools ];
  systemd.services.asus-touchpad-numpad.script = ''
    cd ${pkgs.fetchFromGitHub {
      owner = "mohamed-badaoui";
      repo = "asus-touchpad-numpad-driver";
      # These needs to be updated from time to time
      rev = "c88315a3d0f8aa75aec84df8dd1abaf219f1b68d";
      sha256 = "0frjgg48mzkaj7q918dgl55rl5s8zpbray270fi9z738anhvp2j4"; 
    }}
    # In the last argument here you choose your layout.
    ${pkgs.python3.withPackages(ps: [ ps.libevdev ])}/bin/python asus_touchpad.py m433ia
  ''; 
  systemd.services.asus-touchpad-numpad.serviceConfig.RestartSec = "1s";
  systemd.services.asus-touchpad-numpad.serviceConfig.Restart = "on-failure";
  systemd.services.asus-touchpad-numpad.wantedBy = [ "multi-user.target" ];


  system.stateVersion = "25.05"; 

}

