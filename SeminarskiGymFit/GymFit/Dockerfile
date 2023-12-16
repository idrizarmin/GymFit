#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7260
ENV ASPNETCORE_URLS=http://+:7260

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .


FROM build AS publish
RUN dotnet publish "GymFit.Api/GymFit.Api.csproj" -c Release -o /app
FROM base AS final
WORKDIR /app

COPY --from=publish /app .
ENTRYPOINT ["dotnet", "GymFit.Api.dll"]