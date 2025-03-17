using AutoMapper;
using DmWebPlatform.Notifications.Domain.DTOs;
using DmWebPlatform.Notifications.Domain.Entities;
using DmWebPlatform.Notifications.Infrastructure.Interfaces;
using DmWebPlatform.Notifications.Infrastructure.Interfaces.Services;

public class NotificationService : INotificationService
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IRepository<Notification> _notificationRepository;
    private readonly IMapper _mapper; // Inject IMapper

    public NotificationService(IUnitOfWork unitOfWork, IMapper mapper)
    {
        _unitOfWork = unitOfWork;
        _notificationRepository = _unitOfWork.Repository<Notification>();
        _mapper = mapper;
    }

    public async Task AddSubscription(NotificationDto notificationDto)
    {
        var notification = _mapper.Map<Notification>(notificationDto);
        await _notificationRepository.InsertAsync(notification);
        await _unitOfWork.SaveChangesAsync();
    }

    public async Task<IList<NotificationDto>> GetNotifications(int eventId)
    {
        var notifications = await _notificationRepository.GetAllAsync();
        var eventNotification = notifications.Where(s => s.EventId == eventId).ToList();
        return _mapper.Map<IList<NotificationDto>>(eventNotification);
    }

    public async Task RemoveSubscription(int notificationId)
    {
        var notification = await _notificationRepository.FindAsync(notificationId);
        if (notification != null)
        {
            await _notificationRepository.DeleteAsync(notification);
            await _unitOfWork.SaveChangesAsync();
        }
    }

    public async Task<IEnumerable<NotificationDto>> GetNotificationsForEventAsync(int eventId)
    {
        var notifications = await _notificationRepository.GetAllAsync();
        var eventNotification = notifications.Where(s => s.EventId == eventId);
        return _mapper.Map<IEnumerable<NotificationDto>>(eventNotification);
    }

    public async Task SendNotificationsAsync()
    {
        var notifications = await _notificationRepository.GetAllAsync();
        foreach (var notification in notifications)
        {
            var notificationTime = notification.NotificationTime;
            if (notificationTime <= DateTime.UtcNow)
            {
                //TODO: send notification.
                //await _emailSender.SendEmailAsync(notification.Email, "Event Notification", "Your event is coming up soon!");
                // Optionally remove subscription or update status after sending notification
            }
        }

        await _unitOfWork.SaveChangesAsync();
    }
}
