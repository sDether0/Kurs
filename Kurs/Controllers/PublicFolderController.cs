using System.Security.Claims;
using Kurs.DataLayer.Repository;
using Kurs.DataLayer.Repository.Interfaces;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Kurs.Controllers
{
    public class PublicFolderController : Controller
    {
        private IPublicFolderRepository _publicFolderRepository;

        public PublicFolderController(PublicFolderRepository publicFolderRepository)
        {
            _publicFolderRepository = publicFolderRepository;
        }

        [AllowAnonymous]
        [HttpPost("PublicFolder/{code}/{email}")]
        public async Task<IActionResult> GetPublicFolder( string code,  string email)
        {
            var folderId= await _publicFolderRepository.GetPublicFolderFromLink(code, email);
            return Ok(folderId);
        }

        [Authorize]
        [HttpPost("PublicFolder")]
        public async Task<IActionResult> Create()
        {
            var userId = UserId;
            var folderId = await _publicFolderRepository.CreatePublicFolder(userId);
            return Ok(folderId);
        }

        [Authorize]
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
