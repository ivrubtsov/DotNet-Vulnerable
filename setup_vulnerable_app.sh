#!/bin/bash
# setup_vulnerable_app.sh

echo "Creating vulnerable .NET application..."

# Create project
mkdir -p VulnerableNetApp
cd VulnerableNetApp

dotnet new webapi -n VulnerableApi --framework net6.0 -o VulnerableApi

cd VulnerableApi

# Remove default files
rm -f WeatherForecast.cs
rm -f Controllers/WeatherForecastController.cs

# Create the .csproj with vulnerable packages
cat > VulnerableApi.csproj << 'EOF'
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net6.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.Data.SqlClient" Version="2.0.0" />
    <PackageReference Include="Newtonsoft.Json" Version="12.0.1" />
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.2.3" />
    <PackageReference Include="System.Drawing.Common" Version="5.0.0" />
    <PackageReference Include="System.Security.Cryptography.Xml" Version="4.7.0" />
    <PackageReference Include="System.Text.Json" Version="6.0.0" />
  </ItemGroup>

</Project>
EOF

# Create UserController
mkdir -p Controllers
cat > Controllers/UserController.cs << 'EOF'
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Text.Json;

namespace VulnerableApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        [HttpGet("profile")]
        public IActionResult GetProfile()
        {
            var user = new { Name = "John Doe", Email = "john@example.com" };
            var json = JsonConvert.SerializeObject(user);
            return Ok(json);
        }

        [HttpPost("data")]
        public IActionResult ProcessData([FromBody] object data)
        {
            var jsonString = System.Text.Json.JsonSerializer.Serialize(data);
            return Ok(new { processed = true, data = jsonString });
        }
    }
}
EOF

# Update Program.cs
cat > Program.cs << 'EOF'
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

app.Run();
EOF

# Create README
cat > README.md << 'EOF'
# Vulnerable .NET Application

Test application with known vulnerable dependencies.

## Scan with Trivy
```bash
trivy fs --scanners vuln --format json --output trivy-report.json .
```

## Build and Run
```bash
dotnet restore
dotnet build
dotnet run
```
EOF

echo ""
echo "✅ Vulnerable .NET application created at: VulnerableNetApp/VulnerableApi"
echo ""
echo "Next steps:"
echo "  cd VulnerableNetApp/VulnerableApi"
echo "  dotnet restore"
echo "  trivy fs --scanners vuln --format json --output trivy-report.json ."
echo ""
