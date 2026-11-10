{
  lib,
  python3,
  fetchFromGitHub,
  nix-update-script,
}:

python3.pkgs.buildPythonApplication {
  pname = "nbutools";
  version = "0-unstable-2023-06-06";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "airbus-seclab";
    repo = "nbutools";
    rev = "d82fb96d5623e7d3076cc0a1db06a640f63b9552";
    hash = "sha256-YOiFlTIDpeTFOHPU37v0pYf8s3HdaE/4pnd9qrsFtSI=";
  };

  build-system = with python3.pkgs; [ setuptools ];

  dependencies = with python3.pkgs; [
    aiodns
    aiohttp
    beautifulsoup4
    graphviz
    jaydebeapi
    jpype1
    lxml
    pycryptodome
    requests
    scapy
    tabulate
  ];

  # Project has no tests
  doCheck = false;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Tools for offensive security of NetBackup infrastructures";
    homepage = "https://github.com/airbus-seclab/nbutools";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ fab ];
  };
}
