{
  fetchFromGitHub,
  lib,
  postgresql,
  postgresqlBuildExtension,
}:

postgresqlBuildExtension (finalAttrs: {
  pname = "pg_relusage";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "adept";
    repo = "pg_relusage";
    tag = "v${finalAttrs.version}";
    hash = "sha256-WaLSrJOU2SFdLZu0X3uJnYMh7ZP/JUsTGijOVQtY0oA=";
  };

  meta = {
    description = "pg_relusage extension for PostgreSQL: discover and log the relations used in your statements";
    homepage = "https://github.com/adept/pg_relusage";
    maintainers = with lib.maintainers; [ thenonameguy ];
    platforms = postgresql.meta.platforms;
    license = lib.licenses.postgresql;
  };
})
