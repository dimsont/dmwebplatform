using AutoMapper;
using DmWebPlatform.Notifications.Domain.DTOs;
using DmWebPlatform.Notifications.Domain.Entities;

namespace DmWebPlatform.Notifications.Domain
{

    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Notification, NotificationDto>().ReverseMap();
        }
    }

}
