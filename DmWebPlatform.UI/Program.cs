var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();

// Add Event service HTTP client
builder.Services.AddHttpClient("apiClient", client =>
{
    client.BaseAddress = new Uri(builder.Configuration["ApiBaseAddress"] ?? "https://localhost:7135/"); // Event API base address
}).ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
{
    ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true
});

// Add Notification service HTTP client
builder.Services.AddHttpClient("notificationClient", client =>
{
    client.BaseAddress = new Uri(builder.Configuration["NotificationApiBaseAddress"] ?? "https://localhost:7206/"); // Notification API base address
}).ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
{
    ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true
});

// Register services that depend on the HttpClient
builder.Services.AddScoped(sp => sp.GetRequiredService<IHttpClientFactory>().CreateClient("apiClient"));
builder.Services.AddScoped(sp => sp.GetRequiredService<IHttpClientFactory>().CreateClient("notificationClient"));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
