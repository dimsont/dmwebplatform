using System.Data;
using Microsoft.EntityFrameworkCore;
using DmWebPlatform.Infrastructure.Interfaces;
using System.Collections.Concurrent;
using DmWebPlatform.DataAccess;
using Serilog;

namespace DmWebPlatform.Infrastructure
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        private bool _disposed;
        private readonly DbContext _dbContext;
        private readonly ConcurrentDictionary<string, object> _repositories;

        public DbContext DbContext => _dbContext;

        public UnitOfWork(DbFactory dbFactory)
        {
            _dbContext = dbFactory.DbContext ?? throw new ArgumentNullException(nameof(dbFactory.DbContext));
            _repositories = new ConcurrentDictionary<string, object>();
        }

        public async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            if (_disposed)
                throw new ObjectDisposedException(GetType().Name);

            return await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    try
                    {
                        if (_dbContext != null)
                        {
                            if (_dbContext.Database.GetDbConnection().State == ConnectionState.Open)
                            {
                                _dbContext.Database.GetDbConnection().Close();
                            }
                            _dbContext.Dispose();
                        }
                    }
                    catch (Exception ex)
                    {
                        Log.Error($"Exception caught in Dispose: {ex.Message}");
                    }
                    finally
                    {
                        _disposed = true;
                    }
                }
            }
        }


        public IRepository<TEntity> Repository<TEntity>() where TEntity : class
        {
            if (_disposed)
                throw new ObjectDisposedException(GetType().Name);

            var typeName = typeof(TEntity).Name;

            return (IRepository<TEntity>)_repositories.GetOrAdd(typeName, _ => new Repository<TEntity>(_dbContext));
        }
    }
}
