{
  description = "Flake for Donnan";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs pkgs;
  in {
    formatter = pkgs.alejandra;
    
    nixosConfigurations = {
      brutus = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/configuration.nix
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

    rust-overlay.url = "github:oxalica/rust-overlay";
    
    zig-overlay.url = "github:mitchellh/zig-overlay";
      
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
  };
}
