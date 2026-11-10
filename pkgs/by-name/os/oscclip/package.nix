{
  lib,
  python3Packages,
  fetchFromGitHub,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "oscclip";
  version = "0.6.2";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "rumpelsepp";
    repo = "oscclip";
    rev = "v${finalAttrs.version}";
    hash = "sha256-tNBODVfCJoRjjLMJdbg9XMf3DLn7yRLX+RM+LXcHkYM=";
  };

  build-system = with python3Packages; [ uv-build ];

  meta = {
    description = "Program that allows to copy/paste from a terminal using osc-52 control sequences";
    longDescription = ''
      oscclip provides two commands: osc-copy and osc-paste. These commands allow to interact with the clipboard through the terminal directly.
      This means that they work through ssh sessions for example (given that the terminal supports osc-52 sequences).
    '';
    homepage = "https://github.com/rumpelsepp/oscclip";

    license = lib.licenses.eupl12;
    maintainers = with lib.maintainers; [
      rumpelsepp
      traxys
    ];
  };
})
