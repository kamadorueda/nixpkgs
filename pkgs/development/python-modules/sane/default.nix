{
  lib,
  buildPythonPackage,
  fetchPypi,
  sane-backends,
}:

buildPythonPackage rec {
  pname = "sane";
  version = "2.9.2";
  format = "setuptools";

  src = fetchPypi {
    inherit version;
    pname = "python_sane";
    hash = "sha256-UKuOCwM87OytJscjGnJU+ArY/p7GtcJa3SST1+Kge74=";
  };

  buildInputs = [ sane-backends ];

  meta = {
    homepage = "https://github.com/python-pillow/Sane";
    description = "Python interface to the SANE scanner and frame grabber";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ doronbehar ];
  };
}
