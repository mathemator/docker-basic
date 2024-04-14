# Stage 1: сборка .NET приложения
FROM mcr.microsoft.com/dotnet/sdk:6.0-jammy AS build
WORKDIR /app-build

# Копируем файл решения и восстанавливаем зависимости
COPY . /app-build
# Выполняем сборку приложения
RUN dotnet build WebApplication_DIT_Docker.sln

# Stage 2: запуск .NET приложения
FROM mcr.microsoft.com/dotnet/sdk:6.0-jammy AS runtime
LABEL version="1.0"
ENV ASPNETCORE_URLS="http://+:80"
WORKDIR /app-runtime
EXPOSE 5000 80
COPY --from=build /app-build/WebApplication_DIT_Docker/bin/Debug/net6.0/* /app-runtime/

USER 9000:9000
# Запускаем ваше .NET приложение
ENTRYPOINT ["dotnet", "WebApplication_DIT_Docker.dll"]