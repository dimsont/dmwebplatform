using Microsoft.EntityFrameworkCore;
using DmWebPlatform.Notifications.API.Models;
using DmWebPlatform.Notifications.DataAccess;
using DmWebPlatform.Notifications.Infrastructure.Interfaces;
using DmWebPlatform.Notifications.Infrastructure;

namespace DmWebPlatform.API.Extensions
{
    public static class ServiceCollectionExtensions
    {
        /// <summary>
        /// Add needed instances for database
        /// </summary>
        /// <param name="services"></param>
        /// <param name="configuration"></param>
        /// <returns></returns>
        public static IServiceCollection AddDatabase(this IServiceCollection services, IConfiguration configuration)
        {
            // Configure DbContext with Scoped lifetime  
            services.AddDbContext<NotificationDbContext>(options =>
            {
                options.UseSqlServer(AppSettings.DefaultConnection,
                    sqlOptions => sqlOptions.CommandTimeout(120));
                options.UseLazyLoadingProxies();
            }
            );

            services.AddScoped<Func<NotificationDbContext>>((provider) => () => provider.GetService<NotificationDbContext>());
            services.AddScoped<DbFactory>();
            services.AddScoped<IUnitOfWork, UnitOfWork>();

            return services;
        }
    }
}