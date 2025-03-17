namespace DmWebPlatform.Notifications.Domain.DTOs
{
    public class NotificationDto
    {
        public int Id { get; set; }
        public int EventId { get; set; }
        public string Email { get; set; }
        public DateTime NotificationTime { get; set; }
        public bool IsSent { get; set; }
    }
}
