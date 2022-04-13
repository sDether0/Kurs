using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Kurs.FilesIO.Enums.Extentions;

namespace Kurs.FilesIO.Models
{
    public class FileModel
    {
        public string Name { get; set; }
        public string ShortPath { get; set; }
        public string Extention { get; set; }
        public byte[] Data { get; set; }
        public string FullPath
        {
            get => $"{ShortPath}/{Name}/+{ Extention.ToString().ToLower()}";
            set
            {
                var temp = value.Split(new []{'\\','/'});
                ShortPath = temp[0];
                Name = temp[1].Remove(temp[1].LastIndexOf("."));
                Extention = temp[1].Split('.').Last();
            }
        }

        public string FullName
        {
            get => $"{Name}.{Extention}";
        }
    }
}
