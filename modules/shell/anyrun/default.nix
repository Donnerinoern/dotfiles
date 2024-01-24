{
  pkgs,
  inputs,
  ...
}: let
  plugins = inputs.anyrun.packages.${pkgs.system};
in {
  config = {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = [
          plugins.applications
          plugins.rink
        ];
        width.fraction = 0.2;
        y.fraction = 0.3;
        maxEntries = 10;
        closeOnClick = true;
      };
      extraCss = builtins.readFile (./. + "/style.css"); # TODO: lib.compileScss
    };
  };
}
