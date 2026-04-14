#!/bin/bash

# Configuration
PORT=5500

# 1. Start the Dynamic API (Docker)
echo "📦 Starting Dynamic API Containers..."
cd swagger-ui && docker compose up -d && cd ..

# 2. Initialize/Populate Database
echo "🗄️  Populating MariaDB Container with schema.sql..."
cat schema.sql | docker exec -i mariadb_container mysql -u root -p'54321Ba##'

# 3. Start the Python HTTP server
echo ""
echo "------------------------------------------------"
echo "  🚀 Poly Bodeguita - Starting Web Server"
echo "------------------------------------------------"
echo "  📍 Root: $(pwd)"
echo "  🌐 URL:  http://localhost:$PORT"
echo "------------------------------------------------"
echo "Press Ctrl+C to stop the Python server (API will remain in background)"
echo ""

python3 -m http.server $PORT
