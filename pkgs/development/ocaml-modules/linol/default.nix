{
  lib,
  fetchFromGitHub,
  buildDunePackage,
  logs,
  ppx_yojson_conv_lib,
  trace,
  uutf,
}:

buildDunePackage (finalAttrs: {
  pname = "linol";
  version = "0.12";

  minimalOCamlVersion = "4.14";

  src = fetchFromGitHub {
    owner = "c-cube";
    repo = "linol";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/FyOP1pGjgMuibYKpiSfKjm8L+XV2JFmgKWGI2IgzoA=";
  };

  propagatedBuildInputs = [
    logs
    ppx_yojson_conv_lib
    trace
    uutf
  ];

  meta = {
    description = "LSP server library";
    homepage = "https://github.com/c-cube/linol";
    changelog = "https://raw.githubusercontent.com/c-cube/linol/refs/tags/v${finalAttrs.version}/CHANGES.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      stepbrobd
      ulrikstrid
    ];
  };
})
