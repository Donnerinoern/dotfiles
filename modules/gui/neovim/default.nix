{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
  programs = {
    neovim-flake = {
      enable = true;
      settings = {
        vim = {
          enableLuaLoader = true;
          autopairs.enable = true;
          comments.comment-nvim.enable = true;
          dashboard.alpha.enable = true;
          disableArrows = true;
          git.enable = true;
          git.gitsigns.enable = true;
          telescope.enable = true;
          statusline.lualine.enable = true;
          tabline.nvimBufferline = {
            enable = true;
            mappings.closeCurrent = "<leader>bq";
          };
          terminal.toggleterm.enable = true;
          hideSearchHighlight = true;
          useSystemClipboard = true;
          autocomplete.enable = true;

          notes.todo-comments.enable = true;

          theme = {
            enable = true;
            name = "gruvbox";
            style = "dark";
          };

          ui = {
            colorizer.enable = true;
            illuminate.enable = true;
            borders = {
              enable = true;
              globalStyle = "double";
            };
          };

          visuals = {
            enable = true;
            cursorline.enable = true;
            indentBlankline = {
              enable = true;
              eolChar = null;
              fillChar = null;
            };
            scrollBar.enable = true;
            fidget-nvim.enable = true;
            nvimWebDevicons.enable = true;
            highlight-undo = {
              enable = true;
              duration = 1000;
            };
            smoothScroll.enable = true;
          };

          utility = {
            surround.enable = true;
          };

          binds = {
            cheatsheet.enable = true;
            whichKey.enable = true;
          };

          snippets.vsnip.enable = true;

          treesitter = {
            autotagHtml = true;
          };

          languages = {
            enableLSP = true;
            enableTreesitter = true;
            markdown.enable = true;
            svelte.enable = true;
            nix.enable = true;
            zig.enable = true;
            go.enable = true;
            rust = {
              enable = true;
              crates.enable = true;
            };
            clang = {
              enable = true;
              lsp.server = "ccls";
            };
            html.enable = true;
            ts.enable = true;
            # sql.enable = true;
          };
        };
      };
    };
  };
}
