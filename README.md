# Vulnerable .NET Application

Test application with known vulnerable dependencies for testing vulnerability remediation agents.

## Directory Structure
```
VulnerableApi/
├── VulnerableApi.csproj
├── Program.cs
├── appsettings.json
├── appsettings.Development.json
├── Properties/
│   └── launchSettings.json
└── Controllers/
    └── ApiController.cs
```

## Known Vulnerabilities

1. **System.Security.Cryptography.Pkcs 6.0.0** - CVE-2024-0057 (High)
2. **Microsoft.Identity.Web 1.25.0** - CVE-2024-21319 (High)
3. **System.Security.Cryptography.Xml 6.0.0** - CVE-2023-29331 (High)
4. **System.Net.Http 4.3.0** - CVE-2023-38180 (Important)
5. **System.Text.Encodings.Web 4.5.0** - CVE-2021-43877 (Critical)
6. **Newtonsoft.Json 11.0.2** - Multiple CVEs

## Scan for Vulnerabilities
```bash
# Using Trivy (after creating the project structure)
trivy fs --scanners vuln --format json --output trivy-report.json .

# Using .NET CLI (requires .NET SDK)
dotnet list package --vulnerable --include-transitive
```

## Expected Fixes

- System.Security.Cryptography.Pkcs: Upgrade to 6.0.4 or later
- Microsoft.Identity.Web: Upgrade to 2.16.0 or later
- System.Security.Cryptography.Xml: Upgrade to 6.0.2 or later
- System.Net.Http: Upgrade to 4.3.4 or later
- System.Text.Encodings.Web: Upgrade to 6.0.0 or later
- Newtonsoft.Json: Upgrade to 13.0.1 or later

## Build and Run (requires .NET 6 SDK)
```bash
dotnet restore
dotnet build
dotnet run
```

Then access:
- Swagger UI: http://localhost:5000/swagger
- API endpoint: http://localhost:5000/api/api/test
```

## Folder Structure to Create
```
VulnerableApi/
├── VulnerableApi.csproj
├── Program.cs
├── appsettings.json
├── appsettings.Development.json
├── README.md
├── Properties/
│   └── launchSettings.json
└── Controllers/
    └── ApiController.cs
