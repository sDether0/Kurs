using Kurs.FilesIO.Enums.Extentions;
using Kurs.FilesIO.Interfaces;
using Kurs.FilesIO.Models;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kurs.FilesIO
{
    public class FileLoader : IFileLoader
    {
        public async Task<List<string>> GetAllFoldersAsync(string path)
        {
            return Directory.GetDirectories(path, "*", SearchOption.AllDirectories).ToList();
        }

        public async Task<List<PathInfo>> LoadAllPathsAsync(string path)
        {
            if (!Directory.Exists(path)) Directory.CreateDirectory(path);
            var list = Directory.GetFileSystemEntries(path, "*.*", SearchOption.AllDirectories).ToList();
            list = new List<string> {path}.Concat(list).ToList();
            var result = list.Select(x=>
            {
                if (File.Exists(x))
                {
                    var ext = Path.GetExtension(x);
                    var name = Path.GetFileName(x);
                    var shortPath = x.Replace("\\" + name, "");
                    var shortName = Path.GetFileName(x).Replace(ext, "");
                    return new PathInfo(x, name, shortName, ext, true,shortPath);
                }

                if (Directory.Exists(x))
                {
                    var name = x.Split('\\','/').Last();
                    return new PathInfo(x, name, null, null, false, null);
                }
                
                throw new Exception("Corrupted path");
            });
            return result.ToList();
        }

        public async Task<List<string>> LoadAllPathsByExtentionsAsync(string user, Extentions extention)
        {
            return Directory.GetFileSystemEntries(user, $"*.{extention.ToString().ToLower()}", SearchOption.AllDirectories).ToList();
        }

        public async Task<List<PathInfo>> LoadAllPathsInPathAsync(string path)
        {
            return await LoadAllPathsAsync(path);
        }

        public async Task<List<string>> LoadAllPathsInPathByExtenionsAsync(string path, Extentions extention)
        {
            return await LoadAllPathsByExtentionsAsync(path, extention);
        }

        public async Task<FileModel> LoadByPathAsync(string path)
        {
            var fileData = new FileModel();
            fileData.Data = await File.ReadAllBytesAsync(path);
            fileData.FullPath = path;
            return fileData;
        }

        public async Task<FileModel> LoadFolderAsync(string path)
        {
            var archivePath = path + ".rar";
            var fileList = await LoadAllPathsInPathAsync(path);
            var result = Archiver.RarFiles(archivePath, fileList.Select(x=>x.Path).ToList());
            if (result != "OK") throw new Exception(result);
            var fileData = await LoadByPathAsync(archivePath);
            //File.Delete(archivePath);
            return fileData;
        }
    }
}
