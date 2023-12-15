{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  config = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          layer = "top";
          height = 30;
          spacing = 4;
          margin-top = 4;
          margin-left = 8;
          margin-right = 8;
          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = ["idle_inhibitor" "wireplumber" "network" "cpu" "memory" "clock#2" "clock" "tray"];

          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          "clock" = {
          };
                        
          "clock#2" = {
            format = "{:%A | %d-%m-%Y}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          "cpu" = {
            format = "{usage}% ";
            tooltip = false;
          };

          "memory" = {
            format = "{}% ";
          };

          "network" = {
            format-ethernet = "{ipaddr}";
            format-disconnected = "Disconnected ⚠";
          };

          "wireplumber" = {
          };

          "tray" = {
            spacing = 10;
          };
        };
      };
      style = ./style.css;
    };
  };
}
