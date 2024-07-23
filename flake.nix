{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };


    outputs = { self, nixpkgs }: 
    let 
        system = "x86_64-linux";
        overlays = [(import ./nix/overlays.nix)];
        pkgs = import nixpkgs {inherit system overlays;};
    in 
    {
	inherit overlays;
        packages.${system}.default = pkgs.neovim;
        apps.${system}.default = {
            type = "app";
            program = "${pkgs.neovim}/bin/nvim";
        };

    };
}
