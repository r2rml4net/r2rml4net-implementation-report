#!/bin/bash
set -u

function init_mssql {
  PASSWORD="Passw0rd1"

  docker-compose exec -T mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $PASSWORD -Q "drop database IF EXISTS [$database]"
  docker-compose exec -T mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $PASSWORD -Q "create database [$database]"
  docker-compose exec -T mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $PASSWORD -d "$database" -i "$script" -I
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --script) script="$2"; shift ;;
        --database) database="$2"; shift ;;
        --engine) engine="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

case $engine in
  "http://www.w3.org/ns/r2rml#MSSQLServer") init_mssql ;;
  *) echo "Unrecognized db engine $engine"; exit 1 ;;
esac
