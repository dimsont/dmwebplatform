using Moq;
using AutoMapper;
using DmWebPlatform.Notifications.Domain.DTOs;
using DmWebPlatform.Notifications.Domain.Entities;
using DmWebPlatform.Notifications.Infrastructure.Interfaces;

namespace DmWebPlatform.Notifications.Tests.Services
{
    public class NotificationServiceTests
    {
        private readonly Mock<IUnitOfWork> _mockUnitOfWork;
        private readonly Mock<IRepository<Notification>> _mockNotificationRepository;
        private readonly Mock<IMapper> _mockMapper; // Mock for IMapper
        private readonly NotificationService _notificationService;

        public NotificationServiceTests()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _mockNotificationRepository = new Mock<IRepository<Notification>>();
            _mockMapper = new Mock<IMapper>(); // Create a mock instance of IMapper

            _mockUnitOfWork.Setup(u => u.Repository<Notification>()).Returns(_mockNotificationRepository.Object);

            _notificationService = new NotificationService(_mockUnitOfWork.Object, _mockMapper.Object); // Pass IMapper mock
        }

        [Fact]
        public async Task AddSubscription_SavesNotification()
        {
            // Arrange
            var notificationDto = new NotificationDto { Email = "test@example.com", EventId = 1 };
            var notificationEntity = new Notification
            {
                Id = 1,
                Email = notificationDto.Email,
                EventId = notificationDto.EventId
            };

            _mockMapper.Setup(m => m.Map<Notification>(It.IsAny<NotificationDto>())).Returns(notificationEntity); // Setup mapper

            _mockNotificationRepository.Setup(r => r.InsertAsync(It.IsAny<Notification>()))
                .Returns(Task.CompletedTask); // Mock InsertAsync

            _mockUnitOfWork.Setup(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()))
                .ReturnsAsync(1); // Mock SaveChangesAsync

            // Act
            await _notificationService.AddSubscription(notificationDto);

            // Assert
            _mockNotificationRepository.Verify(r => r.InsertAsync(It.Is<Notification>(n => n.Email == "test@example.com" && n.EventId == 1)), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()), Times.Once);
        }

        [Fact]
        public async Task GetNotificationsForEvent_ReturnsCorrectNotifications()
        {
            // Arrange
            var eventId = 1;

            // Mock list of notifications (these are the entities, not DTOs)
            var notifications = new List<Notification>
            {
                new Notification { Id = 1, EventId = 1, Email = "test1@example.com" },
                new Notification { Id = 2, EventId = 2, Email = "test2@example.com" }
            };

            // Mock the repository to return the list of notifications
            _mockNotificationRepository.Setup(r => r.GetAllAsync()).ReturnsAsync(notifications);

            // Mock the mapping to return the correct DTOs
            var notificationDtos = new List<NotificationDto>
            {
                new NotificationDto { Id = 1, EventId = 1, Email = "test1@example.com" }
            };

            _mockMapper.Setup(m => m.Map<IEnumerable<NotificationDto>>(It.IsAny<IEnumerable<Notification>>()))
                       .Returns(notificationDtos);

            // Act
            var result = await _notificationService.GetNotificationsForEventAsync(eventId);

            // Assert
            Assert.Single(result);  // Ensures only 1 notification is returned
            Assert.Equal("test1@example.com", result.First().Email);  // Verifies the email matches
        }

        [Fact]
        public async Task RemoveSubscription_DeletesNotification()
        {
            // Arrange
            var notification = new Notification { Id = 1, Email = "test@example.com" };

            _mockNotificationRepository.Setup(r => r.FindAsync(1)).ReturnsAsync(notification);
            _mockNotificationRepository.Setup(r => r.DeleteAsync(It.IsAny<Notification>()))
                .Returns(Task.CompletedTask); // Mock DeleteAsync

            _mockUnitOfWork.Setup(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()))
                .ReturnsAsync(1); // Mock SaveChangesAsync

            // Act
            await _notificationService.RemoveSubscription(1);

            // Assert
            _mockNotificationRepository.Verify(r => r.DeleteAsync(It.Is<Notification>(n => n.Id == 1 && n.Email == "test@example.com")), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()), Times.Once);
        }
    }
}
