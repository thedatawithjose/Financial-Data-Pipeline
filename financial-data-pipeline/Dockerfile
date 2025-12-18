version: '3.8'

services:
  # -------------------------------------------------------------------------
  # Service 1: TimescaleDB (PostgreSQL for Time Series)
  # -------------------------------------------------------------------------
  timescaledb:
    image: timescale/timescaledb:latest-pg14
    container_name: timescaledb
    restart: unless-stopped
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
      POSTGRES_DB: financial_data
    ports:
      - "5432:5432"
    volumes:
      # Persistent storage for DB data
      - timescaledb_data:/var/lib/postgresql/data
      # Auto-init schema on first run
      - ./src/data_etl/storage/schema.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5

  # -------------------------------------------------------------------------
  # Service 2: Python ETL Pipeline
  # -------------------------------------------------------------------------
  etl-pipeline:
    build: 
      context: .
      dockerfile: Dockerfile
    container_name: financial-etl
    depends_on:
      timescaledb:
        condition: service_healthy
    environment:
      # Network Connection
      DB_HOST: timescaledb
      DB_PORT: 5432
      DB_NAME: financial_data
      DB_USER: postgres
      DB_PASSWORD: password
      # App Config
      PYTHONUNBUFFERED: 1
    volumes:
      # Mount local code for development (Hot Reload)
      - .:/app
      # Persist processed files (CSV/Parquet) locally
      - ./data:/app/data

volumes:
  timescaledb_data:
