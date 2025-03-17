# Base image used in production or non-debug mode
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 7135

# Environment variable for ASP.NET Core to run in Production
ENV ASPNETCORE_ENVIRONMENT=Production

# Build stage for the service project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copy project files
COPY ["DmWebPlatform.API/DmWebPlatform.API.csproj", "DmWebPlatform.API/"]
COPY ["DmWebPlatform.DataAccess/DmWebPlatform.DataAccess.csproj", "DmWebPlatform.DataAccess/"]
COPY ["DmWebPlatform.Domain/DmWebPlatform.Domain.csproj", "DmWebPlatform.Domain/"]
COPY ["DmWebPlatform.Infrastructure/DmWebPlatform.Infrastructure.csproj", "DmWebPlatform.Infrastructure/"]
COPY ["DmWebPlatform.Notifications.Service/DmWebPlatform.Notifications.Service.csproj", "DmWebPlatform.Notifications.Service/"]
COPY ["DmWebPlatform.Notifications.Infrastructure/DmWebPlatform.Notifications.Infrastructure.csproj", "DmWebPlatform.Notifications.Infrastructure/"]
COPY ["DmWebPlatform.Notifications.DataAccess/DmWebPlatform.Notifications.DataAccess.csproj", "DmWebPlatform.Notifications.DataAccess/"]
COPY ["DmWebPlatform.Notifications.Domain/DmWebPlatform.Notifications.Domain.csproj", "DmWebPlatform.Notifications.Domain/"]
COPY ["DmWebPlatform.Service/DmWebPlatform.Service.csproj", "DmWebPlatform.Service/"]

# Restore the required dependencies
RUN dotnet restore "DmWebPlatform.API/DmWebPlatform.API.csproj"

# Copy all project files
COPY . .

# Build the application in Release mode
WORKDIR "/src/DmWebPlatform.API"
RUN dotnet build "DmWebPlatform.API.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Publish the application for production
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "DmWebPlatform.API.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Final image with the runtime for production
FROM base AS final
WORKDIR /app

# Set the URL for the ASP.NET Core application to listen on port 7135
ENV ASPNETCORE_URLS=http://+:7135

# Copy the published files from the previous stage
COPY --from=publish /app/publish .

# Set entrypoint for the application
ENTRYPOINT ["dotnet", "DmWebPlatform.API.dll"]
