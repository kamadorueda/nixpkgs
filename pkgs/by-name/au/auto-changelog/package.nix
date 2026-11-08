{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  jq,
}:
buildNpmPackage (finalAttrs: {
  pname = "auto-changelog";
  version = "2.7.0";

  src = fetchFromGitHub {
    owner = "cookpete";
    repo = "auto-changelog";
    tag = "v${finalAttrs.version}";
    hash = "sha256-STW2iYn2/yJDU0lLDgvaNV/GM8+BzyYCt8bHYUc3AnM=";
  };

  # Upstream does not ship a lockfile (`package-lock=false`): this one is
  # generated from the production dependencies only, and the lifecycle scripts
  # (which need the development dependencies) are removed
  postPatch = ''
    ${lib.getExe jq} 'del(.devDependencies, .scripts)' package.json > package.json.new
    mv package.json.new package.json
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-McMDjN+O5ds2XelNP3m8nBfu7ffJGXJmc5Omv280TWY=";

  dontNpmBuild = true;
  dontNpmPrune = true;

  meta = {
    description = "Command line tool for generating a changelog from git tags and commit history";
    homepage = "https://github.com/cookpete/auto-changelog";
    changelog = "https://github.com/cookpete/auto-changelog/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "auto-changelog";
    maintainers = with lib.maintainers; [ kamadorueda ];
  };
})
