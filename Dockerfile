# Official PostgreSQL image
FROM postgres:latest

# Copy SQL script into container's init dir.
COPY lbrp_db.sql /docker-entrypoint-initdb.d/

# Expose port
EXPOSE 5432
