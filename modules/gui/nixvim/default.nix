{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
  programs.nixvim = {
    enable = true;
    options = {
      number = true;
      relativenumber = true;
      autoread = true;
      scrolloff = 5;
      ignorecase = true;
      smartcase = true;
      autoindent = true;
      smartindent = true;
      clipboard = "unnamedplus";
      hlsearch = false;
      showmatch = true;
    };
    keymaps = [
      {
        action = "<leader>";
        key = "\\<space>";
      }
    ];
    colorschemes.melange.enable = true;
    luaLoader.enable = true;
    plugins = {
      comment-nvim.enable = true;
      alpha = {
        enable = true;
        iconsEnabled = true;
      };
      chadtree = {
        enable = true;
        extraOptions = {
            width = 10;
          theme = {
            textColourSet = "trapdoor";
          };
        };
      };
      coq-nvim.enable = true;
      telescope.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      nvim-autopairs.enable = true;
      todo-comments.enable = true;
      nvim-colorizer.enable = true;
      illuminate.enable = true;
      cursorline.enable = true;
      indent-blankline.enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
  };
}
