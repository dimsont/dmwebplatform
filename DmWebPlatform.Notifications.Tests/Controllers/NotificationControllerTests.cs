using Moq;
using Microsoft.AspNetCore.Mvc;
using DmWebPlatform.Notifications.Infrastructure.Interfaces.Services;
using DmWebPlatform.Notifications.Domain.DTOs;
using DmWebPlatform.Notifications.API.Controllers;

namespace DmWebPlatform.Notifications.Tests.Controllers
{
    public class NotificationControllerTests
    {
        private readonly Mock<INotificationService> _mockNotificationService;
        private readonly NotificationController _controller;

        public NotificationControllerTests()
        {
            _mockNotificationService = new Mock<INotificationService>();
            _controller = new NotificationController(_mockNotificationService.Object);
        }

        [Fact]
        public async Task Subscribe_ReturnsOkResult_WhenValidDto()
        {
            // Arrange
            var dto = new NotificationDto { Email = "test@example.com" };

            // Act
            var result = await _controller.Subscribe(dto);

            // Assert
            var actionResult = Assert.IsType<OkObjectResult>(result);
            Assert.Equal("Subscribed successfully.", actionResult.Value);
        }

        [Fact]
        public async Task Subscribe_ReturnsBadRequest_WhenInvalidDto()
        {
            // Arrange
            var dto = new NotificationDto { Email = "" };

            // Act
            var result = await _controller.Subscribe(dto);

            // Assert
            Assert.IsType<BadRequestObjectResult>(result);
        }

        [Fact]
        public async Task Unsubscribe_ReturnsOkResult_WhenValidDto()
        {
            // Arrange
            var dto = new NotificationDto { Id = 1, Email = "test@example.com" };

            // Act
            var result = await _controller.Unsubscribe(dto);

            // Assert
            var actionResult = Assert.IsType<OkObjectResult>(result);
            Assert.Equal("Unsubscribed successfully.", actionResult.Value);
        }

        [Fact]
        public async Task GetNotifications_ReturnsOk_WhenNotificationsExist()
        {
            // Arrange
            var eventId = 1;
            var notifications = new List<NotificationDto> { new NotificationDto { Email = "test@example.com", EventId = eventId } };
            _mockNotificationService.Setup(s => s.GetNotificationsForEventAsync(eventId)).ReturnsAsync(notifications);

            // Act
            var result = await _controller.GetNotifications(eventId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var returnNotifications = Assert.IsType<List<NotificationDto>>(okResult.Value);
            Assert.Single(returnNotifications);
        }

        [Fact]
        public async Task GetNotifications_ReturnsNotFound_WhenNoNotificationsExist()
        {
            // Arrange
            var eventId = 1;
            _mockNotificationService.Setup(s => s.GetNotificationsForEventAsync(eventId)).ReturnsAsync(new List<NotificationDto>());

            // Act
            var result = await _controller.GetNotifications(eventId);

            // Assert
            Assert.IsType<NotFoundObjectResult>(result.Result);
        }
    }
}