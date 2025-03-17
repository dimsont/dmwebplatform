using MongoDB.Bson;

namespace DmWebPlatform.Domain.Entities
{
    public class AuditLogEntry
    {
        public ObjectId Id { get; set; }  // Use ObjectId for MongoDB document IDs
        public DateTime Timestamp { get; set; }
        public string Action { get; set; } = string.Empty; // Create, Edit, Delete, Subscribe
        public string UserId { get; set; } = string.Empty; // User performing the action
        public string Payload { get; set; } = string.Empty; // Minimal needed non-personal information
        public string UserName { get; set; } = string.Empty;
    }
}
