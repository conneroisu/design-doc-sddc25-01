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
        texlive.combined.scheme-full
        texlab
        tectonic
        texliveTeTeX
        pandoc
      ];
    };
  };
}
