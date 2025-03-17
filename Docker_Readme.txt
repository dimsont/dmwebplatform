PS> docker build -t event-app -f DmWebPlatform.API/Dockerfile .
PS> docker build -t notif-app -f DmWebPlatform.Notifications.API/Dockerfile .

PS> docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=StrongPassword123!" -p 1433:1433 --network mynetwork --name sqlserver -d mcr.microsoft.com/mssql/server:2022-latest

PS> docker run --network mynetwork --name event_container -d event-app
PS> docker run --network mynetwork --name notif_container -d notif-app


********************
PS> docker-compose up --build -d
PS> docker-compose down
/* -d: detached */


PS> docker exec -it sqlserver /bin/bash
$> /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P StrongPassword123! -C -N

/* -C: Trusts the server certificate without requiring validation (equivalent to TrustServerCertificate=True). */
/* -N: Forces encrypted connection, but without requiring certificate validation. */

SELECT name FROM sys.databases;
GO

