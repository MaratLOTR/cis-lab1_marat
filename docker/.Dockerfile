# Базовый образ – dotnet-80 (SDK)

FROM registry.access.redhat.com/ubi8/dotnet-80 AS build


COPY ["src/BackendApp", "./"]

USER root

RUN dotnet restore
RUN dotnet publish -p:PublishDir=/publish -c Debug --no-restore


# Базовый образ – dotnet-80-runtime

FROM registry.access.redhat.com/ubi8/dotnet-80-runtime AS runtime

COPY --from=build /publish .

CMD dotnet BackendApp.dll --environment=Development