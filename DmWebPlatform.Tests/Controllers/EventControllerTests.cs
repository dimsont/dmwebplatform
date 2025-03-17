using DmWebPlatform.API.Controllers;
using DmWebPlatform.Domain.DTOs;
using DmWebPlatform.Infrastructure.Interfaces.Services;
using Microsoft.AspNetCore.Mvc;
using Moq;

namespace DmWebPlatform.Tests.Controllers
{
    public class EventsControllerTests
    {
        private readonly EventController _controller;
        private readonly Mock<IEventService> _mockEventService;
        private readonly Mock<IAuditLogService> _mockAuditLogService;


        public EventsControllerTests()
        {
            _mockEventService = new Mock<IEventService>();
            _mockAuditLogService = new Mock<IAuditLogService>();
            _controller = new EventController(_mockEventService.Object, _mockAuditLogService.Object);
        }

        [Fact]
        public async Task GetAllEvents_ReturnsOkResult_WithListOfEvents()
        {
            // Arrange
            var mockEvents = new List<EventDto>
            {
                new EventDto { Id = 1, Name = "Event 1", Description = "Description 1" },
                new EventDto { Id = 2, Name = "Event 2", Description = "Description 2" }
            };
            _mockEventService.Setup(s => s.GetAll()).ReturnsAsync(mockEvents);

            // Act
            var result = await _controller.GetAllEvents();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var returnedEvents = Assert.IsType<List<EventDto>>(okResult.Value);
            Assert.Equal(2, returnedEvents.Count);
        }

        [Fact]
        public async Task GetEventById_ReturnsOkResult_WithEvent()
        {
            // Arrange
            var mockEvent = new EventDto { Id = 1, Name = "Event 1", Description = "Description 1" };
            _mockEventService.Setup(s => s.GetOne(1)).ReturnsAsync(mockEvent);

            // Act
            var result = await _controller.GetEventById(1);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var returnedEvent = Assert.IsType<EventDto>(okResult.Value);
            Assert.Equal(1, returnedEvent.Id);
        }

        [Fact]
        public async Task GetEventById_ReturnsNotFound_WhenEventDoesNotExist()
        {
            // Arrange
            _mockEventService.Setup(s => s.GetOne(1)).ReturnsAsync((EventDto)null);

            // Act
            var result = await _controller.GetEventById(1);

            // Assert
            Assert.IsType<NotFoundResult>(result.Result);
        }

        [Fact]
        public async Task CreateEvent_ReturnsCreatedAtAction()
        {
            // Arrange
            var mockEvent = new EventDto { Id = 1, Name = "Event 1", Description = "Description 1" };
            _mockEventService.Setup(s => s.Add(mockEvent)).Returns(Task.CompletedTask);

            // Act
            var result = await _controller.CreateEvent(mockEvent);

            // Assert
            var createdAtActionResult = Assert.IsType<CreatedAtActionResult>(result.Result);
            var createdEvent = Assert.IsType<EventDto>(createdAtActionResult.Value);
            Assert.Equal(1, createdEvent.Id);
        }

        [Fact]
        public async Task UpdateEvent_ReturnsNoContent_WhenEventIsUpdated()
        {
            // Arrange
            var mockEvent = new EventDto { Id = 1, Name = "Event 1", Description = "Description 1" };
            _mockEventService.Setup(s => s.Update(mockEvent)).Returns(Task.CompletedTask);

            // Act
            var result = await _controller.UpdateEvent(1, mockEvent);

            // Assert
            Assert.IsType<NoContentResult>(result);
        }

        [Fact]
        public async Task UpdateEvent_ReturnsBadRequest_WhenIdMismatch()
        {
            // Arrange
            var mockEvent = new EventDto { Id = 1, Name = "Event 1", Description = "Description 1" };

            // Act
            var result = await _controller.UpdateEvent(2, mockEvent);

            // Assert
            Assert.IsType<BadRequestObjectResult>(result);
        }

        [Fact]
        public async Task DeleteEvent_ReturnsNoContent_WhenEventIsDeleted()
        {
            // Arrange
            _mockEventService.Setup(s => s.Delete(1)).Returns(Task.CompletedTask);

            // Act
            var result = await _controller.DeleteEvent(1);

            // Assert
            Assert.IsType<NoContentResult>(result);
        }
    }
}
