# Staging
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as stage
WORKDIR /stage
COPY . .
# RUN dotnet restore
# RUN dotnet tool install --global dotnet-ef
# RUN dotnet add package Microsoft.EntityFrameworkCore.Design
# RUN dotnet ef database update
RUN dotnet publish -c Release -o output
WORKDIR /stage/output
# RUN ls -l

# Run
# FROM mcr.microsoft.com/dotnet/core/runtime:3.1 as runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 as runtime
ARG APPNAME
ENV APP_NAME=${APPNAME}.dll
WORKDIR /code
COPY --from=stage /stage/output .
RUN ls -l
EXPOSE 80 5000
ENTRYPOINT [ "dotnet", "ASP NET CORE WEB API.dll" ]
