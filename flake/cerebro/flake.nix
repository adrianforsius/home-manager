{
  description = "Cerebro application launcher";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "cerebro";
        buildInputs = [ yarn ];

        src = fetchFromGitHub {
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
      };
  };
}