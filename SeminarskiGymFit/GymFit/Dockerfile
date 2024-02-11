FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 7260
ENV ASPNETCORE_URLS=http://+:7260

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy only the project file and restore dependencies
COPY GymFit.Api/GymFit.Api.csproj GymFit.Api/
RUN dotnet restore "GymFit.Api/GymFit.Api.csproj"

# Copy the full source code
COPY . .

FROM build AS publish
RUN dotnet publish "GymFit.Api/GymFit.Api.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .

ENTRYPOINT ["dotnet", "GymFit.Api.dll"]
