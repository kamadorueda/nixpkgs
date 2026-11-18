{
  lib,
  buildPythonPackage,
  fetchPypi,
  msrestazure,
  azure-common,
  setuptools,
}:

buildPythonPackage rec {
  pname = "azure-batch";
  version = "15.1.0";
  pyproject = true;

  src = fetchPypi {
    pname = "azure_batch";
    inherit version;
    hash = "sha256-L2hNF2tFe3ITU14UUYCpFO1oRLLRBm/MIqyIw6yeP6U=";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    azure-common
    msrestazure
  ];

  # Module has no tests
  doCheck = false;

  pythonImportsCheck = [ "azure.batch" ];

  meta = {
    description = "This is the Microsoft Azure Batch Client Library";
    homepage = "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/batch/azure-batch";
    changelog = "https://github.com/Azure/azure-sdk-for-python/blob/azure-batch_${version}/sdk/batch/azure-batch/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ maxwilson ];
  };
}
