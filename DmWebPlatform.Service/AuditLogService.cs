using DmWebPlatform.Domain.Entities;
using DmWebPlatform.Infrastructure.Enums;
using DmWebPlatform.Infrastructure.Interfaces.Services;
using Microsoft.AspNetCore.Http;
using MongoDB.Driver;

namespace DmWebPlatform.Service
{
    public class AuditLogService : IAuditLogService
    {
        private readonly IMongoCollection<AuditLogEntry> _auditLogCollection;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public AuditLogService(IMongoDatabase database, IHttpContextAccessor httpContextAccessor)
        {
            _auditLogCollection = database.GetCollection<AuditLogEntry>("AuditLogs");
            _httpContextAccessor = httpContextAccessor;
        }


        public async Task LogActionAsync(AuditActionType actionType, string payload)
        {
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;

            var logEntry = new AuditLogEntry
            {
                Timestamp = DateTime.UtcNow,
                Action = actionType.ToString(),
                UserName = user,
                Payload = payload
            };

            await _auditLogCollection.InsertOneAsync(logEntry);
        }

        public async Task<List<AuditLogEntry>> GetAuditLogsAsync()
        {
            return await _auditLogCollection.Find(_ => true).ToListAsync();
        }
    }

}
