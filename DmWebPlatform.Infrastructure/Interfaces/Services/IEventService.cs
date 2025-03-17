
using DmWebPlatform.Domain.DTOs;

namespace DmWebPlatform.Infrastructure.Interfaces.Services
{
    public interface IEventService
    {
        /// <summary>
        /// Get all items of Event table
        /// </summary>
        /// <returns></returns>
        Task<IList<EventDto>> GetAll();
        Task<EventDto> GetOne(int eventId);
        Task Update(EventDto eventInput);
        Task Add(EventDto eventInput);
        Task Delete(int eventId);
        Task<IList<EventDto>> SearchEventsAsync(string searchTerm);
    }
}
