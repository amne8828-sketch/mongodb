// MongoDB Initialization Script for attendX
// This script runs once when the database is first created

// Switch to attendx database
db = db.getSiblingDB('attendx');

// Create collections with validation
db.createCollection('users', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            required: ['email', 'name'],
            properties: {
                email: {
                    bsonType: 'string',
                    description: 'must be a string and is required'
                },
                name: {
                    bsonType: 'string',
                    description: 'must be a string and is required'
                },
                password: {
                    bsonType: 'string',
                    description: 'hashed password'
                },
                role: {
                    bsonType: 'string',
                    enum: ['user', 'admin', 'superadmin'],
                    description: 'user role'
                },
                created_at: {
                    bsonType: 'date',
                    description: 'creation timestamp'
                }
            }
        }
    }
});

db.createCollection('attendance_logs');
db.createCollection('enrollment_requests');
db.createCollection('ip_cameras');
db.createCollection('system_logs');

// Create indexes for performance
db.users.createIndex({ email: 1 }, { unique: true });
db.users.createIndex({ role: 1 });
db.attendance_logs.createIndex({ user_id: 1, timestamp: -1 });
db.enrollment_requests.createIndex({ email: 1 });
db.enrollment_requests.createIndex({ status: 1 });
db.ip_cameras.createIndex({ camera_name: 1 });
db.system_logs.createIndex({ timestamp: -1 });

print('MongoDB initialized successfully for attendX');
print('Collections created: users, attendance_logs, enrollment_requests, ip_cameras, system_logs');
print('Indexes created for optimal performance');
