{
  description = "Cerebro application launcher";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let

      # Generate a user-friendly version number.
      version = builtins.substring 0 8 self.lastModifiedDate;

      pkgs = nixpkgs.system."x86_64-linux";
    in {

      # Provide some binary packages for selected system types.
      packages.system."x86_64-linux" = {
        # get from github 
        # build with pkgs.node
        cerebro = pkgs.stdenv.mkDerivation rec {
          buildInputs = with pkgs; [ yarn ];

          src = pkgs.fetchFromGithub {
            owner = "cerebroapp";
            repo = "cerebro";
            rev = "add453b9881b44c676970fc0bb288abac7782a51";
            sha256 = "0p301jq7sgh3xzghm30smz495xx0pfcl7yll4mvc6va0g6s88wap";
          };

          buildPhase = ''
            runHook preBuild
            yarn --force
            yarn package
            runHook postBuild
          '';
          installPhase = ''
            runHook preInstall
            mkdir -p $out/bin
            mv release/linux-unpacked/cerebro $out/bin
            runHook postInstall
          '';
        }
      };

      # The default package for 'nix build'. This makes sense if the
      # flake provides only one package or there is a clear "main"
      # package.
      defaultPackage = self.packages."x86_64-linux".cerebro
}