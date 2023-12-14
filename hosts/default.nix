{
  inputs,
  lib,
  ...
}: let
    inherit (inputs) self;
in {
  donnan-stasj = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit lib inputs self;
      config' = {
        hostname = "donnan-stasj";
        username = "donnan";
      };
    };
    modules = [
      ./donnan-stasj
      ../modules
      inputs.home-manager.nixosModules.home-manager
    ];
  };
}

