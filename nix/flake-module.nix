{
  perSystem = {
    self',
    config,
    inputs',
    pkgs,
    system,
    ...
  }: {
    devShells = let
      packages = with pkgs; [
        nixd # Nix
        alejandra

        texlive.combined.scheme-full # LaTeX
        texlab
        tectonic
        texliveTeTeX
        pandoc
      ];
      shellHook = ''
        echo "Welcome to the Nix Shell"
      '';
    in {
      default = pkgs.mkShell {
        inherit packages shellHook;
      };
      devcontainer = pkgs.mkShell {
        inherit shellHook;
        packages =
          packages
          ++ (with pkgs; [
            git
            direnv
            nix-direnv
            gnumake
            gnused
            gnugrep
            gnutar
            gzip
            curl
            jq
            git-lfs
            coreutils-full
          ]);
      };
    };
    # TODO: Render Package
  };
}
