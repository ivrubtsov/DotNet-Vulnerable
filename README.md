# Vulnerable .NET Application

This is a sample .NET 6 Web API with intentionally vulnerable dependencies for testing vulnerability scanning and remediation tools.

## Known Vulnerabilities

1. **Newtonsoft.Json 12.0.1** - CVE-2024-21907 (Denial of Service)
2. **System.Text.Json 6.0.0** - Multiple CVEs in earlier 6.0.x versions
3. **Microsoft.Data.SqlClient 2.0.0** - CVE-2024-0056 (Information Disclosure)
4. **System.Drawing.Common 5.0.0** - CVE-2021-24112 (Remote Code Execution)
5. **System.Security.Cryptography.Xml 4.7.0** - CVE-2022-34716 (Elevation of Privilege)

## Setup
```bash
# Restore dependencies
dotnet restore

# Build the project
dotnet build

# Run the application
dotnet run
```

## Scan for Vulnerabilities
```bash
# Using Trivy
trivy fs --scanners vuln --format json --output trivy-report.json .

# Using dotnet list package
dotnet list package --vulnerable --include-transitive
```

## Expected Fixes

- Newtonsoft.Json: Upgrade to 13.0.3+
- System.Text.Json: Upgrade to 8.0.0+
- Microsoft.Data.SqlClient: Upgrade to 5.1.0+
- System.Drawing.Common: Upgrade to 7.0.0+
- System.Security.Cryptography.Xml: Upgrade to 8.0.0+
