{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nix-update-script,
}:

buildNpmPackage (finalAttrs: {
  pname = "coc-git";
  version = "2.7.15";

  src = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc-git";
    tag = finalAttrs.version;
    hash = "sha256-kHJkUvB2DOurELnY72AGvfd+UGlWbRCh55Hyk/RZoAg=";
  };

  patches = [
    ./fix-package-lock.patch
  ];

  npmDepsHash = "sha256-DZL7x0buv9acrqikoo7T04e3USVL5kgTUCBRznAoKA0=";

  npmBuildScript = "prepare";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Git integration of coc.nvim";
    homepage = "https://github.com/neoclide/coc-git";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
})
