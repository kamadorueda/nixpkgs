{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenvNoCC,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "termirs";
  version = "0.3.4";

  src = fetchFromGitHub {
    owner = "caelansar";
    repo = "termirs";
    tag = "v${finalAttrs.version}";
    hash = "sha256-UE5RRXP3YUPyot62r2TIPyY6cnb13V5pugRLiUvyJS0=";
  };

  cargoHash = "sha256-I68boX0yiKAwPAd0DGxoSoRKnmcnygywrpmVeJLCkHs=";

  postPatch = ''
    substituteInPlace ../${finalAttrs.cargoDeps.name}/source-git-0/wezterm-term-0.1.0/src/terminalstate/mod.rs \
      --replace-fail 'include_bytes!("../../../termwiz/data/wezterm")' 'include_bytes!("../../../termwiz-0.24.0/data/wezterm")'
  '';

  passthru.updateScript = nix-update-script { };

  # Try to access network stack in sandboxed darwin
  checkFlags = lib.optionals stdenvNoCC.hostPlatform.isDarwin [
    "--skip=async_ssh_client::tests::test_connect_embedded_server"
    "--skip=async_ssh_client::tests::test_port_forwarding"
    "--skip=async_ssh_client::tests::test_port_forwarding_recovers_after_session_drop"
    "--skip=async_ssh_client::tests::test_sftp_receive_large_file"
    "--skip=async_ssh_client::tests::test_sftp_send_large_file"
    "--skip=async_ssh_client::tests::test_sftp_send_receive_roundtrip"
  ];

  meta = {
    description = "Modern async SSH terminal client built with Rust and Ratatui";
    longDescription = ''
      TermiRs provides a fast, secure, and user-friendly terminal
      interface for managing SSH connections with advanced features
      like secure file transfers and encrypted configuration storage.
    '';
    homepage = "https://github.com/caelansar/termirs";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ yiyu ];
    mainProgram = "termirs";
  };
})
