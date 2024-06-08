{
  description =
    "A media packaging and development framework for VOD and Live DASH and HLS applications, supporting Common Encryption for Widevine and other DRM Systems.";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "shaka-packager-${version}";

        version = "2.6.1";

        # https://nixos.wiki/wiki/Packaging/Binaries
        src = pkgs.fetchurl {
          url =
            "https://github.com/shaka-project/shaka-packager/releases/download/v${version}/packager-linux-x64";
          sha256 = "sha256-MoMX6PEtvPmloXJwRpnC2lHlT+tozsV4dmbCqweyyI0=";
        };

        dontUnpack = true;
        sourceRoot = ".";

        installPhase = ''
          install -m755 -D $src $out/bin/shaka-packager
        '';

        meta = with lib; {
          homepage = "https://shaka-project.github.io/shaka-packager/html/";
          description =
            "Media packaging framework for VOD and Live DASH and HLS applications";
          platforms = platforms.linux;
        };
      };
  };
}
