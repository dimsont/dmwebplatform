using AutoMapper;
using DmWebPlatform.Domain.DTOs;
using DmWebPlatform.Domain.Entities;
using DmWebPlatform.Infrastructure.Interfaces;
using DmWebPlatform.Infrastructure.Interfaces.Services;

public class EventService : IEventService
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IRepository<Event> _eventRepository;
    private readonly IMapper _mapper; // Inject IMapper
    private readonly HttpClient _httpClient; // For communicating with the Notification service

    public EventService(IUnitOfWork unitOfWork, IMapper mapper, HttpClient httpClient)
    {
        _unitOfWork = unitOfWork;
        _eventRepository = _unitOfWork.Repository<Event>();
        _mapper = mapper;
        _httpClient = httpClient;
    }

    public async Task<IList<EventDto>> GetAll()
    {
        var events = await _eventRepository.GetAllAsync();
        return _mapper.Map<IList<EventDto>>(events);
    }

    public async Task<EventDto> GetOne(int eventId)
    {
        var eventItem = await _eventRepository.FindAsync(eventId);
        return _mapper.Map<EventDto>(eventItem);
    }

    public async Task Add(EventDto eventInput)
    {
        var eventItem = _mapper.Map<Event>(eventInput);
        await _eventRepository.InsertAsync(eventItem);
        await _unitOfWork.SaveChangesAsync();
    }

    public async Task Update(EventDto eventInput)
    {
        var eventItem = await _eventRepository.FindAsync(eventInput.Id);
        if (eventItem == null)
            throw new KeyNotFoundException();

        _mapper.Map(eventInput, eventItem);
        await _unitOfWork.SaveChangesAsync();
    }

    public async Task Delete(int eventId)
    {
        var eventItem = await _eventRepository.FindAsync(eventId);
        if (eventItem == null)
            throw new KeyNotFoundException();

        await _eventRepository.DeleteAsync(eventItem);
        await _unitOfWork.SaveChangesAsync();
    }

    public async Task<IList<EventDto>> SearchEventsAsync(string searchTerm)
    {
        var events = await _eventRepository.GetAllAsync();

        var filteredEvents = events
            .Where(e => e.Name.Contains(searchTerm, StringComparison.OrdinalIgnoreCase) ||
                        e.Description.Contains(searchTerm, StringComparison.OrdinalIgnoreCase) ||
                        e.Place.Contains(searchTerm, StringComparison.OrdinalIgnoreCase))
            .ToList();

        return _mapper.Map<IList<EventDto>>(filteredEvents);
    }
}
