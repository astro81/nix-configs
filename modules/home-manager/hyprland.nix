{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      ### MONITORS ###
      monitor = [ "eDP-1,1920x1080,0x0,1" ];
      # monitor = [",preferred,auto,1"];

      ### AUTOSTART ###
      exec-once = [
        "hyprpaper"
        "systemctl --user start hyprpolkitagent"
      ];

      ### ENVIRONMENT VARIABLES ###
      env = [
        "XCURSOR_SIZE,22"
        "HYPRCURSOR_SIZE,22"
      ];

      ### LOOK AND FEEL ###
      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        resize_on_border = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.92;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 4;
          passes = 1;
          vibrancy = 0.1696;
          new_optimizations = "on";
        };
      };

      animations = {
        enabled = "yes";
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, once"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };

      ### INPUT ###
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      ### WINDOWS AND WORKSPACES ###
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      layerrule = [
        "blur,rofi"
        "ignorezero,rofi"
        "blur,notifications"
        "ignorezero,notifications"
      ];

      ### MY PROGRAMS ###
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun";
      "$browser" = "brave";

      
      ### KEYBINDINGS ###
      "$mainMod" = "SUPER";

      "$l" = "Launcher";
      "$d" = "[$l|Apps]";
      "$wm" = "Window Management";
      "$ws" = "Workspaces";
      bindd = [
        # Apps
        "$mainMod, Return, $d terminal emulator, exec, $terminal"
        "$mainMod, W, $d web browser, exec, $browser"
        "$mainMod, f, $d file explorer, exec, $fileManager"

        # Launcher|Rofi
        "$mainMod, R, [$l|Rofi] run launcher, exec, $menu"
        "$mainMod, H, [$l|Rofi] keybindings hint, exec, ~/.config/hypr/scripts/keybinds_rofi.py"
        "$mainMod, V, [$l|Rofi] clipboard, exec, pkill -x rofi || $scrPath/cliphist.sh -c"
        "$mainMod, M, [$l|Rofi] exit, exit,"

        # Eww
        "$mainMod, D, [Open Dashboard], exec, eww open dashboard"
        "$mainMod Shift, D, [Close Dashboard], exec, eww close dashboard"

        # Window Management
        "$mainMod, V, [$wm] Toggle floating, togglefloating,"
        "$mainMod, C, [$wm] kill active window, killactive,"

        # Window Management|Change focus
        "$mainMod, SPACE, [$wm|Change focus] Cycle focus, cyclenext"
        "$mainMod, left, [$wm|Change focus] focus left, movefocus, l"
        "$mainMod, right, [$wm|Change focus] focus right, movefocus, r"
        "$mainMod, up, [$wm|Change focus] focus up, movefocus, u"
        "$mainMod, down, [$wm|Change focus] focus down, movefocus, d"

        # Window Management|Layout
        "$mainMod, P, $d Pseude, pseudo, "
        "$mainMod, J, $d Toggle split, togglesplit, "

        # Workspaces|Navigation
        "$mainMod, 1, [$ws|Navigation] navigate to workspace 1, workspace, 1"
        "$mainMod, 2, [$ws|Navigation] navigate to workspace 2, workspace, 2"
        "$mainMod, 3, [$ws|Navigation] navigate to workspace 3, workspace, 3"
        "$mainMod, 4, [$ws|Navigation] navigate to workspace 4, workspace, 4"
        "$mainMod, 5, [$ws|Navigation] navigate to workspace 5, workspace, 5"
        "$mainMod, 6, [$ws|Navigation] navigate to workspace 6, workspace, 6"
        "$mainMod, 7, [$ws|Navigation] navigate to workspace 7, workspace, 7"
        "$mainMod, 8, [$ws|Navigation] navigate to workspace 8, workspace, 8"
        "$mainMod, 9, [$ws|Navigation] navigate to workspace 9, workspace, 9"
        "$mainMod, 0, [$ws|Navigation] navigate to workspace 10, workspace, 10"

        #Workspaces|Move window to workspace
        "$mainMod Shift, 1, $d move to workspace 1 , movetoworkspace, 1"
        "$mainMod Shift, 2, $d move to workspace 2 , movetoworkspace, 2"
        "$mainMod Shift, 3, $d move to workspace 3 , movetoworkspace, 3"
        "$mainMod Shift, 4, $d move to workspace 4 , movetoworkspace, 4"
        "$mainMod Shift, 5, $d move to workspace 5 , movetoworkspace, 5"
        "$mainMod Shift, 6, $d move to workspace 6 , movetoworkspace, 6"
        "$mainMod Shift, 7, $d move to workspace 7 , movetoworkspace, 7"
        "$mainMod Shift, 8, $d move to workspace 8 , movetoworkspace, 8"
        "$mainMod Shift, 9, $d move to workspace 9 , movetoworkspace, 9"
        "$mainMod Shift, 0, $d move to workspace 10 , movetoworkspace, 10"

        # Workspaces|Scratchpad
        "$mainMod, S, [$ws|Navigation|Special workspace] toggle scratchpad, togglespecialworkspace, magic"
        "$mainMod Shift, S, [$ws|Navigation|Special workspace] move to scratchpad, movetoworkspace, special:magic"

        # Workspaces|Mouse Actions
        "$mainMod, mouse_down, [$ws|Scroll] Next, workspace, e+1"
        "$mainMod, mouse_up, [$ws|Scroll] Previous, workspace, e-1"
      ];

      bindde = [
        #Window Management|Resize Active Window
        "$mainMod CONTROL, Right, [$wm|Resize Active Window] resize window right, resizeactive, 10 0"
        "$mainMod CONTROL, Left, [$wm|Resize Active Window] resize window left, resizeactive, -10 0"
        "$mainMod CONTROL, Up, [$wm|Resize Active Window] resize window up, resizeactive, 0 -10"
        "$mainMod CONTROL, Down, [$wm|Resize Active Window] resize window down, resizeactive, 0 10"
      ];

      binddm = [
        #Window Management|Move & Resize with mouse
        "$mainMod, mouse:272, [Move & Resize] hold to move window, movewindow"
        "$mainMod, mouse:273, [Move & Resize] hold to resize window, resizewindow"
      ];

      binddel = [
        # Brightness
        ",XF86MonBrightnessUp, [Hardware|Brightness] increase brightness, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, [Hardware|Brightness] decrease brightness, exec, brightnessctl -e4 -n2 set 5%-"
        
        # Audio
        ",XF86AudioRaiseVolume, [Hardware|Audio] increase volume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, [Hardware|Audio] decrease volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, [Hardware|Audio] toggle mute output, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, [Hardware|Audio] toggle microphone mute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      binddl = [
        # Media
        ",XF86AudioPause, [Hardware|Media] pause media, exec, playerctl play-pause"
        ",XF86AudioPlay, [Hardware|Media] play media, exec, playerctl play-pause"
        ",XF86AudioNext, [Hardware|Media] next media, exec, playerctl next"
        ",XF86AudioPrev, [Hardware|Media] previous media, exec, playerctl previous"
      ];
    };
  };
}
