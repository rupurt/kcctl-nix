{
  pkgs,
  system,
  stdenv,
  ...
}: {
  pname ? "kcctl",
  version ? "1.0.0.CR1",
  shas ? {
    aarch64-darwin = "0fiv3pjcz0k02lk439wlr486jvxxhgs0w160lfxwsqwxr2v0qidy";
    x86_64-darwin = "0fiv3pjcz0k02lk439wlr486jvxxhgs0w160lfxwsqwxr2v0qidy";
    aarch64-linux = "1297qxannsc6l9wphd6birwzvlpjjy7gzapg3p6fc92hbmc3rdxi";
    x86_64-linux = "1297qxannsc6l9wphd6birwzvlpjjy7gzapg3p6fc92hbmc3rdxi";
  },
}: let
  os =
    if stdenv.isDarwin
    then "osx"
    else "linux";
  file = "kcctl-${version}-${os}-x86_64.zip";
in
  stdenv.mkDerivation {
    pname = pname;
    version = version;
    src = pkgs.fetchzip {
      url = "https://github.com/kcctl/kcctl/releases/download/v${version}/${file}";
      sha256 = shas.${system};
      stripRoot = false;
    };

    installPhase = "mkdir -p $out/bin; cp bin/kcctl $out/bin";

    checkPhase = ''
      kcctl version | grep ${version}
    '';
  }
