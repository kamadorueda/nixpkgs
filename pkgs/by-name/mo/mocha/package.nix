{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nix-update-script,
}:

buildNpmPackage (finalAttrs: {
  pname = "mocha";
  version = "12.0.3";

  src = fetchFromGitHub {
    owner = "mochajs";
    repo = "mocha";
    tag = "v${finalAttrs.version}";
    hash = "sha256-peIN6uOXa/tRLJwe3f5yvoFVxBtgXep9u2aaNJkZ+qQ=";
  };

  npmDepsHash = "sha256-KA9mwt5HqS/eu/MIc/Wx51KlFuvkD9tNr+i1ZtX+rKE=";

  passthru.updateScript = nix-update-script { };

  meta = {
    changelog = "https://github.com/mochajs/mocha/blob/v${finalAttrs.version}/CHANGELOG.md";
    description = "Simple, flexible, fun Javascript test framework for Node.js & the browser";
    homepage = "https://mochajs.org";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ kamadorueda ];
    mainProgram = "mocha";
  };
})
