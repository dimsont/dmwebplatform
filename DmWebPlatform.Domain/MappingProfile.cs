using AutoMapper;
using DmWebPlatform.Domain.DTOs;
using DmWebPlatform.Domain.Entities;

namespace DmWebPlatform.Domain
{

    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Event, EventDto>().ReverseMap();
            CreateMap<AuditLogDto, AuditLogDto>().ReverseMap();
        }
    }

}
