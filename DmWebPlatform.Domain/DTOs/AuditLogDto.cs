namespace DmWebPlatform.Domain.DTOs
{
    public class AuditLogDto
    {
        public string Id { get; set; }  // String representation of ObjectId
        public DateTime Timestamp { get; set; }
        public string Action { get; set; }
        public string UserId { get; set; }
        public string Payload { get; set; }
    }
}
