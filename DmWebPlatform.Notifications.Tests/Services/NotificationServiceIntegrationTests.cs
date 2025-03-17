using AutoMapper;
using DmWebPlatform.Notifications.DataAccess;
using DmWebPlatform.Notifications.Domain.DTOs;
using DmWebPlatform.Notifications.Domain.Entities;
using DmWebPlatform.Notifications.Infrastructure;
using Microsoft.EntityFrameworkCore;

namespace DmWebPlatform.Notifications.Tests.Services
{
    public class NotificationServiceIntegrationTests
    {
        private readonly NotificationDbContext _context;
        private readonly NotificationService _notificationService;

        public NotificationServiceIntegrationTests()
        {
            var options = new DbContextOptionsBuilder<NotificationDbContext>()
                          .UseInMemoryDatabase(databaseName: "TestDatabase")
                          .Options;

            _context = new NotificationDbContext(options);
            var dbFactory = new DbFactory(() => _context);
            var unitOfWork = new UnitOfWork(dbFactory);

            // Mock IMapper
            var mockMapper = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<NotificationDto, Notification>();
            }).CreateMapper();

            // Initialize NotificationService with IMapper
            _notificationService = new NotificationService(unitOfWork, mockMapper);
        }

        [Fact]
        public async Task AddSubscription_StoresSubscriptionInDb()
        {
            // Arrange
            var notificationDto = new NotificationDto
            {
                Email = "test@example.com",
                EventId = 1,
                NotificationTime = DateTime.UtcNow.AddDays(1)
            };

            // Act
            await _notificationService.AddSubscription(notificationDto);

            // Assert
            var notifications = await _context.Notifications.ToListAsync();
            Assert.Single(notifications);
            Assert.Equal("test@example.com", notifications[0].Email);
        }
    }
}
