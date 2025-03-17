using DmWebPlatform.Domain.Entities;

namespace DmWebPlatform.Infrastructure.Interfaces.Services
{
    public interface ITokenService
    {
        Task<string> GenerateToken(ApplicationUser user);
    }
}
