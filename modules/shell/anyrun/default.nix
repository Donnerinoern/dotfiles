{
  pkgs,
  inputs,
  ...
}: {
  config = {
    programs.anyrun = {
      enable = true;
    };
  };
}
