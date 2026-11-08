{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
}:

buildNpmPackage rec {
  pname = "rtlcss";
  version = "4.3.0";

  src = fetchFromGitHub {
    owner = "MohammadYounes";
    repo = "rtlcss";
    rev = "v${version}";
    hash = "sha256-BIRjy/3yXlvH3z5q0fmVXD7lrbZGVU0SVJaG4uZMZd0=";
  };

  npmDepsHash = "sha256-6zZdnogCLXgl1gt6aYMyofIVMaQR3cQRa4z6HoI+CrI=";

  dontNpmBuild = true;

  meta = {
    description = "Framework for converting Left-To-Right (LTR) Cascading Style Sheets(CSS) to Right-To-Left (RTL)";
    mainProgram = "rtlcss";
    homepage = "https://rtlcss.com";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ kamadorueda ];
  };
}
