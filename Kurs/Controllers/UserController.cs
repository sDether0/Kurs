using AutoMapper;
using KursModels.Respones;
using Kurs.Service;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Kurs.DataLayer.DataBase;

namespace Kurs.Controllers
{
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")] 
    [ApiController]
    public class UserController : Controller
    {
        private readonly ApiDbContext _apiDbContext;
        public readonly IMapper _mapper;
        private readonly ILogger<UserController> _logger;

        public UserController(ApiDbContext apiDbContext, IMapper mapper, ILogger<UserController> logger)
        {
            _apiDbContext = apiDbContext;
            _mapper = mapper;
            _logger = logger;
        }

        [HttpGet("users")]
        public async Task<IActionResult> Get()
        {
            _logger.LogInformation(nameof(UserController)+" "+nameof(Get));
            var users = _apiDbContext.Users.ToList().Select(x=>_mapper.Map<UserDto>(x));
            return Json(users);
        }


    }
}
