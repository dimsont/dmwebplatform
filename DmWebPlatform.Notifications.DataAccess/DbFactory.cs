using Microsoft.EntityFrameworkCore;

namespace DmWebPlatform.Notifications.DataAccess
{
    public class DbFactory : IDisposable
    {
        private bool _disposed;
        private readonly Func<NotificationDbContext> _instanceFunc;
        private DbContext _dbContext;
        public DbContext DbContext => _dbContext ??= _instanceFunc.Invoke();

        public DbFactory(Func<NotificationDbContext> dbContextFactory)
        {
            _instanceFunc = dbContextFactory;
        }

        public void Dispose()
        {
            if (!_disposed && _dbContext != null)
            {
                _disposed = true;
                _dbContext.Dispose();
            }
        }
    }
}