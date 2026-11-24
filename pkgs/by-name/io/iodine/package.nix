{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  zlib,
  nixosTests,
  versionCheckHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "iodine";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "yarrick";
    repo = "iodine";
    tag = "v${finalAttrs.version}";
    hash = "sha256-vXxQqXr2qgU6eQeYjByrpG0H925yZoMfrOklqYKprXo=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [ zlib ];

  # selinux, systemd and libcap-ng are optional
  mesonAutoFeatures = "auto";

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "-v";
  doInstallCheck = true;

  passthru.tests = {
    inherit (nixosTests) iodine;
  };

  meta = {
    homepage = "https://code.kryo.se/iodine/";
    description = "Tool to tunnel IPv4 data through a DNS server";
    changelog = "https://github.com/yarrick/iodine/blob/${finalAttrs.src.tag}/CHANGELOG";
    license = lib.licenses.isc;
    platforms = lib.platforms.unix;
    mainProgram = "iodine";
    maintainers = with lib.maintainers; [ kamadorueda ];
  };
})
