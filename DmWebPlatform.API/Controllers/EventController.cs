using DmWebPlatform.Domain.DTOs;
using DmWebPlatform.Infrastructure.Enums;
using DmWebPlatform.Infrastructure.Interfaces.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DmWebPlatform.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Produces("application/json")]
    public class EventController : ControllerBase
    {
        private readonly IEventService _eventService;
        private readonly IAuditLogService _auditLogService;

        public EventController(IEventService eventService, IAuditLogService auditLogService)
        {
            _eventService = eventService;
            _auditLogService = auditLogService;
        }

        // Guest: Can view the calendar of events
        [HttpGet(Name = "GetAllEvents")]
        [ProducesResponseType(typeof(IEnumerable<EventDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<IEnumerable<EventDto>>> GetAllEvents()
        {
            try
            {
                var events = await _eventService.GetAll();
                return Ok(events);
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }

        // Guest: Can view specific events
        [HttpGet("{id}", Name = "GetEventById")]
        [ProducesResponseType(typeof(EventDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<EventDto>> GetEventById(int id)
        {
            var eventItem = await _eventService.GetOne(id);

            if (eventItem == null)
            {
                return NotFound();
            }

            return Ok(eventItem);
        }

        // Admin: Can create events
        [Authorize(Roles = "Admin")]
        [HttpPost(Name = "CreateEvent")]
        [ProducesResponseType(typeof(EventDto), StatusCodes.Status201Created)]
        public async Task<ActionResult<EventDto>> CreateEvent(EventDto item)
        {
            await _eventService.Add(item);

            // Log the creation of the event
            var userId = User?.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "Anonymous";
            await _auditLogService.LogActionAsync(AuditActionType.CreateEvent, $"Created event with ID: {item.Id}");

            return CreatedAtAction(nameof(GetEventById), new { id = item.Id }, item);
        }

        // Admin: Can update events
        [Authorize(Roles = "Admin")]
        [HttpPut("{id}", Name = "UpdateEvent")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateEvent(int id, EventDto item)
        {
            if (id != item.Id)
            {
                return BadRequest("Event ID mismatch");
            }

            await _eventService.Update(item);

            // Log the update action
            var userId = User?.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "Anonymous";
            await _auditLogService.LogActionAsync(AuditActionType.UpdateEvent, $"Updated event with ID: {item.Id}");

            return NoContent();
        }

        // Admin: Can delete events
        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}", Name = "DeleteEvent")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        public async Task<IActionResult> DeleteEvent(int id)
        {
            await _eventService.Delete(id);

            // Log the deletion of the event
            var userId = User?.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "Anonymous";
            await _auditLogService.LogActionAsync(AuditActionType.DeleteEvent, $"Deleted event with ID: {id}");

            return NoContent();
        }

        // All roles can search for events
        [HttpGet("search")]
        [ProducesResponseType(typeof(IList<EventDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<IList<EventDto>>> SearchEvents([FromQuery] string searchTerm)
        {
            if (string.IsNullOrEmpty(searchTerm))
            {
                return BadRequest("Search term cannot be empty.");
            }

            var events = await _eventService.SearchEventsAsync(searchTerm);

            if (events == null || !events.Any())
            {
                return NotFound("No matching events found.");
            }

            // Log the search action
            var userId = User?.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "Anonymous";
            await _auditLogService.LogActionAsync(AuditActionType.SearchEvent, $"Searched for events with term: {searchTerm}");

            return Ok(events);
        }
    }
}
