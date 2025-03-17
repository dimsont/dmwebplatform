using DmWebPlatform.API.Extensions;
using DmWebPlatform.Notifications.API.Models;
using DmWebPlatform.Notifications.DataAccess;
using DmWebPlatform.Notifications.Domain;
using DmWebPlatform.Notifications.Infrastructure.Interfaces.Services;
using Microsoft.EntityFrameworkCore;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Bind app settings (optional, only if you have AppSettings class)
var appSettings = new AppSettings();
builder.Configuration.GetSection("ConnectionStrings").Bind(appSettings, options => options.BindNonPublicProperties = true);

// Add AutoMapper with the profile
builder.Services.AddAutoMapper(typeof(MappingProfile)); 

// Add services to the container
builder.Services.AddDatabase(builder.Configuration);
builder.Services.AddScoped<INotificationService, NotificationService>();
builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Apply migrations at startup
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    try
    {
        var dbContext = services.GetRequiredService<NotificationDbContext>();
        dbContext.Database.Migrate(); // Apply any pending migrations
        Log.Information("Migrations applied successfully.");
    }
    catch (Exception ex)
    {
        Log.Fatal(ex, "An error occurred while migrating the database.");
        throw; // Re-throw the exception to avoid silent failures
    }
}


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
