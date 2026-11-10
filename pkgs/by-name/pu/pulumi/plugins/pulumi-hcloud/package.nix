{
  lib,
  mkPulumiPackage,
}:
mkPulumiPackage rec {
  owner = "pulumi";
  repo = "pulumi-hcloud";
  version = "1.43.4";
  rev = "v${version}";
  hash = "sha256-1E02fkvgPQaHHwJQkRGxge8PqHlPWkbcMiFnnlKSCWo=";
  vendorHash = "sha256-KtFC5eRnkEST44Sj7QnYM0k1nHCurDVkJ+xMrQuuttE=";
  cmdGen = "pulumi-tfgen-hcloud";
  cmdRes = "pulumi-resource-hcloud";
  extraLdflags = [
    "-X=github.com/pulumi/${repo}/provider/pkg/version.Version=v${version}"
  ];
  __darwinAllowLocalNetworking = true;
  meta = {
    description = "Hetzner Cloud Pulumi resource package, providing multi-language access to Hetzner Cloud";
    mainProgram = "pulumi-resource-hcloud";
    homepage = "https://github.com/pulumi/pulumi-hcloud";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ tie ];
  };
}
