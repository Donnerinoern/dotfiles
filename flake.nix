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

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    
    rust-overlay.url = "github:oxalica/rust-overlay";
    
    zig-overlay.url = "github:mitchellh/zig-overlay";
      
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    
    neovim-flake.url = "github:Donnerinoern/neovim-flake";

    ags.url = "github:Aylur/ags";
  };
}
