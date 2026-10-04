# AGENTS.md

## Project Overview
PHP + MySQL "Twitter clone" app (Portuguese UI). Plain PHP with mysqli, no framework, no composer. Apache serves `.php` files directly from the repo root.

## Architecture
- **Web**: `php:8.2-apache` with the `mysqli` extension (built via `Dockerfile.base44`). Source is bind-mounted at `/var/www/html`. Host port 3000 → container 80.
- **DB**: `mysql:8.0`. Schema + seed user initialized from `.base44/init.sql` on first boot only (volume persists).
- `db.class.php` reads `DB_HOST`, `DB_USER`, `DB_PASS`, `DB_NAME` env vars (set in compose) with fallback to `localhost`/`root`/empty/`twitter_clone` for local dev.

## Database
- `twitter_clone` database with tables: `usuarios`, `tweet`, `usuarios_seguidores`.
- Seed user: `admin` / `admin` (password is md5-hashed).
- Init SQL only runs on a fresh volume; to re-seed, remove the `db_data` volume.

## Running
```
docker compose -f docker-compose.base44.yml up -d
```
The web container `chmod 755`s the mount root on startup (sandbox bind-mounts are 700 by default, which blocks Apache's `www-data` user).

## Notes
- No live-reload dev server (plain PHP/Apache). Edit PHP files and refresh the browser; for compose/env changes call `reload_preview`.
- App uses PHP sessions (cookies). Auth flow: `index.php` → `validar_acesso.php` → `home.php`.
- The app has no external service dependencies — all credentials are local infra generated in compose.
