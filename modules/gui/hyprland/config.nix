{
  pkgs,
  lib,
  self,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-1,2560x1440@144,0x0,auto,bitdepth,10"
        "DP-2,1920x1080@144,2560x420,auto"
      ];

      env = [
        "HYPRCURSOR_THEME,HyprBibataModernClassicSVG"
      ];

      exec-once = [
        "ags"
        # "hyprpaper"
        "firefox"
        # "webcord"
        "vesktop"
        "foot -s"
        "hypridle"
      ];

      input = {
        kb_layout = "no";
        accel_profile = "flat";
        sensitivity = "0";
      };

      "$primary_color" = "rgb(81171b)";
      "$secondary_color" = "rgb(ad2e24)";
      "$inactive_color" = "rgb(2a2b2a)";
      "$background_color" = "rgb(3a0603)";

      general = {
        gaps_in = "4";
        gaps_out = "8";
        border_size = "2";
        "col.active_border" = "$primary_color $secondary_color 45deg";
        "col.inactive_border" = "$inactive_color";
        layout = "dwindle";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = true;
        background_color = "$background_color";
      };

      workspace = [
        "11,monitor:DP-2,default:true"
        "12,monitor:DP-2"
        "13,monitor:DP-2"
        "14,monitor:DP-2"
        "15,monitor:DP-2"
      ];

      windowrulev2 = [
        "monitor 0,class:^(firefox)$"
        "monitor 1,class:^(WebCord)"
        "monitor 1,class:^(ArmCord)"
        "monitor 1,class:^(vesktop)"
      ];

      decoration = {
        rounding = "10";
        drop_shadow = "yes";
        shadow_range = "4";
        shadow_render_power = "3";
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, exec, footclient"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, R, exec, anyrun"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"

        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, code:67, workspace, 11"
        "$mod, code:68, workspace, 12"
        "$mod, code:69, workspace, 13"
        "$mod, code:70, workspace, 14"
        "$mod, code:71, workspace, 15"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, code:67, movetoworkspace, 11"
        "$mod SHIFT, code:68, movetoworkspace, 12"
        "$mod SHIFT, code:69, movetoworkspace, 13"
        "$mod SHIFT, code:70, movetoworkspace, 14"
        "$mod SHIFT, code:71, movetoworkspace, 15"

        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPrev,exec,playerctl previous"

        ",XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "$mod, XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        ''$mod SHIFT, S, exec, grim -g "$(slurp -w 0)" - | wl-copy -t image/png''
        "$mod SHIFT, C, exec, hyprpicker -f hex -a"
      ];

      binde = [
        ",XF86AudioRaiseVolume,exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        "$mod, XF86AudioRaiseVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"
        "$mod, XF86AudioLowerVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"

        "$mod SHIFT, up, resizeactive, 0 -100"
        "$mod SHIFT, down, resizeactive, 0 100"
        "$mod SHIFT, left, resizeactive, -100 0"
        "$mod SHIFT, right, resizeactive, 100 0"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
