{
  description = "A very basic flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    inherit (self) outputs;

    system = "x86_64-linux";
    hostname = "nixos";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };  

  in {

    nixosModules = import ./modules/nixos;

    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = { inherit inputs outputs; };
      modules = [ ./nixos/configuration.nix ];  
    };

  };

}
