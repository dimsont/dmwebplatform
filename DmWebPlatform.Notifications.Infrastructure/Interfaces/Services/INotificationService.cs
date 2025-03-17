using DmWebPlatform.Notifications.Domain.DTOs;

namespace DmWebPlatform.Notifications.Infrastructure.Interfaces.Services
{
    public interface INotificationService
    {
        Task AddSubscription(NotificationDto notificationDto);
        Task<IList<NotificationDto>> GetNotifications(int eventId);
        Task RemoveSubscription(int notificationId);
        Task<IEnumerable<NotificationDto>> GetNotificationsForEventAsync(int eventId);
        Task SendNotificationsAsync();
    }
}
