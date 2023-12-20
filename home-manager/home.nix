{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}: {
  imports = [ 
    inputs.neovim-flake.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    ../modules
  ];

  home = {
    username = "donnan";
    homeDirectory = "/home/donnan";
    stateVersion = "23.05";
  };
  
  programs = {
  
    git = {
      enable = true;
      userName = "Donnerinoern";
      userEmail = "72634505+Donnerinoern@users.noreply.github.com";
    };
      
    vscode = {
      enable = true;
      package = pkgs.vscodium;
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

    helix = {
      enable = true;
      settings = {
        theme = "merionette";
      };
    };

    htop.enable = true;
    btop.enable = true;
    firefox.enable = true;
    mpv.enable = true;
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
