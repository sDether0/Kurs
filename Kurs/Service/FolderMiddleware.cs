using Kurs.DataLayer.DataBase;
using Kurs.DataLayer.Repository.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Kurs.Service
{
    public class FolderMiddleware
    {
        private IPublicFolderRepository _publicFolderRepository;
        private ApiDbContext _apiDbContext;

        public FolderMiddleware(IPublicFolderRepository publicFolderRepository, ApiDbContext dbContext)
        {
            _apiDbContext = dbContext;
            _publicFolderRepository = publicFolderRepository;
        }

        public async Task<bool> CheckPublicFolder(string userId, string path)
        {
            return await _apiDbContext.PublicFolders.Where(x => x.UserGuid == userId)
                .AnyAsync(f => path.Contains(f.FolderGuid)); 
        }
    }
}
