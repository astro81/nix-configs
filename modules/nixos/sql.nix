{ pkgs, ... }:
{
  # Postgres
  services.postgresql.enable = true;
  services.postgresql.ensureDatabases = [ "postgres_db" ];
  services.postgresql.authentication = pkgs.lib.mkOverride 10 ''
    #type database  DBuser  auth-method
    local all       all     trust
  '';


  # Mysql
  # services.mysql.enable = true;
  # services.mysql.package = pkgs.mariadb;
  # services.mysql.ensureUsers = [
  #   {
  #     name = "prisma";
  #     ensurePermissions = {
  #       "prisma_db.*" = "ALL PRIVILEGES";
  #     };
  #   }
  # ];
  # services.mysql.ensureDatabases = [ "prisma_db" ];
    
}
