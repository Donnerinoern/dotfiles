{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}: let
  cursorName = "phinger-cursors";
  cursorPackage = pkgs.phinger-cursors;
in {
  imports = [ 
    inputs.neovim-flake.homeManagerModules.default
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    inputs.anyrun.homeManagerModules.default
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
    packages = with pkgs; [
      xdg-utils
      eza
      elixir
      hugo
      emacs
      gdb
      prismlauncher
      jdk21
      inputs.hyprpaper.packages.${system}.default
      inputs.hyprpicker.packages.${system}.default
      inputs.hypridle.packages.${system}.default
      inputs.hyprlock.packages.${system}.default
      inputs.hyprcursor.packages.${system}.default
      texliveBasic
      zoom-us
      alacritty
    ];
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        inputs.hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland
      ];
    };
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
      enableFishIntegration = true;
      theme = {
        manager = [
          { cwd = { fg = "#83a598"; };}
          { hovered = { fg = "#282828"; bg = "#83a598"; };}
          { preview_hovered = { underline = true; };}
          { find_keyword  = { fg = "#b8bb26"; italic = true; };}
          { find_position = { fg = "#fe8019"; bg = "reset"; italic = true; };}
          { marker_selected = { fg = "#b8bb26"; bg = "#b8bb26"; };}
          { marker_copied = { fg = "#b8bb26"; bg = "#b8bb26"; };}
          { marker_cut  = { fg = "#fb4934"; bg = "#fb4934"; };}
          { tab_active = { fg = "#282828"; bg = "#504945"; };}
          { tab_inactive = { fg = "#a89984"; bg = "#3c3836"; };}
          { tab_width = 1; }
          { border_symbol = "|"; }
          { border_style  = { fg = "#665c54"; };}
        ];
        status = [
          { separator_open  = ""; }
          { separator_close = ""; }
          { separator_style = { fg = "#3c3836"; bg = "#3c3836"; };}
          { mode_normal = { fg = "#282828"; bg = "#A89984"; bold = true; };}
          { mode_select = { fg = "#282828"; bg = "#b8bb26"; bold = true; };}
          { mode_unset  = { fg = "#282828"; bg = "#d3869b"; bold = true; };}
          { progress_label  = { fg = "#ebdbb2"; bold = true; };}
          { progress_normal = { fg = "#504945"; bg = "#3c3836"; };}
          { progress_error  = { fg = "#fb4934"; bg = "#3c3836"; };}
          { permissions_t = { fg = "#504945"; };}
          { permissions_r = { fg = "#b8bb26"; };}
          { permissions_w = { fg = "#fb4934"; };}
          { permissions_x = { fg = "#b8bb26"; };}
          { permissions_s = { fg = "#665c54"; };}
        ];
        input = [
          { border = { fg = "#504945"; };}
          { title = {};}
          { value = {};}
          { selected = { reversed = true; };}
        ];
        select = [
          { border = { fg = "#504945"; };}
          { active = { fg = "#fe8019"; };}
          { inactive = {};}
        ];
        tasks = [
          { border  = { fg = "#504945"; };}
          { title   = {};}
          { hovered = { underline = true; };}
        ];
        which = [
          { mask = { bg = "#3c3836"; };}
          { cand = { fg = "#83a598"; };}
          { rest = { fg = "#928374"; };}
          { desc = { fg = "#fe8019"; };}
          { separator = "  "; }
          { separator_style = { fg = "#504945"; };}
        ];
        help = [
          { on = { fg = "#fe8019"; };}
          { exec = { fg = "#83a598"; };}
          { desc = { fg = "#928374"; };}
          { hovered = { bg = "#504945"; bold = true; };}
          { footer  = { fg = "#3c3836"; bg = "#a89984"; };}
        ];
        filetype = {
          rules = [
            { mime = "image/*"; fg = "#83a598"; }
            { mime = "video/*"; fg = "#b8bb26"; }
            { mime = "audio/*"; fg = "#b8bb26"; }
            { mime = "application/zip"; fg = "#fe8019"; }
            { mime = "application/gzip"; fg = "#fe8019"; }
            { mime = "application/x-tar"; fg = "#fe8019"; }
            { mime = "application/x-bzip"; fg = "#fe8019"; }
            { mime = "application/x-bzip2"; fg = "#fe8019"; }
            { mime = "application/x-7z-compressed"; fg = "#fe8019"; }
            { mime = "application/x-rar"; fg = "#fe8019"; }
            { name = "*"; fg = "#a89984"; }
            { name = "*/"; fg = "#83a598"; }
          ];
        };
      };
    };

    ags = {
      enable = true;
      configDir = ../modules/gui/ags;
    };

    git = {
      enable = true;
      userName = "Donnerinoern";
      userEmail = "72634505+Donnerinoern@users.noreply.github.com";
      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
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
    fish = {
      enable = true;
      plugins = [
        {
          name = "Tide";
          src = pkgs.fishPlugins.tide;
        }
      ];
    };

    nix-index.enable = true;

    helix = {
      enable = true;
      settings = {
        theme = "merionette";
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
      };
    };
  };

  services = {
    playerctld.enable = true;
    udiskie.enable = true;
  };
}
