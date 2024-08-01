{pkgs, pkgs-unstable, ...}: with pkgs-unstable; [

    fzf
    # LSP
    cmake-language-server
    arduino-language-server
    nodePackages_latest.vls
    tailwindcss-language-server
    nodePackages_latest.typescript-language-server
    sqls
    nil
    vscode-extensions.rust-lang.rust-analyzer
    lua-language-server
] ++ (with pkgs; [
    nodePackages_latest.volar
])
