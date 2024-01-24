{
  pkgs,
  inputs,
  lib,
  self,
  ...
}: {
  imports = [ ./config.nix];
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };
}
