using Microsoft.AspNetCore.Http;

namespace Kurs.FilesIO.Interfaces
{
    public interface ISaver<T>
    {
        public Task SaveAsync(T entity);
        public Task SaveStreamAsync(IFormFile stream, string path);
    }
}