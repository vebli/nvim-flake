{
    description = "Neovim Configuration";
    inputs = { };
    outputs = {self, nixpkgs, ...}: {
        homeManagerModules.nvim = {config, pkgs, pkgs-unstable, lib, ...}:{
            imports = [ (import ./nvim.nix {inherit config pkgs pkgs-unstable lib;}) ];
        };
    };

}
