{
  description = "A very basic flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let 
    inherit (self) outputs;

    system = "x86_64-linux";
    hostname = "nixos";
    username = "astro";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };  

  in {

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      description = "NixOS system configuration for ${hostname}";
      system = system;
      specialArgs = { inherit inputs outputs; };
      modules = [ ./nixos/configuration.nix ];  
    };

    homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
      description = "Home configuration for ${username}@${hostname}";
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs outputs;};
      modules = [ ./home-manager/home.nix ];
    };

  };

}
