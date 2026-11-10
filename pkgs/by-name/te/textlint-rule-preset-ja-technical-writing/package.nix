{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nix-update-script,
  textlint,
  textlint-rule-preset-ja-technical-writing,
}:

buildNpmPackage (finalAttrs: {
  pname = "textlint-rule-preset-ja-technical-writing";
  version = "12.0.2";

  src = fetchFromGitHub {
    owner = "textlint-ja";
    repo = "textlint-rule-preset-ja-technical-writing";
    tag = "v${finalAttrs.version}";
    hash = "sha256-W5vTAMkLYVaHnEhSL2ZhMx/dV4JzWvjw3Ofuf5kO0x4=";
  };

  npmDepsHash = "sha256-ZY4GgXrMyaQPCxPklzwPZa1OIav7FRmfscTWRQ4Tc84=";

  # lib/ is committed upstream and there is no build script
  dontNpmBuild = true;

  passthru = {
    updateScript = nix-update-script { };
    tests = textlint.testPackages {
      rule = textlint-rule-preset-ja-technical-writing;
      testFile = ./test.md;
    };
  };

  meta = {
    description = "技術文書向けのtextlintルールプリセット";
    homepage = "https://github.com/textlint-ja/textlint-rule-preset-ja-technical-writing";
    changelog = "https://github.com/textlint-ja/textlint-rule-preset-ja-technical-writing/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    platforms = textlint.meta.platforms;
  };
})
