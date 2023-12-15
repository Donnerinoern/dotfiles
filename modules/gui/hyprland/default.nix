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
    #xdg.portal = {
    #  enable = true;
    #  extraPortals = [
    #    pkgs.xdg-desktop-portal-gtk
    #    inputs.xdg-desktop-portal-hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    #  ];
    #};
    #home-manager.users.donnan = {
      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };
    #};
  };
}
