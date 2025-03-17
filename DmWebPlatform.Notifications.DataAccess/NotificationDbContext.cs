using DmWebPlatform.Notifications.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace DmWebPlatform.Notifications.DataAccess
{
    public class NotificationDbContext : DbContext
    {
        public virtual DbSet<Notification> Notifications { get; set; }
        public NotificationDbContext(DbContextOptions<NotificationDbContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}