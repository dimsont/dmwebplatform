using DmWebPlatform.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;
using DmWebPlatform.API.Models;
using DmWebPlatform.DataAccess;
using DmWebPlatform.Infrastructure;

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
            services.AddDbContext<ApplicationDbContext>(options =>
            {
                options.UseSqlServer(AppSettings.DefaultConnection,
                    sqlOptions => sqlOptions.CommandTimeout(120));
                options.UseLazyLoadingProxies();
            }
            );

            services.AddScoped<Func<ApplicationDbContext>>((provider) => () => provider.GetService<ApplicationDbContext>());
            services.AddScoped<DbFactory>();
            services.AddScoped<IUnitOfWork, UnitOfWork>();

            return services;
        }
    }
}