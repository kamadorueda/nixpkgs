{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  msrest,
  azure-common,
  azure-mgmt-core,
}:

buildPythonPackage rec {
  pname = "azure-mgmt-reservations";
  version = "3.0.0";
  pyproject = true;

  src = fetchPypi {
    pname = "azure_mgmt_reservations";
    inherit version;
    hash = "sha256-lmeYDK5Pt1U8HiiKozaVLrddlP92Ho1CYDVwaq8EyfM=";
  };

  build-system = [ setuptools ];

  dependencies = [
    msrest
    azure-common
    azure-mgmt-core
  ];

  # has no tests
  doCheck = false;

  meta = {
    description = "This is the Microsoft Azure Reservations Client Library";
    homepage = "https://github.com/Azure/azure-sdk-for-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ maxwilson ];
  };
}
