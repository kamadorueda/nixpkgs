{
  lib,
  stdenv,
  fetchFromGitHub,
  dbus,
  desktop-file-utils,
  gettext,
  glib,
  gsettings-desktop-schemas,
  gtk4,
  libadwaita,
  meson,
  ninja,
  pango,
  pcre2,
  pkg-config,
  tmux,
  vte-gtk4,
  wrapGAppsHook4,
  nixosTests,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "germinal";
  version = "31";

  src = fetchFromGitHub {
    owner = "Keruspe";
    repo = "Germinal";
    tag = "v${finalAttrs.version}";
    hash = "sha256-EsFBZBO7tn/de2rAT4kVGNVc5Vl4tcogMwmv0vEfWL8=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    glib
    meson
    ninja
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    dbus
    glib
    gsettings-desktop-schemas
    gtk4
    libadwaita
    pango
    pcre2
    vte-gtk4
  ];

  env.PKG_CONFIG_DBUS_1_SESSION_BUS_SERVICES_DIR = "${placeholder "out"}/share/dbus-1/services";

  preFixup = ''
    gappsWrapperArgs+=(--prefix PATH : "${lib.makeBinPath [ tmux ]}")
  '';

  passthru.tests.test = nixosTests.terminal-emulators.germinal;

  meta = {
    description = "Minimal terminal emulator";
    homepage = "https://github.com/Keruspe/Germinal";
    changelog = "https://github.com/Keruspe/Germinal/blob/v${finalAttrs.version}/NEWS";
    license = lib.licenses.gpl3Plus;
    mainProgram = "germinal";
    maintainers = with lib.maintainers; [ kamadorueda ];
    platforms = lib.platforms.unix;
  };
})
