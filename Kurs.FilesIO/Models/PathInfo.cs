using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kurs.FilesIO.Models
{
    public struct PathInfo
    {
        public PathInfo(string path, string name, string shortName, string extension, bool file, string shortPath)
        {
            Path = path;
            Name = name;
            ShortName = shortName;
            Extension = extension;
            File = file;
            ShortPath = shortPath;
        }

        public string Path { get; set; }
        public string? ShortPath { get; set; }
        public string Name { get; set; }
        public string? ShortName { get; set; }
        public string? Extension { get; set; }
        public bool File { get; set; }
    }
}
