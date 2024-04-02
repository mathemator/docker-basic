# Stage 1: сборка .NET приложения
FROM mcr.microsoft.com/dotnet/sdk:6.0-jammy AS build
WORKDIR /app-build

# Копируем файл решения и восстанавливаем зависимости
COPY . /app-build
# Выполняем сборку приложения
RUN dotnet build WebApplication_DIT_Docker.sln

# Stage 2: запуск .NET приложения
FROM mcr.microsoft.com/dotnet/sdk:6.0-jammy AS runtime
WORKDIR /app-runtime
EXPOSE 80
COPY --from=build /app-build/WebApplication_DIT_Docker/bin/Debug/net6.0/* /app-runtime/

# Запускаем ваше .NET приложение
ENTRYPOINT ["dotnet", "WebApplication_DIT_Docker.dll"]