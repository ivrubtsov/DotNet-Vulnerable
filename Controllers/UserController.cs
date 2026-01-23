using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Text.Json;
using System.Data.SqlClient;
using System.Drawing;
using System.Security.Cryptography.Xml;

namespace VulnerableApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        [HttpGet("profile")]
        public IActionResult GetProfile()
        {
            // Using vulnerable Newtonsoft.Json 12.0.1
            var user = new { Name = "John Doe", Email = "john@example.com" };
            var json = JsonConvert.SerializeObject(user);
            
            return Ok(json);
        }

        [HttpPost("data")]
        public IActionResult ProcessData([FromBody] object data)
        {
            // Using vulnerable System.Text.Json 6.0.0
            var jsonString = System.Text.Json.JsonSerializer.Serialize(data);
            
            return Ok(new { processed = true, data = jsonString });
        }

        [HttpGet("query")]
        public IActionResult QueryDatabase(string userId)
        {
            // Using vulnerable Microsoft.Data.SqlClient 2.0.0
            // Note: This is just for demonstration - no actual DB connection
            var connectionString = "Server=localhost;Database=TestDB;";
            
            return Ok(new { message = "Database query simulation", userId });
        }

        [HttpGet("image")]
        public IActionResult ProcessImage()
        {
            // Using vulnerable System.Drawing.Common 5.0.0
            // This would typically process an image
            return Ok(new { message = "Image processing simulation" });
        }

        [HttpPost("xml")]
        public IActionResult ProcessXml([FromBody] string xmlData)
        {
            // Using vulnerable System.Security.Cryptography.Xml 4.7.0
            return Ok(new { message = "XML processing simulation" });
        }
    }
}
