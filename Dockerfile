FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /App

COPY . ./
#COPY ["src\FIAP.CloudGames.API\FIAP.CloudGames.API.csproj", "./FIAP.CloudGames.API/"]
#COPY ["src\FIAP.CloudGames.Application\FIAP.CloudGames.Application.csproj", "./FIAP.CloudGames.Application/"]
#COPY ["src\FIAP.CloudGames.Domain\FIAP.CloudGames.Domain.csproj", "./FIAP.CloudGames.Domain/"]
#COPY ["src\FIAP.CloudGames.Infrastructure\FIAP.CloudGames.Infrastructure.csproj", "./FIAP.CloudGames.Infrastructure/"]

RUN dotnet restore

RUN dotnet build -c Release -o out

RUN dotnet publish -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App

COPY --from=build /App/out .

EXPOSE 8080

ENTRYPOINT ["dotnet", "FIAP.CloudGames.API.dll"]