{
  description = "Flake for Donnan";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
      inherit (nixpkgs) lib;
  in {
    nixosConfigurations = import ./hosts {inherit nixpkgs inputs lib;};
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
