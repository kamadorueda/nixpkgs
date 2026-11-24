{
  lib,
  stdenv,
  fetchurl,
  cups,
  fetchpatch,
  dos2unix,
  rpm,
  cpio,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "epson-escpr";
  version = "1.8.10";

  src = fetchurl {
    # To find new versions, go to
    # https://support.epson.net/linux/Printer/LSB_distribution_pages/en/escpr.php
    # and retrieve the download link of the source package: a src.rpm that
    # contains the tarball.
    # the server refuses curl's default user agent
    curlOptsList = [
      "--user-agent"
      ""
    ];
    url = "https://download-center.epson.com/f/module/d3003be6-1230-4495-a683-b627604d565c/epson-inkjet-printer-escpr-${finalAttrs.version}-1.src.rpm";
    hash = "sha256-v9WqSHy1ZfqV2PCUXVct5zUgrZc3Gq9NmI6mh9UuKfo=";
  };

  nativeBuildInputs = [
    rpm
    cpio
  ];

  # the source package is an rpm that contains the actual tarball
  unpackPhase = ''
    runHook preUnpack

    rpm2cpio $src | cpio -idm --quiet
    tar xf epson-inkjet-printer-escpr-${finalAttrs.version}-1.tar.gz
    cd epson-inkjet-printer-escpr-${finalAttrs.version}

    runHook postUnpack
  '';

  # the patches above are expecting unix line endings, but one of the files
  # being patched has dos line endings in the source tarball
  prePatch = ''
    ${dos2unix}/bin/dos2unix lib/epson-escpr-api.h
  '';

  patches = [
    ./cups-filter-ppd-dirs.patch
    (fetchpatch {
      url = "https://gitweb.gentoo.org/repo/gentoo.git/plain/net-print/epson-inkjet-printer-escpr/files/epson-inkjet-printer-escpr-1.8-missing-include.patch";
      hash = "sha256-L4WhaxPQnJYyqCH00wiKIlFNMmCEXoGe5d7hJ5TMyEI=";
    })
    (fetchpatch {
      url = "https://gitweb.gentoo.org/repo/gentoo.git/plain/net-print/epson-inkjet-printer-escpr/files/1.8.6-warnings.patch";
      hash = "sha256-wSY0LZv2b+1kF7TfPolt554g79y2Ce6N/JqgjJyd3Ag=";
    })
  ];

  # the timestamps of the tarball make the build try to run automake again,
  # but the generated files are the ones to use (configure is patched)
  makeFlags = [
    "ACLOCAL=:"
    "AUTOCONF=:"
    "AUTOHEADER=:"
    "AUTOMAKE=:"
  ];

  # To suppress error (Stripping trailing CRs from patch; use --binary to disable.)
  patchFlags = [
    "-p1"
  ];
  buildInputs = [ cups ];

  meta = {
    homepage = "http://download.ebz.epson.net/dsc/search/01/search/";
    description = "ESC/P-R Driver (generic driver)";
    longDescription = ''
      Epson Inkjet Printer Driver (ESC/P-R) for Linux and the
      corresponding PPD files. The list of supported printers
      can be found at http://www.openprinting.org/driver/epson-escpr/ .

      To use the driver adjust your configuration.nix file:
        services.printing = {
          enable = true;
          drivers = [ pkgs.epson-escpr ];
        };

      To setup a wireless printer, enable Avahi which provides
      printer's hostname to CUPS and nss-mdns to make this
      hostname resolvable:
        services.avahi = {
          enable = true;
          nssmdns4 = true;
        };'';
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ kamadorueda ];
    platforms = lib.platforms.linux;
  };
})
