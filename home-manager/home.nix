{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}: let
  # cursorName = "Catppuccin-Mocha-Dark-Cursors";
  # cursorPackage = pkgs.catppuccin-cursors.mochaDark;
  cursorName = "phinger-cursors";
  cursorPackage = pkgs.phinger-cursors;
in {
  imports = [ 
    inputs.neovim-flake.homeManagerModules.default
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    ../modules
  ];

  home = {
    username = "donnan";
    homeDirectory = "/home/donnan";
    stateVersion = "24.05";
    pointerCursor = {
      gtk.enable = true;
      name = cursorName;
      package = cursorPackage;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  gtk = {
    enable = true;
    theme = { 
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    cursorTheme = {
      package = cursorPackage;
      name = cursorName;
    };
  };
  
  programs = {
    yazi = {
      enable = true;
    };

    ags = {
      enable = true;
      configDir = ../modules/gui/ags;
    };
  
    git = {
      enable = true;
      userName = "Donnerinoern";
      userEmail = "72634505+Donnerinoern@users.noreply.github.com";
    };
      
    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Iosevka Medium:size=12";
        };
        colors = {
          background = "540804ff";
          selection = "ad2e24ff";
          border = "81171bff";
          text = "ffffffff";
          selection-text = "ffffffff";
        };
        border.width = "2";
      };
    };

    btop.enable = true;
    firefox.enable = true;
    mpv.enable = true;
    fzf.enable = true;
    fish.enable = true;
  };
    
  services = {
    fnott = {
      enable = true;
      configFile = ./fnott.ini;
    };

    playerctld.enable = true;
    udiskie.enable = true;
  };
}
