using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Kurs.FilesIO.Models;

namespace Kurs.DataLayer.Repository.Interfaces
{
    public interface IPublicFolderRepository
    {
        Task<List<PublicFolderInfo>> GetPublicFolders(string userId);
        Task<string> CreatePublicFolder(string userId, string name);
        Task DeletePublicFolder(string folderId);
        Task<string> GetPublicFolderFromLink(string folderId, string userId);
        Task<string> CreateLinkInvite(string folderId, string userId);
    }
}
