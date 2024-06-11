{
  description =
    "A media packaging and development framework for VOD and Live DASH and HLS applications, supporting Common Encryption for Widevine and other DRM Systems.";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "shaka-packager-${version}";

        version = "3.2.0";

        # https://nixos.wiki/wiki/Packaging/Binaries
        src = pkgs.fetchurl {
          url =
            "https://github.com/shaka-project/shaka-packager/releases/download/v${version}/packager-linux-x64";
          sha256 = "sha256-Ba8unvXxLVi51hW30x3A62HDKu5jLHGWU0C0PBVWBD4=";
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

    packages.aarch64-darwin.default =
      with import nixpkgs { system = "aarch64-darwin"; };

      stdenv.mkDerivation rec {
        name = "shaka-packager-${version}";

        version = "3.2.0";

        # https://nixos.wiki/wiki/Packaging/Binaries
        src = pkgs.fetchurl {
          url =
            "https://github.com/shaka-project/shaka-packager/releases/download/v${version}/packager-osx-arm64";
          sha256 = "sha256-EKzLme1FFY+0qmEQImFfizforKCYNkSVVxrmw4nrYwc=";
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
          platforms = platforms.darwin;
        };
      };
  };
}
