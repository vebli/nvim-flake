{
    description = "Neovim Config";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        nix-systems.url = "github:nix-systems/default";
    };


    outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }: 
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
        mkPkgsUnstable = system:
        import nixpkgs-unstable{
          config = { allowUnfree = true; };
          inherit system;
          overlays = [
            (super: self: (import ./nix/overlays.nix {pkgs = self;}))
            (super: self: (import ./nix/nvim.nix {pkgs = self;}))
          ];
        };
    in rec{
    overlays.default = (super: self: {
        nvim-custom = packages.${super.system}.default;
    });
    packages = eachSystem (system: 
        let 
            pkgs = mkPkgs system;
            pkgs-unstable = mkPkgsUnstable system;
        in {
            default = pkgs-unstable.writeShellApplication {
                name = "nvim";
                runtimeInputs = import ./nix/runtime.nix { inherit pkgs pkgs-unstable; };
                text = ''
                    ${pkgs-unstable.neovim}/bin/nvim "$@"
                '';
            };
        });
    };
}
