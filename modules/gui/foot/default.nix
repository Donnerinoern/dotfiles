{
  pkgs,
  inputs,
  lib,
  config,
  config',
  ...
}: {
  config = {
    home-manager.users.${config'.username} = {
      programs.foot = {
        enable = true;
        settings = {
          main = {
            font = "Iosevka Medium:size=12";
          };
        };
      };
    };
  };
}
