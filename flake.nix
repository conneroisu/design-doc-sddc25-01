{
  description = "Design Doc for SDDC 25-01";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {self, ...}: {
        systems = import inputs.systems;
        imports = [
          ./nix/flake-module.nix
          inputs.treefmt-nix.flakeModule
        ];

        perSystem = {
          self',
          config,
          inputs',
          pkgs,
          system,
          ...
        }: {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [];
          };
          treefmt = {
            programs.alejandra.enable = true;
            programs.texfmt.enable = true;
          };
        };
      }
    );
}
