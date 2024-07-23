self: super: 
let
    toLua = str: "lua << EOF\n${str}\nEOF\n;";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n;";
    lspconfig = import ./lsp.nix {pkgs = super;};
in
{
    neovim = super.neovim.override{
        configure = {
            customRC = ''
            lua <<EOF
            vim.cmd[[colorscheme dracula]]
            vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloats", {bg = "none" })
            ${builtins.readFile ../lua/options.lua}
            ${builtins.readFile ../lua/keymaps.lua}
            ${lspconfig.luaScript}
            EOF
        '';

            plugins = with self.vimPlugins; [
                {
                    plugin = nvim-autopairs;
                    config = toLuaFile ../lua/autopairs.lua;
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
                    config = toLuaFile ../lua/telescope.lua;
                }
                {
                    plugin = telescope-fzf-native-nvim;
                    config = toLua "require(\"telescope\").load_extension(\"fzf\")";
                }
                {
                    plugin = nvim-treesitter;
                    config = toLuaFile ../lua/treesitter.lua;
                }
                {
                    plugin = nvim-treesitter-textobjects;
                    config = toLuaFile ../lua/treesitter-textobjects.lua;
                }

                nvim-treesitter.withAllGrammars
                nvim-lspconfig
                nvim-cmp
                luasnip 
                cmp_luasnip
                cmp-nvim-lsp
                trouble-nvim
                vim-suda

                {
                    plugin = otter-nvim;
                    config = toLuaFile ../lua/otter.lua;
                }

                oxocarbon-nvim
                dracula-nvim

                {
                    plugin = nvim-web-devicons;
                    config = toLua "require 'nvim-web-devicons'.setup()";
                }
                {
                    plugin = lualine-nvim;
                    config = toLuaFile ../lua/lualine.lua; 
                }
                {
                    plugin = nvim-highlight-colors;
                    config = toLuaFile ../lua/highlight-colors.lua;
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
                    config = toLuaFile ../lua/vimtex.lua;

                }
                {
                    plugin = cmake-tools-nvim;
                    config = toLuaFile ../lua/cmake-tools.lua;
                }
                {
                    plugin = nvim-dap;
                    config = toLuaFile ../lua/dap.lua;
                }
                {
                    plugin = nvim-dap-ui;
                    config = toLuaFile ../lua/dap-ui.lua;
                }
                vim-dadbod
                vim-dadbod-completion
                vim-dadbod-ui

                {
                    plugin = tmux-nvim;
                    config = toLuaFile ../lua/tmux-nvim.lua;
                }
            ];
        };
    };
}
