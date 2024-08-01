{
    description = "Neovim Config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        nix-systems.url = "github:nix-systems/default";
    };


    outputs = inputs @ { self, nixpkgs, ... }: 
    let 
        eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
        mkPkgs = system:
        import nixpkgs {
          config = { allowUnfree = true; };
          inherit system;
          overlays = [
            (super: self: (import ./nix/overlays.nix {pkgs = self;}))
            (super: self: (import ./nix/nvim.nix {pkgs = self;}))
          ];
        };
    in {
    overlays.default = super: self: {
        nvim-custom = self.packages.${super.system}.default;
    };
    packages = eachSystem (system: 
        let pkgs = mkPkgs system;
        in {
            default = pkgs.writeShellApplication {
                name = "nvim";
                runtimeInputs = import ./nix/runtime.nix { inherit pkgs; };
                text = ''
                    ${pkgs.neovim}/bin/nvim "$@"
                '';
            };
        });
    };
}
