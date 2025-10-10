{ config, pkgs, ... }:

let
  rofiBg = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/astro81/nix-configs/main/assets/rofi/rofi-bg.jpg";
    sha256 = "1i18asbh46ggi5lvygv5akwp6l0hggmhv9vbahdq4biyxnkkrdaq";
  };

  # Fetch the image from your GitHub repository
  # rofiBg = pkgs.fetchFromGitHub {
  #   owner = "astro81"; 
  #   repo = "nix-configs";          
  #   rev = "bd880d34abc5d4c23eaaa34fa6bfc90f723c1b50";                   
  #   sha256 = "sha256-h1zfSutV/jTNrSiVS3UKbKvtUUPZKan0GakQq0sS1MI="; 
  #   fetchSubmodules = false;
  # } + "/assets/rofi/rofi-bg.jpg";
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    cycle = true;
    # configPath = "$XDG_CONFIG_HOME/rofi/config.rasi";
    font = "Cantarell 12";

    extraConfig = {
      modi = "drun,filebrowser,window,run";
      terminal = "kitty";
      show-icons = true;
      icon-theme = "Tela-circle-dracula";
      display-drun = "";
      display-run = "";
      display-window = "";
      display-filebrowser = "";
      #display-emoji = "󰞅";
      #display-calc = "󰃬";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      window-format = "{w}{t}";
    };

    theme = let 
      inherit (config.lib.formats.rasi) mkLiteral; 
    in {
      "*" = { 
        main-bg = mkLiteral "#11111be6"; 
        main-fg = mkLiteral "#cdd6f4ff"; 
        main-br = mkLiteral "#cba6f7ff"; 
        main-ex = mkLiteral "#f5e0dcff"; 
        select-bg = mkLiteral "#b4befeff"; 
        select-fg = mkLiteral "#11111bff"; 
        separatorcolor = mkLiteral "transparent"; 
        border-color = mkLiteral "transparent"; 
      };

      "window" = { 
        height = mkLiteral "24em"; 
        width = mkLiteral "48em"; 
        transparency = "real"; 
        fullscreen = false; 
        enabled = true; 
        cursor = "default"; 
        spacing = mkLiteral "0em"; 
        padding = mkLiteral "0em"; 
        border-color = mkLiteral "@main-br"; 
        background-color = mkLiteral "@main-bg"; 
      };

      "mainbox" = { 
        enabled = true; 
        spacing = mkLiteral "0em"; 
        padding = mkLiteral "0em"; 
        orientation = mkLiteral "horizontal"; 
        children = mkLiteral "[\"dummywall\", \"listbox\"]"; 
        background-color = mkLiteral "transparent"; 
      }; 
	
      "dummywall" = { 
        spacing = mkLiteral "0em"; 
        padding = mkLiteral "0em"; 
        width = mkLiteral "27em"; 
        expand = false; 
        orientation = mkLiteral "horizontal"; 
        children = mkLiteral "[\"mode-switcher\", \"inputbar\"]"; 
        background-color = mkLiteral "transparent"; 	
        background-image = mkLiteral "url('${rofiBg}', height)"; 
      };      

      "mode-switcher" = { 
        orientation = mkLiteral "vertical"; 
        enabled = true; 
        width = mkLiteral "3.4em"; 
        padding = mkLiteral "4em 0.1em 4em 0.1em"; 
        margin = mkLiteral "0 0 0 0.2em"; 
        spacing = mkLiteral "1.2em"; 
        background-color = mkLiteral "transparent"; 
        background-image = mkLiteral "url('${rofiBg}', height)"; 
      };

      "button" = { 
        cursor = "pointer"; 
        border-radius = mkLiteral "2em"; 
        background-color = mkLiteral "@main-bg"; 
        text-color = mkLiteral "@main-fg"; 
      }; 

      "button selected" = { 
        background-color = mkLiteral "@main-fg"; 
        text-color = mkLiteral "@main-bg"; 
      };
      
      "inputbar" = { 
        enabled = true; 
        children = mkLiteral "[\"entry\"]"; 
        background-color = mkLiteral "transparent"; 
      }; 
      "entry" = { enabled = false; };

      "listbox" = { 
        spacing = mkLiteral "0em"; 
        padding = mkLiteral "1em"; 
        children = mkLiteral "[\"dummy\", \"listview\", \"dummy\"]"; 
        background-color = mkLiteral "transparent"; 
      }; 
      
      "listview" = { 
        enabled = true; 
        spacing = mkLiteral "0em"; 
        padding = mkLiteral "2em 0em 2em 1em"; 
        columns = 1; 
        lines = 8; 
        cycle = true; 
        dynamic = true; 
        scrollbar = false; 
        layout = mkLiteral "vertical"; 
        reverse = false; 
        expand = false; 
        fixed-height = true; 
        fixed-columns = true; 
        cursor = "default"; 
        background-color = mkLiteral "transparent"; 
        text-color = mkLiteral "@main-fg"; 
      }; 
      
      "dummy" = { 
        background-color = mkLiteral "transparent"; 
      }; 

      "element" = { 
        enabled = true; 
        spacing = mkLiteral "0.4em"; 
        padding = mkLiteral "0.4em 0.5em"; 
        cursor = "pointer"; 
        background-color = mkLiteral "transparent"; 
        text-color = mkLiteral "@main-fg"; 
        border-radius = mkLiteral "0.3em"; 
      }; 
      "element selected.normal" = { 
        background-color = mkLiteral "@select-bg"; 
        text-color = mkLiteral "@select-fg"; 
      }; 
      "element-icon" = { 
        size = mkLiteral "1.8em"; 
        cursor = "inherit"; 
        background-color = mkLiteral "transparent"; 
        text-color = mkLiteral "inherit"; 
      }; 
      "element-text" = { 
        vertical-align = mkLiteral "0.5"; 
        horizontal-align = mkLiteral "0.0"; 
        cursor = "inherit"; 
        background-color = mkLiteral "transparent"; 
        text-color = mkLiteral "inherit"; 
      }; 

      "error-message" = { 
        text-color = mkLiteral "@main-fg"; 
        background-color = mkLiteral "@main-bg"; 
        text-transform = mkLiteral "capitalize"; 
        children = mkLiteral "[\"textbox\"]"; 
      }; 
      
      "textbox" = { 
        text-color = mkLiteral "inherit"; 
        background-color = mkLiteral "inherit"; 
        vertical-align = mkLiteral "0.5"; 
        horizontal-align = mkLiteral "0.5"; 
      }; 


    };

  };
}
