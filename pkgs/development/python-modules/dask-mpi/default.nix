{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatch-vcs,
  hatchling,
  dask,
  distributed,
  mpi4py,
}:

buildPythonPackage rec {
  pname = "dask-mpi";
  version = "2026.3.0";
  pyproject = true;

  src = fetchPypi {
    pname = "dask_mpi";
    inherit version;
    hash = "sha256-EOvk5KHVPBJUagi0J1vHYqRnahdcxAtezGyiyR6KLn4=";
  };

  build-system = [
    hatch-vcs
    hatchling
  ];

  dependencies = [
    dask
    distributed
    mpi4py
  ];

  # Hardcoded mpirun path in tests
  doCheck = false;

  pythonImportsCheck = [ "dask_mpi" ];

  meta = {
    description = "Deploy Dask using mpi4py";
    mainProgram = "dask-mpi";
    homepage = "https://github.com/dask/dask-mpi";
    license = lib.licenses.bsd3;
    maintainers = [ ];
  };
}
