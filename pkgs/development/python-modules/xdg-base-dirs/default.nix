{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  uv-build,
  pytestCheckHook,
  nix-update-script,
}:

buildPythonPackage (finalAttrs: {
  pname = "xdg-base-dirs";
  version = "6.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "srstevenson";
    repo = "xdg-base-dirs";
    tag = "v${finalAttrs.version}";
    hash = "sha256-YAJWFP+I0jH23hK64qv9zAQYAiaLTFIhvgmPrKhvoOs=";
  };

  build-system = [ uv-build ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "xdg_base_dirs" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Implementation of the XDG Base Directory Specification in Python";
    homepage = "https://github.com/srstevenson/xdg-base-dirs";
    changelog = "https://github.com/srstevenson/xdg-base-dirs/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.isc;
    maintainers = with lib.maintainers; [ sandarukasa ];
  };
})
