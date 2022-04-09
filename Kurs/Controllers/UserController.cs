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

        public UserController(ApiDbContext apiDbContext, IMapper mapper)
        {
            _apiDbContext = apiDbContext;
            _mapper = mapper;
        }

        [HttpGet("users")]
        public async Task<IActionResult> Get()
        {
            var users = _apiDbContext.Users.ToList().Select(x=>_mapper.Map<UserDto>(x));
            return Json(users);
        }


    }
}
