using DmWebPlatform.Domain.Entities;
using DmWebPlatform.Infrastructure.Enums;

namespace DmWebPlatform.Infrastructure.Interfaces.Services
{
    public interface IAuditLogService
    {
        Task<List<AuditLogEntry>> GetAuditLogsAsync();
        Task LogActionAsync(AuditActionType actionType, string payload);
    }
}
