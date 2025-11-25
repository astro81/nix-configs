{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      cantarell-fonts
      fira-code-symbols
      nerd-fonts.fira-code
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Fira Code" ];    # terminals, editors, code blocks
        sansSerif = [ "Inter" ];        # websites, desktop UI, app menus 
        serif = [ "Noto Serif" ];       # pdf, word processors
      };
    };  
  };  
}
