using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Kurs.DataLayer.DataBase;
using Kurs.DataLayer.DataBase.Entitys;
using Kurs.DataLayer.Repository.Interfaces;
using Kurs.FilesIO;
using Kurs.FilesIO.Interfaces;
using Kurs.FilesIO.Models;
using Microsoft.EntityFrameworkCore;

namespace Kurs.DataLayer.Repository
{
    public class PublicFolderRepository : IPublicFolderRepository
    {
        private readonly IPublicFolder _publicFolder;
        private readonly ApiDbContext _dbContext;
        private readonly IFileLoader _loader;
        
        public PublicFolderRepository(IPublicFolder publicFolder, ApiDbContext dbContext, IFileLoader loader)
        {
            _publicFolder = publicFolder;
            _dbContext = dbContext;
            _loader = loader;
        }

        public async Task<List<PublicFolderInfo>> GetPublicFolders(string userId)
        {
            var folders = _dbContext.PublicFolders.Where(x => x.UserGuid == userId).ToList();
            var resultFolders = (await Task.WhenAll(folders.Select(async (x) =>
                new PublicFolderInfo()
                {
                    Name = x.Name,
                    Guid = x.FolderGuid,
                    Paths = await _loader.LoadAllPathsAsync(x.FolderGuid)
                }
             
            ))).ToList();

            return resultFolders;
        }

        public async Task<string> CreatePublicFolder(string userId, string name)
        {
            var folderId = await _publicFolder.CreatePublicFolder();
            if (_dbContext.PublicFolders.Any(x => x.UserGuid == userId && x.Name == name)) throw new Exception("This folder name for this user already existed");
            var publicFolder = new PublicFolder() {FolderGuid = folderId, UserGuid = userId, Name = name};
            _dbContext.PublicFolders.Add(publicFolder);
            await _dbContext.SaveChangesAsync();
            return publicFolder.FolderGuid;
        }

        public async Task DeletePublicFolder(string userId, string folderId)
        {
            if (_dbContext.PublicFolders.Any(x => x.FolderGuid == folderId && x.UserGuid==userId))
            {
                var folder = await _dbContext.PublicFolders.FirstAsync(x => x.FolderGuid == folderId && x.UserGuid==userId);

                _dbContext.PublicFolders.Remove(folder);
                await _dbContext.SaveChangesAsync();
            }

            throw new Exception("404 Folder not found");
        }

        public async Task<string> GetPublicFolderFromLink(string code, string email)
        {
            var decoded = HttpUtility.UrlDecode(code);
            var user = await _dbContext.Users.FirstOrDefaultAsync(x => x.Email.ToLower() == email.ToLower());
            if(user == null) throw new Exception("404 User not found");
            var userId = user.Id;
            var publicFolderLink = await _dbContext.PublicFolderLinks.FirstOrDefaultAsync(x => x.Code == decoded);
            if (publicFolderLink == null) throw new Exception("407 InvalidCode");
            var publicFolder = new PublicFolder() {FolderGuid = publicFolderLink.FolderId, UserGuid = userId, Name = "Shared "+new Random().Next()};
            await _dbContext.PublicFolders.AddAsync(publicFolder);
            await _dbContext.SaveChangesAsync();
            return publicFolder.FolderGuid;
        }

        public async Task<string> CreateLinkInvite(string folderId, string userId)
        {
            if (_dbContext.PublicFolders.Any(x => x.UserGuid == userId && x.FolderGuid == folderId))
            {
                var links= _dbContext.PublicFolderLinks.Where(x => x.FolderId == folderId).ToList();
                if (links.Count>0)
                {
                    return links.First().GetLink;
                }
                var publicFolderLink = new PublicFolderLink() {FolderId = folderId};

                var link = publicFolderLink.GetLink;
                await _dbContext.PublicFolderLinks.AddAsync(publicFolderLink);
                await _dbContext.SaveChangesAsync();
                return link;
            }

            throw new Exception("Folder not exists or user have not permission");

        }

        public async Task RenamePublicFolder(string userId, string folderId, string newName)
        {
            if (!_dbContext.PublicFolders.Any(x => x.FolderGuid == folderId && x.UserGuid == userId))
                throw new Exception("Unknown path or not enough permission");
            var folder = _dbContext.PublicFolders.First(x => x.FolderGuid == folderId && x.UserGuid == userId);
            folder.Name = newName;
            _dbContext.Update(folder);
            await _dbContext.SaveChangesAsync();
        }
    }
}
