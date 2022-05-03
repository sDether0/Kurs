using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kurs.DataLayer.Repository.Interfaces
{
    public interface IPublicFolderRepository
    {
        Task<string> CreatePublicFolder(string userId);
        Task DeletePublicFolder(string folderId);
        Task<string> GetPublicFolderFromLink(string folderId, string userId);
        Task<string> CreateLinkInvite(string folderId, string userId);
    }
}
