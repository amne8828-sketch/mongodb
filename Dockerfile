# MongoDB Dockerfile for Render Web Service with Authentication
FROM mongo:7.0

# Set environment variables for MongoDB initialization
# These will be set via Render environment variables:
# MONGO_INITDB_ROOT_USERNAME - Admin username
# MONGO_INITDB_ROOT_PASSWORD - Admin password
# MONGO_INITDB_DATABASE - Database name
ENV MONGO_INITDB_DATABASE=attendx

# Create directory for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy initialization script
COPY docker-entrypoint-initdb.d/init-mongo.js /docker-entrypoint-initdb.d/

# Expose MongoDB port
EXPOSE 27017

# Health check with authentication
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD mongosh --eval "db.adminCommand('ping')" || exit 1

# Start MongoDB with authentication enabled and bind to all interfaces
# MongoDB will automatically enable auth when MONGO_INITDB_ROOT_USERNAME is set
CMD ["mongod", "--bind_ip_all", "--auth"]
