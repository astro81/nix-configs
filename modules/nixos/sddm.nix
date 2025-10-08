{ pkgs, config, ... }: 
let
  sddmTheme = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
  };
in {
  environment.systemPackages = [ sddmTheme ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    
    package = pkgs.kdePackages.sddm;
    
    theme = "sddm-astronaut-theme";
    extraPackages = [ sddmTheme ];
  };

}


