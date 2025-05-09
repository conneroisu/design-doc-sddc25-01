{
  perSystem = {
    self',
    config,
    inputs',
    pkgs,
    system,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nixd
        statix
        deadnix
        alejandra
        texlive.combined.scheme-full
        texlab
        tectonic
        texliveTeTeX
        pandoc
      ];
    };
  };
}
