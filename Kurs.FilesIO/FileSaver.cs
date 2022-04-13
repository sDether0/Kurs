using Kurs.FilesIO.Interfaces;
using Kurs.FilesIO.Models;

using Microsoft.AspNetCore.Http;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kurs.FilesIO
{
    public class FileSaver : IFileSaver
    {
        public async Task SaveAsync(FileModel file)
        {
            await File.WriteAllBytesAsync(file.FullPath, file.Data);
        }

        public async Task SaveStreamAsync(IFormFile file, string path)
        {
            using (var stream = File.Create(path))
            {
                await file.CopyToAsync(stream);
            }
        }
    }
}
