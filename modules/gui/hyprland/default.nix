{
  pkgs,
  inputs,
  lib,
  self,
  ...
}: let 
  inherit (inputs.hyprland.packages.${pkgs.system}) hyprland;
in {
  imports = [ ./config.nix];
  config = {
   wayland.windowManager.hyprland = {
     enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };
}
