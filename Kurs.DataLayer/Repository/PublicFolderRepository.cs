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
using Microsoft.EntityFrameworkCore;

namespace Kurs.DataLayer.Repository
{
    public class PublicFolderRepository : IPublicFolderRepository
    {
        private IPublicFolder _publicFolder;
        private ApiDbContext _dbContext;
        public PublicFolderRepository(FileSaver publicFolder, ApiDbContext dbContext)
        {
            _publicFolder = publicFolder;
            _dbContext = dbContext;
        }
        public async Task<string> CreatePublicFolder(string userId)
        {
            var folderId = await _publicFolder.CreatePublicFolder();
            var publicFolder = new PublicFolder() {FolderGuid = folderId, UserGuid = userId};
            _dbContext.PublicFolders.Add(publicFolder);
            await _dbContext.SaveChangesAsync();
            return publicFolder.FolderGuid;
        }

        public async Task DeletePublicFolder(string folderId)
        {
            if (_dbContext.PublicFolders.Any(x => x.FolderGuid == folderId))
            {
                var folder = await _dbContext.PublicFolders.FirstAsync(x => x.FolderGuid == folderId);
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
            var publicFolder = new PublicFolder() {FolderGuid = publicFolderLink.FolderId, UserGuid = userId};
            await _dbContext.PublicFolders.AddAsync(publicFolder);
            await _dbContext.SaveChangesAsync();
            return publicFolder.FolderGuid;
        }

        public async Task<string> CreateLinkInvite(string folderId, string userId)
        {
            if (_dbContext.PublicFolders.Any(x => x.UserGuid == userId && x.FolderGuid == folderId))
            {
                var publicFolderLink = new PublicFolderLink() {FolderId = folderId};

                var link = publicFolderLink.GetLink;
                await _dbContext.PublicFolderLinks.AddAsync(publicFolderLink);
                await _dbContext.SaveChangesAsync();
                return link;
            }

            throw new Exception("Folder not exists or user have not permission");

        }
    }
}
