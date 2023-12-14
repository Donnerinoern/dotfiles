{
  config',
  lib,
  self,
  inputs,
  pkgs,
  ...
}: {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs self config';};
    users.${config'.username} = {
      home = {
        inherit (config') username;
        homeDirectory = "/home/${config'.username}";
        stateVersion = "23.05";
      };
      programs.home-manager.enable = true;
    };
  };
}
