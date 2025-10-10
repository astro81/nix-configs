{ pkgs, ... }:

let
  wallpaperPath = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/astro81/nix-configs/main/assets/background/guweiz.jpg";
    sha256 = "1y9ahabwjmcmpphdg2wix25hqlzg5c29fmsl9dss2jqqkw1gdzqs";
  };

  # Hyprpaper expects strings in format: "monitor, /nix/store/..."
  formattedWallpaper = ", ${toString wallpaperPath}";
in
{
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      # preload is just a list of paths
      preload = [ "${toString wallpaperPath}" ];

      # wallpaper must be in "monitor, path" format
      wallpaper = [ formattedWallpaper ];
    };
  };
}
