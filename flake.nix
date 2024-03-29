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

    hyprland.url = "github:hyprwm/Hyprland";

    hyprpaper.url = "github:hyprwm/hyprpaper";

    hyprpicker.url = "github:hyprwm/hyprpicker";

    hypridle.url = "github:hyprwm/hypridle";

    hyprlock.url = "github:hyprwm/hyprlock";

    hyprcursor.url = "github:hyprwm/hyprcursor";

    rust-overlay.url = "github:oxalica/rust-overlay";

    # zig-overlay.url = "github:mitchellh/zig-overlay";

    neovim-flake.url = "github:NotAShelf/neovim-flake";

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

    eza.url = "github:eza-community/eza";

  };
}
