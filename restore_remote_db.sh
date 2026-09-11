#!/usr/bin/env bash
# ==============================================================================
# SALAHADDIN UNIVERSITY RESEARCH CENTER (SURC) - PHYSICAL DATABASE RESTORE
# ==============================================================================

set -e

GREEN='\033[0;32m'
MAROON='\033[0;31m'
GOLD='\033[0;33m'
NC='\033[0m'

echo -e "${GOLD}"
echo "=========================================================================="
echo "      SURC - DELETING OLD DATABASE & RESTORING PHYSICAL SQL DUMP          "
echo "=========================================================================="
echo -e "${NC}"

# Check root permission
if [ "$EUID" -ne 0 ]; then
  echo -e "${MAROON}Error: Please run this script as root (e.g. sudo bash restore_remote_db.sh)${NC}"
  exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DUMP_FILE="$SCRIPT_DIR/surc_production_db.sql"

if [ ! -f "$DUMP_FILE" ]; then
  echo -e "${MAROON}Error: Dump file surc_production_db.sql not found at ${DUMP_FILE}!${NC}"
  exit 1
fi

echo -e "${GREEN}[1/3] Terminating active connections and dropping old 'surc_db' database...${NC}"
sudo -u postgres psql -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'surc_db' AND pid <> pg_backend_pid();" 2>/dev/null || true
sudo -u postgres psql -c "DROP DATABASE IF EXISTS surc_db;"

echo -e "${GREEN}[2/3] Creating fresh 'surc_db' database and assigning privileges...${NC}"
sudo -u postgres psql -c "CREATE DATABASE surc_db OWNER surc_user;" 2>/dev/null || sudo -u postgres psql -c "CREATE DATABASE surc_db;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE surc_db TO surc_user;" 2>/dev/null || true

echo -e "${GREEN}[3/3] Importing physical SQL snapshot (surc_production_db.sql)...${NC}"
sudo -u postgres psql -d surc_db -f "$DUMP_FILE"

echo -e "${GOLD}"
echo "=========================================================================="
echo "  SUCCESS: Old database deleted & physical snapshot imported faithfully!  "
echo "=========================================================================="
echo -e "${NC}"

# Restart PM2 backend to refresh connection pool
if command -v pm2 &> /dev/null; then
  echo "Restarting backend services..."
  pm2 restart surc-backend 2>/dev/null || pm2 restart all 2>/dev/null || true
fi
