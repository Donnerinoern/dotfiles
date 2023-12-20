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
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      smoothscroll = true;
    };

    globals = {
      mapleader = " ";
    };

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
        view.width = 35; 
        theme = {
          textColourSet = "trapdoor";
        };
        keymap.openFileFolder.tertiary = ["<leader>t" "middlemouse"];
      };
      coq-nvim = {
        enable = true;
        installArtifacts = true;
        recommendedKeymaps = true;
      };
      telescope.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      nvim-autopairs.enable = true;
      todo-comments.enable = true;
      nvim-colorizer.enable = true;
      illuminate.enable = true;
      cursorline.enable = true;
      indent-blankline.enable = true;
      leap.enable = true;
      fidget.enable = true;
      treesitter = {
        enable = true;
        indent = true;
        incrementalSelection.enable = true;
        ensureInstalled = [
          "lua"
          "rust"
          "markdown"
          "markdown-inline"
          "c"
          "cpp"
          "zig"
          "nix"
          "html"
          "css"
          "javascript"
          "typescript"
          "svelte"
          "sql"
          "go"
        ];
      };
      lsp = {
        enable = true;
        servers = {
          rust-analyzer.enable = true;
          nil_ls.enable = true;
          clangd.enable = true;
          svelte.enable = true;
          zls.enable = true;
          lua-ls.enable = true;
          gopls.enable = true;
        }
      };
    };
  };
}
