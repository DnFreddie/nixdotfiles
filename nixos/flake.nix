{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem { 
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./virt.nix
          ./services.nix
          ./devtools.nix 
          ./desktop_env.nix
          ./programming.nix
          ./dynamic_binaries.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.aura = import ./home.nix;
          }
        ];
      };
    };
  };
}

