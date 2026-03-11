{ pkgs, ... }:
{
  # Boot Loader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.loader.systemd-boot.enable = true;
  
  # boot.loader.grub.enable = true;
  # boot.loader.grub.devices = [ "nodev" ];
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.useOSProber = true;
  
  # boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
  #   pname = "sekiro_grub_theme";
  #   version = "1b1e3840e9c378f4400bed2a8940f4ded364ba3f";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "semimqmo";
  #     repo = "sekiro_grub_theme";
  #     rev = "1b1e3840e9c378f4400bed2a8940f4ded364ba3f";
  #     hash = "sha256-uXwDjb0+ViQvdesG5gefC5zFAiFs/FfDfeI5t7vP+Qc=";
  #   };
  #
  #   installPhase = ''
  #     mkdir -p $out
  #     cp -r . $out
  #   '';
  # };
  

#   boot.loader.grub = { 
#     enable = true;
#     devices = [ "nodev" ];
#     efiSupport = true;
#     useOSProber = true;
#     theme = pkgs.stdenv.mkDerivation {
#       pname = "distro-grub-themes";
#       version = "3.1";
#       src = pkgs.fetchFromGitHub {
#         owner = "AdisonCavani";
#         repo = "distro-grub-themes";
#         rev = "v3.1";
#         hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
#       };
#       installPhase = "cp -r customize/nixos $out";
#     };
#   };


}
