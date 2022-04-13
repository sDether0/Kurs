using Kurs.FilesIO.Enums.Extentions;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kurs.FilesIO.Interfaces
{
    public interface ILoader<T>
    {
        public Task<T> LoadByPathAsync(string path);
        public Task<List<string>> LoadAllPathsAsync(string user);
        public Task<List<string>> LoadAllPathsInPathAsync(string path);
        public Task<List<string>> LoadAllPathsByExtentionsAsync(string user, Extentions extention);
        public Task<List<string>> LoadAllPathsInPathByExtenionsAsync(string path, Extentions extention);
        public Task<T> LoadFolderAsync(string path);
        public Task<List<string>> GetAllFoldersAsync(string path);
    }
}
