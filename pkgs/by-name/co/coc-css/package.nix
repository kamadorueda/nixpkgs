{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nix-update-script,
}:

buildNpmPackage (finalAttrs: {
  pname = "coc-css";
  version = "2.2.4";

  src = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc-css";
    tag = finalAttrs.version;
    hash = "sha256-kZavbTt3WhsJb/xhgtX/f5UjBcTJP+pJ4wVZwF6PaVE=";
  };

  patches = [
    # the upstream lockfile has no `resolved` URL and `integrity` for most dependencies
    ./fix-package-lock.patch
  ];

  npmDepsHash = "sha256-KHBvQcpTfADQR+2DGgdiz8R9dJj3JF6t/+RMEcS3Xyo=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Css language server extension for coc.nvim";
    homepage = "https://github.com/neoclide/coc-css";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
})
