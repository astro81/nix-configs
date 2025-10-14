{ pkgs, ... }:
{
  # Asus services
  #services.asusd.enable = true;
  #programs.rog-control-center.enable = true;

  services.upower.enable = true;

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
}
