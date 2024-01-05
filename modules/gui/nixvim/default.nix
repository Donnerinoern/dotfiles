{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    options = {
      number = true;
      relativenumber = true;
      autoread = true;
      scrolloff = 5;
      ignorecase = true;
      smartcase = true;
      autoindent = true;
      # smartindent = true;
      cindent = true;
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

    keymaps = [
      {
        action = "vim.cmd.CHADopen";
        lua = true;
        key = "<leader>v";
      }
      {
        action = "vim.cmd.bnext";
        lua = true;
        key = "<leader>n";
      }
      {
        action = "vim.cmd.bprev";
        lua = true;
        key = "<leader>p";
      }
      {
        action = "vim.cmd.bdelete";
        lua = true;
        key = "<leader>q";
      }
      {
        action = "vim.cmd.w";
        lua = true;
        key = "<Cr>s";
      }
    ];

    colorschemes.gruvbox.enable = true;
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
          textColourSet = "nerdtree_syntax_dark";
        };
        keymap.openFileFolder.tertiary = ["<leader>t" "middlemouse"];
      };
      coq-nvim = {
        enable = true;
        installArtifacts = true;
        recommendedKeymaps = true;
        alwaysComplete = true;
        autoStart = true;
      };
      # nvim-cmp = {
      #   enable = true;
      #   # autoEnableSources = true;
      #   sources = [
      #     # { name = "ultisnips"; }
      #     { name = "luasnip"; }
      #     { name = "path"; }
      #     { name = "buffer"; }
      #     { name = "nvim_lsp"; }
      #   ];
      #   # completion = {
      #   #   autocomplete = [
      #   #     "TextChanged"
      #   #   ];
      #   #   keywordLength = 1;
      #   #   keywordPattern = "\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)";
      #   # };
      #   snippet.expand = "luasnip";
      #   mapping = {
      #     "<CR>" = "cmp.mapping.confirm({ select = true })";
      #     "<Tab>" = {
      #       action = ''
      #         function(fallback)
      #           if cmp.visible() then
      #             cmp.select_next_item()
      #           elseif luasnip.expendable() then
      #             luasnip.expand()
      #           elseif luasnip.expand_or_jumpable() then
      #             luasnip.expand_or_jump()
      #           elseif check_backspace() then
      #             fallback()
      #           else
      #             fallback()
      #           end
      #         end
      #       '';
      #     };
      #   };
      # };
      #
      # luasnip.enable = true;

      # cmp-nvim-ultisnips.enable = true;
      # cmp-buffer.enable = true;
      # cmp-path.enable = true;
      # cmp-nvim-lsp.enable = true;
      # cmp_luasnip.enable = true;
      
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };
      lualine.enable = true;
      bufferline = {
        enable = true;
        offsets = [
          { 
            filetype = "CHADTree";
            text = "File Explorer";
            text_align = "center";
            separator = true;
          }
        ];
      };
      # barbar = {
      #   enable = true;
      #   sidebarFiletypes = {
      #     CHADTree = true;
      #     options = {
      #       text = "File Explorer";
      #       event = "BufWinLeave";
      #     };
      #   };
      # };
      nvim-autopairs.enable = true;
      todo-comments.enable = true;
      nvim-colorizer.enable = true;
      illuminate.enable = true;
      cursorline.enable = true;
      indent-blankline.enable = true;
      leap.enable = true;
      which-key.enable = true;
      fidget.enable = true;
      markdown-preview = {
        enable = true;
        autoStart = true;
      };
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
          rust-analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
          nil_ls.enable = true;
          clangd.enable = true;
          svelte.enable = true;
          zls.enable = true;
          lua-ls.enable = true;
          gopls.enable = true;
        };
      };
    };
  };
}
