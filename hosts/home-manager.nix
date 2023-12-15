{
  lib,
  inputs,
  outputs,
  pkgs,
  config,
  ...
}: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      donnan = import ../home-manager/home.nix;
    };
  };
}
