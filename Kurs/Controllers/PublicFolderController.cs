using Kurs.DataLayer.Repository;
using Kurs.DataLayer.Repository.Interfaces;

using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

using System.Security.Claims;

namespace Kurs.Controllers
{
    public class PublicFolderController : Controller
    {
        private IPublicFolderRepository _publicFolderRepository;

        public PublicFolderController(IPublicFolderRepository publicFolderRepository)
        {
            _publicFolderRepository = publicFolderRepository;
        }

        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        [HttpGet("PublicFolder")]
        public async Task<IActionResult> GetPublicFolders()
        {
            var userId = UserId;

           return Json(new{data= await _publicFolderRepository.GetPublicFolders(userId)});
        }

        [AllowAnonymous]
        [HttpPost("PublicFolder/{code}/{email}")]
        public async Task<IActionResult> GetPublicFolder( string code,  string email)
        {
            var folderId= await _publicFolderRepository.GetPublicFolderFromLink(code, email);
            return Ok(folderId);
        }

        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        [HttpPost("PublicFolder/{name}")]
        public async Task<IActionResult> Create(string name)
        {
            var userId = UserId;
            var folderId = await _publicFolderRepository.CreatePublicFolder(userId, name);
            return Ok(folderId);
        }



        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        [HttpGet("PublicFolder/Link/{folderId}")]
        public async Task<IActionResult> GetLink(string folderId)
        {
            var userId=UserId;
            var link = await _publicFolderRepository.CreateLinkInvite(folderId, userId);
            return Json(new {link = link});
        }

        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        [HttpDelete("PublicFolder/{folderId}")]
        public async Task<IActionResult> Delete(string folderId)
        {
            await _publicFolderRepository.DeletePublicFolder(folderId);
            return Ok();
        }

        private string UserId
        {
            get
            {
                var claimIdentity = this.User.Identity as ClaimsIdentity;
                var userId = claimIdentity.Claims.First(x => x.Type == "Id").Value;
                return userId;
            }
        }
    }
}
