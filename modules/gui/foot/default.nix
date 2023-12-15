{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  config = {
    #home-manager.users.donnan = {
      programs.foot = {
        enable = true;
        settings = {
          main = {
            font = "Iosevka Medium:size=12";
          };
        };
      };
    #};
  };
}
