{
  lib,
  stdenv,
  fetchFromGitHub,
  bzip2,
  cjson,
  cmake,
  docutils,
  libev,
  liburing,
  lz4,
  openssl,
  systemd,
  versionCheckHook,
  zlib,
  zstd,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "pgagroal";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "pgagroal";
    repo = "pgagroal";
    tag = finalAttrs.version;
    hash = "sha256-/cVwph3/57PwaxIFw+lyUO2A1OqFGOEdzNQ/gQsyRnU=";
  };

  patches = [ ./do-not-search-libatomic.patch ];

  nativeBuildInputs = [
    cmake
    docutils
  ];

  buildInputs = [
    bzip2
    cjson
    libev
    lz4
    openssl
    zlib
    zstd
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    liburing
    systemd
  ];

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;

  meta = {
    description = "High-performance connection pool for PostgreSQL";
    homepage = "https://agroal.github.io/pgagroal/";
    changelog = "https://github.com/pgagroal/pgagroal/releases/tag/${finalAttrs.version}";
    license = lib.licenses.bsd3;
    mainProgram = "pgagroal";
    maintainers = with lib.maintainers; [ kamadorueda ];
    platforms = lib.platforms.unix;
  };
})
