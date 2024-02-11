{
  description = "Flake for Donnan";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      brutus = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/configuration.nix
          # agenix.nixosModules.default
          # {
          #   age.secrets.secret1.file = ./secrets/secret1.age;
          #   age.identityPaths = [
          #     "/home/donnan/.ssh/donnan"
          #     "/home/donnan/.ssh/brutus"
          #   ];
          # }
        ];
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/hyprlang-migration";

    rust-overlay.url = "github:oxalica/rust-overlay";

    zig-overlay.url = "github:mitchellh/zig-overlay";

    neovim-flake.url = "github:NotAShelf/neovim-flake";
    # neovim-flake.url = "github:Donnerinoern/neovim-flake/ui/colorizer";

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
    # ags.url = "github:Donnerinoern/ags";

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
  };
}
