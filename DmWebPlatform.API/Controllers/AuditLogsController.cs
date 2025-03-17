using AutoMapper;
using DmWebPlatform.Domain.DTOs;
using DmWebPlatform.Domain.Entities;
using DmWebPlatform.Infrastructure.Enums;
using DmWebPlatform.Infrastructure.Interfaces.Services;
using Microsoft.AspNetCore.Mvc;

namespace DmWebPlatform.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuditLogsController : ControllerBase
    {
        private readonly IAuditLogService _auditLogService;
        private readonly IMapper _mapper;

        public AuditLogsController(IAuditLogService auditLogService, IMapper mapper)
        {
            _auditLogService = auditLogService;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AuditLogDto>>> GetAuditLogs()
        {
            var auditLogs = await _auditLogService.GetAuditLogsAsync();
            var auditLogDtos = _mapper.Map<IEnumerable<AuditLogDto>>(auditLogs);
            return Ok(auditLogDtos);
        }

        [HttpPost]
        public async Task<IActionResult> CreateAuditLog([FromBody] AuditLogDto auditLogDto)
        {

            var auditLogEntry = _mapper.Map<AuditLogEntry>(auditLogDto);
            var actionType = (AuditActionType)Enum.Parse(typeof(AuditActionType), auditLogEntry.Action);
            await _auditLogService.LogActionAsync(actionType, auditLogEntry.Payload);

            return Ok();
        }
    }
}
