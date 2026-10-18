{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" ]; #"x86_64-darwin" "aarch64-darwin" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = pkgs.callPackage ./package.nix { };
        }
      );

      devShells = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = pkgs.mkShell {
            inputsFrom = [
              self.packages."${system}".default 
            ];
            packages = [
              pkgs.clang-tools
              pkgs.gdb
            ];

            shellHook = ''
              export CXXFLAGS="$NIX_CFLAGS_COMPILE"
            '';
          };
        }
      );
    };
}