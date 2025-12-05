{
  description = "A very basic flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
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
      system = system;
      specialArgs = { inherit inputs outputs; };
      modules = [ ./nixos/configuration.nix ];  
    };

    homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs; 
      extraSpecialArgs = {inherit inputs outputs;};
      modules = [ ./home-manager/home.nix ];
    };

  };

}
