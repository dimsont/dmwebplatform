using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using DmWebPlatform.Notifications.Infrastructure.Interfaces;

namespace DmWebPlatform.Notifications.Infrastructure
{
    public class Repository<T> : IRepository<T> where T : class
    {
        public DbSet<T> Entities => DbContext.Set<T>();
        public DbContext DbContext { get; }

        public Repository(DbContext dbContext)
        {
            DbContext = dbContext;
        }

        public async Task DeleteAsync(int id)
        {
            var entity = await Entities.FindAsync(id);
            await DeleteAsync(entity);
        }

        public Task DeleteAsync(T entity)
        {
            Entities.Remove(entity);
            return Task.CompletedTask;
        }

        public Task DeleteRangeAsync(IEnumerable<T> entities)
        {
            Entities.RemoveRange(entities);
            return Task.CompletedTask;
        }

        public async Task<IList<T>> GetAllAsync()
        {
            return await Entities.ToListAsync();
        }

        public T Find(params object[] keyValues)
        {
            return Entities.Find(keyValues);
        }

        public virtual async Task<T> FindAsync(params object[] keyValues)
        {
            return await Entities.FindAsync(keyValues);
        }

        public async Task InsertAsync(T entity)
        {
            await Entities.AddAsync(entity);
        }

        public async Task InsertRangeAsync(IEnumerable<T> entities)
        {
            await Entities.AddRangeAsync(entities);
        }

        public async Task<IList<T>> GetAsync(Expression<Func<T, bool>> predicate)
        {
            return await Entities.Where(predicate).ToListAsync();
        }
    }
}
