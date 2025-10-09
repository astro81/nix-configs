{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      cantarell-fonts
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono" ];
        cantarell = [ "Cantarell" ];
      };
    };  
  };  
}
