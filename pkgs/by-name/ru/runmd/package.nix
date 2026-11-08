{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage (finalAttrs: {
  pname = "runmd";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "broofa";
    repo = "runmd";
    tag = "v${finalAttrs.version}";
    hash = "sha256-9sCqcq9LcG3S7RqfJIkKOb4mAvAQC1UpekzN9Ag4K7k=";
  };

  npmDepsHash = "sha256-mraTpg/dT+SCz8o7d5g2U6mA1iKpjF3TiZQVCU1NUeo=";

  # `prepare` runs `lefthook install`, which needs git
  npmPackFlags = [ "--ignore-scripts" ];

  meta = {
    description = "Executable markdown files";
    homepage = "https://github.com/broofa/runmd";
    changelog = "https://github.com/broofa/runmd/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ kamadorueda ];
    mainProgram = "runmd";
    platforms = lib.platforms.all;
  };
})
