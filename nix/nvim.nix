{pkgs}:
let
    toLua = str: "lua << EOF\n${str}\nEOF\n;";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n;";
    lspconfig = import ./lsp.nix {inherit pkgs;};
    nvimRtp = pkgs.stdenv.mkDerivation {
        name = "Custom Neovim Config"; 
        src = ../.;
        phases = ["buildPhase"];
        buildPhase = ''
            mkdir -p $out
            cp -r $src/nvim $out
        '';
    };
in
{
    neovim = pkgs.neovim.override{
        configure = {
            customRC = ''
            lua << EOF
            ${lspconfig.luaScript}
            vim.cmd[[colorscheme rose-pine]]
            vim.opt.rtp:prepend('${nvimRtp}/nvim')
            '' + (builtins.readFile "${nvimRtp}/nvim/init.lua") + ''  
            EOF
            '';

            packages.all.start = with pkgs.vimPlugins; [
                plenary-nvim
                nvim-autopairs
                nvim-ts-autotag
                comment-nvim
                nvim-surround
                telescope-nvim
                telescope-fzf-native-nvim
                nvim-treesitter
                nvim-treesitter-textobjects
                nvim-treesitter.withAllGrammars
                nvim-lspconfig
                nvim-cmp
                luasnip 
                cmp_luasnip
                cmp-nvim-lsp
                trouble-nvim
                vim-suda
                otter-nvim
                oxocarbon-nvim
                dracula-nvim
                rose-pine
                nvim-web-devicons
                lualine-nvim
                nvim-highlight-colors
                oil-nvim
                indent-blankline-nvim
                vimtex
                cmake-tools-nvim
                nvim-dap
                nvim-dap-ui
                vim-dadbod
                vim-dadbod-completion
                vim-dadbod-ui
                tmux-nvim
                lsp_signature-nvim
                alpha-nvim
                overseer-nvim
                godbolt-nvim
                toggleterm-nvim
            ]; 
        };
    };
}
