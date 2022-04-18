using System.Security.Claims;
using System.Security.Cryptography.X509Certificates;

using Kurs.FilesIO;
using Kurs.FilesIO.Interfaces;
using Kurs.FilesIO.Models;

using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Win32.SafeHandles;
using Swashbuckle.AspNetCore.Annotations;


namespace Kurs.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class FilesController : Controller
    {
        private IFileLoader _fileLoader;
        private IFileSaver _fileSaver;
        public FilesController(FileLoader fileLoader, FileSaver fileSaver)
        {
            _fileLoader = fileLoader;
            _fileSaver = fileSaver;
        }
        
        [SwaggerOperation(Summary = "Returns all files and directories paths")]
        [HttpGet("")]
        public async Task<IActionResult> GetFilesPaths()
        {
            var userId = UserId;
            return Json(new { data = await _fileLoader.LoadAllPathsAsync(userId)});
        }

        [SwaggerOperation(Summary = "Returns all directories paths")]
        [HttpGet("paths")]
        public async Task<IActionResult> GetPaths(string? path = null)
        {
            var userId = UserId;
            var newPath = path != null ? userId + "\\" + path : userId;
            return Json(new{ data = await _fileLoader.GetAllFoldersAsync(newPath)
        });
    }

        [SwaggerOperation(Summary = "Create folder in root path")]
        [HttpPost("{folder}")]
        public async Task<IActionResult> CreateRootFolder(string folder)
        {
            var userId = UserId;
            var newPath = userId + "\\" + folder;
            Directory.CreateDirectory(newPath);
            return Ok();
        }

        [SwaggerOperation(Summary = "Create folder in target path")]
        [HttpPost("{path}/{folder}")]
        public async Task<IActionResult> CreateFolderInPath(string path, string folder)
        {
            var userId = UserId;
            var newPath = userId + "\\" + path + "\\" + folder;
            Directory.CreateDirectory(newPath);
            return Ok();
        }

        [SwaggerOperation(Summary = "")]
        [HttpPatch("{path}/{newpath}")]
        public async Task<IActionResult> RenameFolder(string path, string newpath)
        {
            var useriD = UserId;
            if (Directory.Exists(path) && path.ToLower()!=newpath.ToLower())
            {
                Directory.Move(path,newpath);
                return Ok();
            }
            return NotFound();
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

        [SwaggerOperation(Summary = "Download folder in rar")]
        [HttpGet("folder/{path}")]
        public async Task<FileResult> GetAllFilesInPath(string path)
        {
            var userId = UserId;
            var fullpath = !string.IsNullOrWhiteSpace(path) ? userId + "\\" + path : userId;
            var archive = await _fileLoader.LoadFolderAsync(fullpath);
            return File(archive.Data, "application/unknown", archive.FullName);//FileStreamResult
        }

        [SwaggerOperation(Summary = "Download selected file")]
        [HttpGet("file/{path}")]
        public async Task<FileResult> GetSelectedFile(string path)
        {
            var userId = UserId;
            var fullPath = userId + "\\" + path;
            var fileData = await _fileLoader.LoadByPathAsync(fullPath);
            
            return File(fileData.Data, "application/unknown", fileData.FullName);//FileStreamResult
        }

        [SwaggerOperation(Summary = "Upload file to target path")]
        [RequestFormLimits(ValueLengthLimit = int.MaxValue, MultipartBodyLengthLimit = Int64.MaxValue)]
        [HttpPost("{path}")]
        public async Task<IActionResult> CreateFileInPath(string path, IFormFile file)
        {
            var userId = UserId;
            var newPath = userId + "\\" + path + "\\" + file.FileName;
            await _fileSaver.SaveStreamAsync(file, newPath);
            return Ok();
        }
    }
}
