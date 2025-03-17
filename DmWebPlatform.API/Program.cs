using Serilog;
using DmWebPlatform.Infrastructure.Interfaces.Services;
using DmWebPlatform.Service;
using DmWebPlatform.API.Extensions;
using DmWebPlatform.API.Middleware;
using DmWebPlatform.API.Models;
using MongoDB.Driver;
using DmWebPlatform.DataAccess;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using DmWebPlatform.Domain.Entities;
using DmWebPlatform.Domain;
using DmWebPlatform.API;

var builder = WebApplication.CreateBuilder(args);

// Configure Serilog
Log.Logger = new LoggerConfiguration()
    .WriteTo.Console() // Temporary sink until DB creation
    .CreateLogger();

builder.Host.UseSerilog(); // Use Serilog for logging

// Bind app settings (optional, only if you have AppSettings class)
var appSettings = new AppSettings();
builder.Configuration.GetSection("ConnectionStrings").Bind(appSettings, options => options.BindNonPublicProperties = true);

// Add AutoMapper with the profile
builder.Services.AddAutoMapper(typeof(MappingProfile));

// Register MongoDB
builder.Services.AddSingleton<IMongoClient>(serviceProvider =>
{
    var connectionString = builder.Configuration["MONGO_CONNECTION_STRING"];
    return new MongoClient(connectionString);
});
builder.Services.AddScoped<IMongoDatabase>(serviceProvider =>
{
    var mongoClient = serviceProvider.GetRequiredService<IMongoClient>();
    var databaseName = builder.Configuration["MONGO_DATABASE_NAME"];
    return mongoClient.GetDatabase(databaseName);
});

// Add AuditLogService (that uses MongoDB)
builder.Services.AddScoped<IAuditLogService, AuditLogService>();

// Add Identity for user management and role handling
builder.Services.AddIdentity<ApplicationUser, IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddDefaultTokenProviders();

// JWT Configuration
var key = Encoding.ASCII.GetBytes(builder.Configuration["Jwt:Key"]);
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(jwt =>
{
    jwt.SaveToken = true;
    jwt.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false,
        RequireExpirationTime = true,
        ValidateLifetime = true,
        ValidIssuer = builder.Configuration["Jwt:Issuer"],
        ValidAudience = builder.Configuration["Jwt:Audience"]
    };
});

// Add Role-based Authorization
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("AdminPolicy", policy => policy.RequireRole("Admin"));
    options.AddPolicy("InstructorPolicy", policy => policy.RequireRole("Instructor"));
    options.AddPolicy("UserPolicy", policy => policy.RequireRole("User"));
    options.AddPolicy("GuestPolicy", policy => policy.RequireRole("Guest"));
});

// Add services to the container
builder.Services.AddDatabase(builder.Configuration);
builder.Services.AddHttpClient();
builder.Services.AddScoped<IEventService, EventService>();
builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configure CORS (optional, only if needed)
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});

// Add health checks (optional)
builder.Services.AddHealthChecks();

var app = builder.Build();

// Apply migrations at startup and seed roles
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    try
    {
        var dbContext = services.GetRequiredService<ApplicationDbContext>();
        dbContext.Database.Migrate(); // Apply any pending migrations

        // Call the SeedData class to seed roles and the admin user
        await SeedData.Initialize(services);

        Log.Information("Migrations applied and roles seeded successfully.");
    }
    catch (Exception ex)
    {
        Log.Fatal(ex, "An error occurred while migrating the database.");
        throw; // Re-throw the exception to avoid silent failures
    }
}

// Reconfigure Serilog to log to SQL Server after migration
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .CreateLogger();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI();
}
else
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseMiddleware<ErrorHandlingMiddleware>();

app.UseHttpsRedirection();

app.UseRouting();

// Use CORS (optional, only if configured)
app.UseCors("AllowAll");

// Enable Authentication and Authorization
app.UseAuthentication();
app.UseAuthorization();

// Add health check endpoints (optional)
app.MapHealthChecks("/health");

// Map controllers with default route
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Events}/{action=Index}/{id?}");

app.Run();
