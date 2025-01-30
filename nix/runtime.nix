{pkgs, pkgs-unstable, ...}: with pkgs-unstable; [
    curl #for godbolt
    fzf
    # LSP
    asm-lsp
    cmake-language-server
    arduino-language-server
    vscode-extensions.vue.volar
    tailwindcss-language-server
    vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    sqls
    nil
    nixd
    vscode-extensions.rust-lang.rust-analyzer
    lua-language-server
    python312Packages.python-lsp-server
    ols

    # Formatter
    alejandra
] ++ (with pkgs; [
    vscode-extensions.vue.volar
])
