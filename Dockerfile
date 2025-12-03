# MongoDB Dockerfile for Render Private Service
FROM mongo:7.0

# Set environment variables
ENV MONGO_INITDB_DATABASE=attendx

# Create directory for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy initialization script
COPY docker-entrypoint-initdb.d/init-mongo.js /docker-entrypoint-initdb.d/

# Expose MongoDB port (internal only on Render private network)
EXPOSE 27017

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD mongo --eval "db.adminCommand('ping')" || exit 1

# Use the default MongoDB entrypoint
CMD ["mongod", "--bind_ip_all"]
