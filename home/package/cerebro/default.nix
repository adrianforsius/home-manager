{ pkgs ? import <nixpkgs> {} }: with pkgs;
  let
    name = "cerebro";
    version = "0.11.0";
    src = fetchurl {
      url = "https://github.com/cerebroapp/cerebro/releases/download/v${version}/Cerebro-${version}.AppImage";
      sha256 = "1zzcpcp1f9y2jbvk5l1206n8hjnv3rdchrv13kka9p08hhrc1f7s";
    };
    appimageContents = appimageTools.extractType2 { inherit name src; };
  in
  appimageTools.wrapType2 rec {
    inherit name src;
    version = "0.11.0";
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/${name}.desktop $out/share/applications/${name}.desktop

      install -m 444 -D ${appimageContents}/${name}.png $out/share/icons/hicolor/512x512/apps/${name}.png

      substituteInPlace $out/share/applications/${name}.desktop \
      	--replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
    '';

    meta = {
      description = "Cerebro application launcher";
    };
  }
