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
      donnan-stasj = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/configuration.nix
          #./modules
          #inputs.home-manager.nixosModules.home-manager
          ##inputs.neovim-flake.homeManagerModules.default
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

    xdg-desktop-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    
    rust-overlay.url = "github:oxalica/rust-overlay";
    
    zig-overlay.url = "github:mitchellh/zig-overlay";
      
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    
    neovim-flake.url = "github:NotAShelf/neovim-flake";
  };
}
