{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
    	url = "github:nix-community/home-manager";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
    fcitx5-lotus = {
    	url = "github:LotusInputMethod/fcitx5-lotus";
	inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
    	url = "github:catppuccin/nix";
    };
    plasma-manager = {
    	url = "github:nix-community/plasma-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }@inputs: {
    nixosConfigurations.my-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
	./hosts/my-pc/configuration.nix
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.tungle = {
	  	imports = [
			./hosts/my-pc/home.nix
			plasma-manager.homeModules.plasma-manager
		];
	  };
	  home-manager.extraSpecialArgs = { inherit inputs; };
	}
      ];
    };
    homeConfigurations.my-pc = home-manager.lib.homeManagerConfiguration {
    	pkgs = nixpkgs.legacyPackages.x86_64-linux;
    	modules = [
      		./home.nix
      		plasma-manager.homeManagerModules.plasma-manager
    	];
    };
  };
}
