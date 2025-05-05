# Docker CLI Cheat Sheet for Inception Project

This document lists essential Docker CLI commands for building, running, and debugging your WordPress, MariaDB, and Nginx setup.

---

## 🛠 Build & Run

| Command | Description |
|---------|-------------|
| `docker compose up --build` | Build images and start all services. |
| `docker compose up -d` | Start services in detached mode. |
| `docker compose down` | Stop and remove containers, networks, and volumes. |
| `docker compose stop` | Stop running containers (but keep them). |
| `docker compose restart` | Restart running containers. |

---

## 🧾 Monitoring & Logs

| Command | Description |
|---------|-------------|
| `docker ps` | List running containers. |
| `docker compose ps` | Show status of services. |
| `docker logs <container>` | View logs of a container (e.g., `nginx`, `wordpress`). |
| `docker compose logs` | View logs from all services. Add `-f` to follow live logs. |

---

## 🧠 Debugging & Exec

| Command | Description |
|---------|-------------|
| `docker exec -it <container> sh` | Open shell in container. |
| `docker exec -it mariadb mysql -u root -p` | Access MariaDB CLI. (`SHOW DATABASES`) |
| `docker exec wordpress wp <command>` | Run WP-CLI inside WordPress container. |

---

## 📦 Images & Volumes

| Command | Description |
|---------|-------------|
| `docker image ls` | List Docker images. |
| `docker volume ls` | List Docker volumes. |
| `docker volume inspect <volume>` | Show volume details. |
| `docker system prune` | Remove unused data (⚠️ use carefully). |

---
## Extra Commands

| Command | Description |
|---------|-------------|
| `curl -I https://mde-avel.42.fr` | Check certifivate of SSL/TLS (can add -k)|
| `https://mde-avel.42.fr/wp-admin` | Sign in as Administrator |
| `docker network ls` | See all networks |

---

## Cleaning

| Command | Description |
|---------|-------------|
| `docker stop $(docker ps -qa)` | Stop containers |
| `docker rm $(docker ps -qa)` | Remove containers |
| `docker rmi -f $(docker images -qa)` | Remove images |
| `docker volume rm $(docker volume ls -q)` | Remove volumes |
| `docker network rm $(docker network ls -q) 2>/dev/null` | Remove network |
