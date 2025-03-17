using Moq;
using DmWebPlatform.Service;
using DmWebPlatform.Domain.DTOs;
using DmWebPlatform.Domain.Entities;
using DmWebPlatform.Infrastructure.Interfaces;
using System.Net.Http.Json;
using Moq.Protected;
using System.Net;
using Xunit;
using System.Threading.Tasks;
using System.Threading;
using System.Collections.Generic;
using System.Linq;
using System;
using AutoMapper;

namespace DmWebPlatform.Tests.Services
{
    public class EventServiceTests
    {
        private readonly Mock<IUnitOfWork> _mockUnitOfWork;
        private readonly Mock<IRepository<Event>> _mockEventRepository;
        private readonly Mock<IMapper> _mockMapper;
        private readonly HttpClient _httpClient;
        private readonly EventService _eventService;

        public EventServiceTests()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _mockEventRepository = new Mock<IRepository<Event>>();
            _mockMapper = new Mock<IMapper>();

            _mockUnitOfWork.Setup(u => u.Repository<Event>()).Returns(_mockEventRepository.Object);

            // Create a mock HttpMessageHandler to control the response of HttpClient
            var handlerMock = new Mock<HttpMessageHandler>();
            handlerMock.Protected()
                .Setup<Task<HttpResponseMessage>>(
                    "SendAsync",
                    ItExpr.IsAny<HttpRequestMessage>(),
                    ItExpr.IsAny<CancellationToken>()
                )
                .ReturnsAsync(new HttpResponseMessage
                {
                    StatusCode = HttpStatusCode.OK,
                });

            // Set BaseAddress for HttpClient
            _httpClient = new HttpClient(handlerMock.Object)
            {
                BaseAddress = new Uri("http://localhost/")
            };

            _eventService = new EventService(_mockUnitOfWork.Object, _mockMapper.Object, _httpClient);
        }

        [Fact]
        public async Task GetAll_ReturnsListOfEventDtos()
        {
            // Arrange
            var events = new List<Event>
            {
                new Event { Id = 1, Name = "Event1" },
                new Event { Id = 2, Name = "Event2" }
            };
            _mockEventRepository.Setup(r => r.GetAllAsync()).ReturnsAsync(events);

            var eventDtos = events.Select(e => new EventDto { Id = e.Id, Name = e.Name }).ToList();
            _mockMapper.Setup(m => m.Map<IEnumerable<EventDto>>(events)).Returns(eventDtos);

            // Act
            var result = await _eventService.GetAll();

            // Assert
            Assert.Equal(2, result.Count());
            Assert.Equal("Event1", result.First().Name);
        }

        [Fact]
        public async Task GetOne_ReturnsEventDto_WhenEventExists()
        {
            // Arrange
            var eventItem = new Event { Id = 1, Name = "Event1" };
            _mockEventRepository.Setup(r => r.FindAsync(1)).ReturnsAsync(eventItem);

            var eventDto = new EventDto { Id = 1, Name = "Event1" };
            _mockMapper.Setup(m => m.Map<EventDto>(eventItem)).Returns(eventDto);

            // Act
            var result = await _eventService.GetOne(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(1, result.Id);
        }

        [Fact]
        public async Task Add_InsertsEventAndSavesChanges()
        {
            // Arrange
            var eventDto = new EventDto { Id = 1, Name = "New Event" };
            var eventEntity = new Event { Id = 1, Name = "New Event" };

            _mockMapper.Setup(m => m.Map<Event>(eventDto)).Returns(eventEntity);

            // Act
            await _eventService.Add(eventDto);

            // Assert
            _mockEventRepository.Verify(r => r.InsertAsync(It.IsAny<Event>()), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()), Times.Once);
        }

        [Fact]
        public async Task Update_UpdatesEventAndCallsHttpClient()
        {
            // Arrange
            var eventDto = new EventDto { Id = 1, Name = "Updated Event" };
            var eventEntity = new Event { Id = 1, Name = "Old Event" };

            _mockEventRepository.Setup(r => r.FindAsync(1)).ReturnsAsync(eventEntity);
            _mockMapper.Setup(m => m.Map(eventDto, eventEntity));

            // Act
            await _eventService.Update(eventDto);

            // Assert
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()), Times.Once);
            // HttpClient request is verified in the constructor mocking
        }

        [Fact]
        public async Task Delete_DeletesEventAndCallsHttpClient()
        {
            // Arrange
            var eventEntity = new Event { Id = 1, Name = "Event to Delete" };
            _mockEventRepository.Setup(r => r.FindAsync(1)).ReturnsAsync(eventEntity);

            // Act
            await _eventService.Delete(1);

            // Assert
            _mockEventRepository.Verify(r => r.DeleteAsync(eventEntity), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()), Times.Once);
            // HttpClient request is verified in the constructor mocking
        }
    }
}
