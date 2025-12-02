{ inputs, outputs, config, pkgs, ... }:

{
  imports = [ 
    # use modules from your own flake exports (from modules/home-manager):
    outputs.homeManagerModules.bat
    outputs.homeManagerModules.cava
    outputs.homeManagerModules.direnv
    outputs.homeManagerModules.fish
    outputs.homeManagerModules.git
    outputs.homeManagerModules.hypr
    outputs.homeManagerModules.hyprpaper
    outputs.homeManagerModules.kitty
    outputs.homeManagerModules.rofi
    outputs.homeManagerModules.spotify 
    outputs.homeManagerModules.starship
    outputs.homeManagerModules.tmux

    # Or modules exported from other flakes (such as nix-colors):
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.file = {};
  home.username = "astro";
  home.homeDirectory = "/home/astro";
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    XCURSOR_THEME = "Bibata-Modern-Classic";
  };

  home.packages = with pkgs; [
    gotop
    brightnessctl
    brave
    htop
    tree
    cava
    dunst
    feh
    pavucontrol
    tldr
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.okular
    hyprpolkitagent
    lm_sensors
    wmctrl
    eww
    # pulseaudio
    grim 
    slurp
    swappy
    unzip
    zip
    rar
  ];


  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 22;
  };


  gtk = {
    enable = true;
    
    theme.name = "Tokyonight-Dark-BL";
    theme.package = pkgs.tokyo-night-gtk;
   
    font.name = "Cantarell";
    font.size = 12;
      
    iconTheme.name = "Tela-circle-dracula";
    iconTheme.package = pkgs.tela-circle-icon-theme;
  
    gtk3.extraConfig = {
      gtk-button-images = 1;
      gtk-menu-images = 1;
      gtk-enable-event-sounds = 1;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias= 1 ;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";  
      gtk-cursor-blink = true;
      gtk-recent-files-limit = 20;
      gtk-application-prefer-dark-theme=1;
    };
  	
  };

  services.udiskie.enable = true;
  services.udiskie.automount = true;
  services.udiskie.notify = true;
  services.udiskie.tray = "auto";

  home.stateVersion = "24.11"; 
  programs.home-manager.enable = true;
}
