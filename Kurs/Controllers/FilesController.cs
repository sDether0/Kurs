﻿using Kurs.FilesIO;
using Kurs.FilesIO.Interfaces;

using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

using Swashbuckle.AspNetCore.Annotations;

using System.Security.Authentication;
using System.Security.Claims;
using Kurs.FilesIO.Models;


namespace Kurs.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class FilesController : Controller
    {
        private IFileLoader _fileLoader;
        private IFileSaver _fileSaver;
        private readonly ILogger<FilesController> _logger;
        public FilesController(FileLoader fileLoader, FileSaver fileSaver, ILogger<FilesController> logger)
        {
            _fileLoader = fileLoader;
            _fileSaver = fileSaver;
            _logger = logger;
        }

        [SwaggerOperation(Summary = "Returns all files and directories paths")]
        [HttpGet("")]
        public async Task<IActionResult> GetFilesPaths()
        {
            _logger.LogInformation(nameof(GetFilesPaths));
            var userId = UserId;
            var result = Json(new {data = new List<PathInfo>{new (userId,userId,null,null,false,null)}.Concat(await _fileLoader.LoadAllPathsAsync(userId)).ToList()});
            return result;
        }

        [SwaggerOperation(Summary = "Returns all directories paths")]
        [HttpGet("paths")]
        public async Task<IActionResult> GetPaths(string? path = null)
        {
            _logger.LogInformation(nameof(GetPaths));
            var userId = UserId;
            var newPath = path != null && path.Contains(userId) ? path : userId;
            return Json(new
            {
                data = await _fileLoader.GetAllFoldersAsync(newPath)
            });
        }

        [SwaggerOperation(Summary = "Create folder in root path")]
        [HttpPost("{folder}")]
        public async Task<IActionResult> CreateRootFolder(string folder)
        {
            _logger.LogInformation(nameof(CreateRootFolder));
            var userId = UserId;
            var newPath = userId + "\\" + folder;
            Directory.CreateDirectory(newPath);
            return Ok();
        }

        [SwaggerOperation(Summary = "Create folder in target path")]
        [HttpPost("{path}/{folder}")]
        public async Task<IActionResult> CreateFolderInPath(string path, string folder)
        {
            _logger.LogInformation(nameof(CreateFolderInPath));
            var userId = UserId;
            if (path.Contains(userId))
            {
                var newPath = path + "\\" + folder;
                Directory.CreateDirectory(newPath);
                return Ok();
            }

            throw new AuthenticationException("Try access \"alien\" private folder.");
        }

        [SwaggerOperation(Summary = "")]
        [HttpPatch("{path}/{newpath}")]
        public async Task<IActionResult> RenameFolder(string path, string newpath)
        {
            _logger.LogInformation(nameof(RenameFolder));
            var useriD = UserId;
            if (path.ToLower() != newpath.ToLower())
            {
                if (Directory.Exists(path))
                {
                    Directory.Move(path, newpath);
                    return Ok();
                }
                if (System.IO.File.Exists(path))
                {
                    System.IO.File.Move(path,newpath);
                    return Ok();
                }
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
            _logger.LogInformation(nameof(GetAllFilesInPath));
            var userId = UserId;
            var fullpath = !string.IsNullOrWhiteSpace(path) && path.Contains(userId) ? path : userId;
            var paPath = Path.GetFullPath(fullpath);
            var archive = await _fileLoader.LoadFolderAsync(fullpath);
            return File(archive.Data, "application/unknown", archive.FullName);//FileStreamResult
        }

        [SwaggerOperation(Summary = "Download selected file")]
        [HttpGet("file/{path}")]
        public async Task<FileResult> GetSelectedFile(string path)
        {
            _logger.LogInformation(nameof(GetSelectedFile));
            var userId = UserId;
            if (path.Contains(userId))
            {
                var fullPath = path;
                var fileData = await _fileLoader.LoadByPathAsync(fullPath);

                return File(fileData.Data, "application/unknown", fileData.FullName);//FileStreamResult
            }
            throw new AuthenticationException("Try access \"alien\" private folder.");
        }

        [SwaggerOperation(Summary = "Upload file to target path")]
        [RequestFormLimits(ValueLengthLimit = int.MaxValue, MultipartBodyLengthLimit = Int64.MaxValue)]
        [HttpPost("{path}")]
        public async Task<IActionResult> CreateFileInPath(string path, IFormFile file)
        {
            _logger.LogInformation(nameof(CreateFileInPath));
            var userId = UserId;
            if (path.Contains(userId))
            {
                var newPath = path + "\\" + file.FileName;
                await _fileSaver.SaveStreamAsync(file, newPath);
                return Ok();
            }
            throw new AuthenticationException("Try access \"alien\" private folder.");
        }
    }
}
