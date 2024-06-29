{ pkgs, pkgs-unstable, lib, ... }:
{
    programs.neovim = 
    let 
        toLua = str: "lua << EOF\n${str}\nEOF\n;";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n;";
        treesitter-parsers = with pkgs.vimPlugins.nvim-treesitter-parsers;[
            c cpp go zig rust python nix php lua
            vue javascript typescript css html sql
            json yaml toml
            latex bibtex
        ];
    in
    {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraLuaConfig = ''
            vim.cmd.colorscheme("dracula")
            vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloats", {bg = "none" })
            ${builtins.readFile ./lua/init.lua}
            ${builtins.readFile ./lua/keymaps.lua}
            ${builtins.readFile ./lua/lsp.lua}
        '';

        plugins = with pkgs.vimPlugins; [

            {
                plugin = nvim-autopairs;
                config = toLuaFile ./lua/autopairs.lua;
            }
	    nvim-ts-autotag
            {
                plugin = comment-nvim;
                config = toLua "require(\"Comment\").setup()";
            }
            {
                plugin = nvim-surround;
                config = toLua "require(\"nvim-surround\").setup()";
            }
            {
                plugin =  telescope-nvim;
                config = toLuaFile ./lua/telescope.lua;
            }
            {
                plugin = telescope-fzf-native-nvim;
                config = toLua "require(\"telescope\").load_extension(\"fzf\")";
            }
            {
                plugin = nvim-treesitter;
                config = toLuaFile ./lua/treesitter.lua;
            }
            {
                plugin = nvim-treesitter-textobjects;
                config = toLuaFile ./lua/treesitter-textobjects.lua;
            }

            nvim-treesitter.withAllGrammars
            nvim-lspconfig
            nvim-cmp
            luasnip 
            cmp_luasnip
            cmp-nvim-lsp
            trouble-nvim

            {
                plugin = otter-nvim;
                config = toLuaFile ./lua/otter.lua;
            }

            oxocarbon-nvim
            dracula-nvim

            {
                plugin = nvim-web-devicons;
                config = toLua "require 'nvim-web-devicons'.setup()";
            }
            {
                plugin = lualine-nvim;
                config = toLuaFile ./lua/lualine.lua; 
            }
            {
                plugin = nvim-highlight-colors;
                config = toLuaFile ./lua/highlight-colors.lua;

            }
            {
                plugin = oil-nvim;
                config = toLua "require(\"oil\").setup()";
            }
            {
                plugin = indent-blankline-nvim;
                config = toLua "require(\"ibl\").setup()";
            }

            {
                plugin = vimtex;
                config = toLuaFile ./lua/vimtex.lua;

            }
            {
                plugin = cmake-tools-nvim;
                config = toLuaFile ./lua/cmake-tools.lua;
            }
            {
                plugin = nvim-dap;
                config = toLuaFile ./lua/dap.lua;
            }
            {
                plugin = nvim-dap-ui;
                config = toLuaFile ./lua/dap-ui.lua;
            }
            vim-dadbod
            vim-dadbod-completion
            vim-dadbod-ui

            tmux-nvim
        ] ++ treesitter-parsers;

        extraPackages = with pkgs; [
            xclip
            wl-clipboard
            fzf
            cmake
            gdb

            #lps
            clang-tools_17
            cmake-language-server
            sqls
            lua-language-server
            biome
            tailwindcss-language-server
            nodePackages_latest.typescript-language-server
            nodePackages_latest.vls
            docker-compose-language-service
            arduino-language-server
            python311Packages.python-lsp-server
            vscode-extensions.rust-lang.rust-analyzer
            nil
        ];

    };
}
