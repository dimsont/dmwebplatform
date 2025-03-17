using DmWebPlatform.Notifications.Domain.DTOs;
using DmWebPlatform.Notifications.Infrastructure.Interfaces.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DmWebPlatform.Notifications.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class NotificationController : ControllerBase
    {
        private readonly INotificationService _notificationService;

        public NotificationController(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        // Subscribe to an event
        [HttpPost("subscribe")]
        [Authorize(Roles = "User")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> Subscribe([FromBody] NotificationDto dto)
        {
            if (dto == null || string.IsNullOrEmpty(dto.Email))
            {
                return BadRequest("Invalid subscription data.");
            }

            await _notificationService.AddSubscription(dto);
            return Ok("Subscribed successfully.");
        }

        // Unsubscribe from an event
        [HttpPost("unsubscribe")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> Unsubscribe([FromBody] NotificationDto dto)
        {
            if (dto == null || string.IsNullOrEmpty(dto.Email))
            {
                return BadRequest("Invalid unsubscription data.");
            }

            await _notificationService.RemoveSubscription(dto.Id);
            return Ok("Unsubscribed successfully.");
        }

        // Get all notifications for an event
        [HttpGet("{eventId}")]
        [Authorize(Roles = "User")]
        [Authorize(Roles = "Instructor")]
        [ProducesResponseType(typeof(IEnumerable<NotificationDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<IEnumerable<NotificationDto>>> GetNotifications(int eventId)
        {
            var notifications = await _notificationService.GetNotificationsForEventAsync(eventId);

            if (notifications == null || !notifications.Any())
            {
                return NotFound("No notifications found for the specified event.");
            }

            return Ok(notifications);
        }
    }
}