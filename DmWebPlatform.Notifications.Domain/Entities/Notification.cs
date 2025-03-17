namespace DmWebPlatform.Notifications.Domain.Entities
{
    public class Notification
    {
        public int Id { get; set; }
        public int EventId { get; set; }
        public string Email { get; set; }
        public DateTime NotificationTime { get; set; }
        public bool IsSent { get; set; }
    }
}
