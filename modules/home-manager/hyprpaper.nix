{ pkgs, ... }:

let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/astro81/nix-configs/main/assets/rofi/rofi-bg.jpg";
    sha256 = "1i18asbh46ggi5lvygv5akwp6l0hggmhv9vbahdq4biyxnkkrdaq";
  };
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ wallpaper ];
      wallpaper = [ wallpaper ];
    };
  };

  home.packages = with pkgs; [ hyprpaper ];
}
