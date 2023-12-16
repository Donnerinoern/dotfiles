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
          filetree.nvimTree = {
            enable = true;
            git.enable = true;
            renderer.indentMarkers.enable = true;
          };
          git.enable = true;
          telescope.enable = true;
          statusline.lualine.enable = true;
          tabline.nvimBufferline.enable = true;
          terminal.toggleterm.enable = true;
          hideSearchHighlight = true;
          useSystemClipboard = true;
          autoIndent = true;

          theme = {
            enable = true;
            name = "onedark";
          };

          ui = {
            colorizer.enable = true;
            illuminate.enable = true;
          };

          visuals = {
            enable = true;
            cursorline.enable = true;
            indentBlankline = {
              enable = true;
              eolChar = " ";
              fillChar = " ";
            };
            scrollBar.enable = true;
            nvimWebDevicons.enable = true;
            highlight-undo.enable = true;
          };

          binds = {
            cheatsheet.enable = true;
            whichKey.enable = true;
          };

          languages = {
            enableLSP = true;
            enableTreesitter = true;
            markdown = {
              enable = true;
              glow.enable = true;
            };
            svelte.enable = true;
            nix.enable = true;
            zig.enable = true;
            rust = {
              enable = true;
              crates.enable = true;
            };
            clang = {
              enable = true;
              lsp = {
                enable = true;
                server = "clangd";
              };
            };
          };
        };
      };
    };
  };
}
