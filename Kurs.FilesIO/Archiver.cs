using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kurs.FilesIO
{
    public class Archiver
    {
        private static string winrar = @"C:\Program Files\WinRAR\WinRAR";
        public static string RarFiles(string rarPackagePath,
            List<string> accFiles)
        {
            string result = "";
            try
            {   
                string fileList = "\""+ string.Join("\" \"", accFiles);
                fileList += "\"";
                System.Diagnostics.ProcessStartInfo sdp = new System.Diagnostics.ProcessStartInfo();
                string cmdArgs = string.Format("A {0} {1} -ep1 -r",
                    String.Format("\"{0}\"", rarPackagePath),
                    fileList);
                sdp.ErrorDialog = false;
                sdp.UseShellExecute = true;
                sdp.Arguments = cmdArgs;
                sdp.FileName = winrar;
                sdp.CreateNoWindow = false;
                sdp.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                System.Diagnostics.Process process = System.Diagnostics.Process.Start(sdp);
                process.WaitForExit();
                result = "OK";
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }
    }
}
