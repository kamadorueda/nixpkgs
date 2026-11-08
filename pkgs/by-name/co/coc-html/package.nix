{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nix-update-script,
}:

buildNpmPackage (finalAttrs: {
  pname = "coc-html";
  version = "1.9.2";

  src = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc-html";
    tag = finalAttrs.version;
    hash = "sha256-Ac4pvz2olVIVJxNB06CMQ704zSscqNdDnAlhVaZ5amE=";
  };

  patches = [
    # the upstream lockfile has no `resolved` URL and `integrity` for vscode-nls
    ./fix-package-lock.patch
  ];

  npmDepsHash = "sha256-YdQedrF8JI1+WE0zk4fMhYYICPMX3gD9nPou7In9yxQ=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Html language server extension for coc.nvim";
    homepage = "https://github.com/neoclide/coc-html";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ kamadorueda ];
  };
})
