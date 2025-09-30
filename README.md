# tanspaces

Turnkey container stack for running Jupyter-based dev workspaces alongside shared services and proxying.

## What it does
- Builds a curated JupyterLab image (`environments/jupyterbase`) with SSH, DB headers, Git fixes, and Lab defaults.
- Provides reusable docker-compose stacks:
  - `network/` for the Caddy reverse proxy on the shared `tanspaces` network.
  - `services/` for shared Postgres (with backups), MongoDB, RabbitMQ, Adminer, and cron.
  - `jupyterservice/` for project workspaces that mount code, install requirements, and expose Jupyter + app ports.

## Bootstrapping the stack
1. Create the external network once: `docker network create tanspaces` (safe to rerun).
2. Start the proxy: `docker compose -f network/docker-compose.yml up -d`.
3. Start shared services: `docker compose -f services/docker-compose.yml up -d`.
4. For each project, export (via a .env file): `PROJECT_DIR`, `COMPOSE_PROJECT_NAME`, `ACCESS_TOKEN`, `POSTGRES_PASSWORD`, and `JUPYTER_SERVICE=../tanspaces/jupyterservice/docker-compose.yml`, then run that project’s `docker compose up -d`.

To resume after downtime, ensure the network exists and re-run any `docker compose up -d` commands you need; volumes keep database and backup state.

## Accessing components
- Jupyter workspaces: `https://<host>:8081/tanspaces.<project>/lab`
- Dev app servers from workspace containers: `https://<host>:8081/<app-path>/`
- Deployed app stacks (their own compose files) usually publish on port `5000` via Caddy, e.g. `https://<host>:5000/<app-path>/`
- Shared services (Adminer, etc.) listen on the same proxy—see labels in `services/docker-compose.yml` for URLs.

## Onboarding a new project
1. Clone the project into `${PROJECT_DIR}/<name>`.
2. Drop a `docker-compose.yml` that extends `${JUPYTER_SERVICE}` and sets Caddy labels for your app path.
3. Add a `requirements.txt` with `-e .` so edits inside the workspace hot-reload.
4. Run `docker compose up -d` to launch the workspace; use `docker compose -f deploy/docker-compose.yml up -d` (if provided) for production-style containers.

This repo stays focused on infrastructure—each project repo keeps its own application code while relying on tanspaces for consistent tooling, routing, and shared data stores.
