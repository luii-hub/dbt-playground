# 🚀 Lightweight dbt + Postgres Playground
This repository provides a ready-to-go Dockerized environment for developing and testing dbt models against a local PostgreSQL database. It is designed to be a "single workspace" where multiple dbt projects can live side-by-side.

# 🏗️ Architecture
**Database:** PostgreSQL 15 (Alpine-based for lightness)

**dbt Engine:** Official dbt-postgres image from dbt Labs

**Persistence:** Docker volumes ensure your data and dbt state survive container restarts.

Note: dbt core is used and not dbt fusion as it is relatively new
