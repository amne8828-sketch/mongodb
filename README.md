# MongoDB for attendX

MongoDB deployment configuration for Render private service.

## Quick Start

1. **Deploy on Render**:
   - Create new Private Service
   - Point to this `mongodb/` directory
   - Use Dockerfile: `./Dockerfile`
   - Choose plan (Starter for persistent storage)

2. **Get Connection String**:
   ```
   mongodb://attendx-mongodb:27017/attendx
   ```

3. **Update Your Services**:
   - Set `MONGODB_URI` environment variable in attendX
   - Set `MONGODB_URI` environment variable in face_engine_service (if needed)

## Files

- `Dockerfile` - MongoDB container configuration
- `docker-entrypoint-initdb.d/init-mongo.js` - Database initialization script
- `render.yaml` - Render deployment configuration
- `DEPLOYMENT_GUIDE.md` - Comprehensive deployment guide

## Database Schema

The initialization script creates:

### Collections
- `users` - User accounts with validation
- `attendance_logs` - Attendance records
- `enrollment_requests` - Pending enrollment requests
- `ip_cameras` - IP camera configurations
- `system_logs` - System activity logs

### Indexes
- Email uniqueness on users
- User role indexing
- Attendance logs by user and timestamp
- Enrollment request status indexing

## Important Notes

⚠️ **Free Tier Warning**: Render's free tier does NOT provide persistent disk storage for private services. Your data will be lost on service restarts.

💰 **Paid Plans**: Starter plan ($7/month) includes persistent disk storage.

🌟 **Alternative**: Consider MongoDB Atlas free tier (M0) for production with persistent storage.

## See Also

- [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) - Full deployment instructions
- [Render Private Services Docs](https://render.com/docs/private-services)
- [MongoDB Docker Hub](https://hub.docker.com/_/mongo)
