{
  lib,
  python3Packages,
  fetchPypi,
}:

let
  version = "2.0.6";
in
python3Packages.buildPythonApplication {
  pname = "ddsmt";
  inherit version;
  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "ddsmt";
    hash = "sha256-QH/FEIIEOZ87KhePXyoZ56T7pQzFgEn9gqcOJryRlZc=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
  ];

  propagatedBuildInputs = with python3Packages; [
    gprof2dot
    progressbar
  ];

  meta = {
    description = "Delta debugger for SMT benchmarks in SMT-LIB v2";
    homepage = "https://ddsmt.readthedocs.io/";
    license = lib.licenses.gpl3Plus;
    maintainers = [ ];
  };
}
