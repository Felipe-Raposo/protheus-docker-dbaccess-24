# dbAccess 24.x.y.z

Imagem Docker para execução do **TOTVS dbAccess**, versão 24.x.y.z, em ambiente containerizado.

## Descrição

Este projeto monta uma imagem Docker dbAccess 24.1.1.3 sobre Oracle Linux 9. Serve para desenvolvimento, testes ou orquestração (Kubernetes, Docker Compose, etc.).

Se estiver buscando um ambiente completo com Protheus + License + dbAccess + Postgres, acesse esse [projeto](https://github.com/Felipe-Raposo/protheus-docker-compose).

### Características

- **Base:** Oracle Linux 9
- **Drivers ODBC:** unixODBC, `postgresql-odbc` (`psqlodbca.so`) e Microsoft ODBC Driver 18 for SQL Server
- **dbAccess:** build 24.1.1.3, porta TCP 7890
- **DBAPI:** `dbapi.so` publicado em `http://<host>:7891/dbapi.so` para o AppServer baixar na inicialização
- **Configuração dinâmica:** banco, usuário e senha definidos via `PROTHEUS_DB`, `PROTHEUS_USER` e `PROTHEUS_PASSWORD`

## Pré-requisitos

- Docker (com BuildKit habilitado para build)
- Host de build `linux/amd64` (`make build` passa `--platform=linux/amd64`)

## Build

```bash
# Build local das tags de versão
make build
```

## Publicação da imagem

```bash
# Build e push das tags de versão
make release

# Incluir também a tag latest
make release_latest
```

Gera as tags:

- `feliperaposo/protheus-dbaccess:24`
- `feliperaposo/protheus-dbaccess:24.1.1.3`
- `feliperaposo/protheus-dbaccess:latest`

## Estrutura interna (referência)

- **Entrypoint:** `/dbaccess.sh`
- **Binários:** `/dbaccess/multi/dbaccess64`, `/dbaccess/library/dbaccess64.so`
- **DBAPI:** `/dbaccess/client/dbapi.so`, servido na porta TCP 7891 antes do `dbaccess64`
- **Configuração:** `/dbaccess/multi/dbaccess.ini` (parâmetros `{{PROTHEUS_DB}}`, `{{PROTHEUS_USER}}` e `{{PROTHEUS_PASSWORD}}` substituídos em runtime)

## Licença

Este projeto está sob a [GNU General Public License v3.0](LICENSE).

## Mantenedor

Felipe Raposo — [feliperaposo@gmail.com](mailto:feliperaposo@gmail.com)
