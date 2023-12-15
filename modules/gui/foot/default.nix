{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  config = {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "Iosevka Medium:size=12";
        };
      };
    };
  };
}
