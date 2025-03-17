using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace DmWebPlatform.Notifications.Infrastructure.Interfaces
{
    public interface IRepository<T> where T : class
    {
        DbSet<T> Entities { get; }
        DbContext DbContext { get; }
        /// <summary>
        /// Get all items of an entity by asynchronous method
        /// </summary>
        /// <returns></returns>
        Task<IList<T>> GetAllAsync();
        /// <summary>
        /// Get items of an entity by a specified condition asynchronously
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        Task<IList<T>> GetAsync(Expression<Func<T, bool>> predicate);
        /// <summary>
        /// Fin one item of an entity synchronous method
        /// </summary>
        /// <param name="keyValues"></param>
        /// <returns></returns>
        T Find(params object[] keyValues);
        /// <summary>
        /// Find one item of an entity by asynchronous method
        /// </summary>
        /// <param name="keyValues"></param>
        /// <returns></returns>
        Task<T> FindAsync(params object[] keyValues);
        /// <summary>
        /// Insert item into an entity by asynchronous method
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Task InsertAsync(T entity);
        /// <summary>
        /// Insert multiple items into an entity by asynchronous method
        /// </summary>
        /// <param name="entities"></param>
        /// <returns></returns>
        Task InsertRangeAsync(IEnumerable<T> entities);
        /// <summary>
        /// Remove one item from an entity by asynchronous method
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        Task DeleteAsync(int id);
        /// <summary>
        /// Remove one item from an entity by asynchronous method
        ///
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Task DeleteAsync(T entity);
        /// <summary>
        /// Remove multiple items from an entity by asynchronous method
        /// </summary>
        /// <param name="entities"></param>
        /// <returns></returns>
        Task DeleteRangeAsync(IEnumerable<T> entities);
    }
}
