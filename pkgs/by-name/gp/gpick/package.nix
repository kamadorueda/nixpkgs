{
  stdenv,
  fetchFromGitHub,
  cmake,
  boost,
  ragel,
  pkg-config,
  wrapGAppsHook3,
  lua5_4,
  lib,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gpick";
  version = "0.4";

  src = fetchFromGitHub {
    owner = "thezbyg";
    repo = "gpick";
    rev = "v${finalAttrs.version}";
    hash = "sha256-1I8eGYmjjMyeDnLG/2fdsQwK9dZowViNkt/tkKeAyFI=";
  };

  # cmake/Version.cmake needs a .version file when it cannot use git
  postPatch = ''
    echo ${finalAttrs.version} > .version
  '';

  nativeBuildInputs = [
    cmake
    pkg-config
    wrapGAppsHook3
  ];

  buildInputs = [
    boost
    ragel
    lua5_4
  ];

  # the nixpkgs Lua is built as C, not C++
  cmakeFlags = [ (lib.cmakeFeature "LUA_TYPE" "C") ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Advanced color picker written in C++ using GTK+ toolkit";
    homepage = "https://www.gpick.org/";
    license = lib.licenses.bsd3;
    maintainers = [ lib.maintainers.vanilla ];
    platforms = lib.platforms.linux;
    mainProgram = "gpick";
  };
})
