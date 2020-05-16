using Steeltoe.Common.Net;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            string sharePath = Environment.GetEnvironmentVariable("SMB_SHARE");
            string username = Environment.GetEnvironmentVariable("SMB_USERNAME");
            string password = Environment.GetEnvironmentVariable("SMB_PASSWORD");

            NetworkCredential cred = new NetworkCredential(username, password);

            using (var networkPath = new WindowsNetworkFileShare(sharePath, cred))
            {
                string testFilePath = Path.Combine(sharePath, "test.txt");
                StreamWriter outputFile = new StreamWriter(testFilePath);
                outputFile.WriteLine("hello");
                outputFile.Close();

                foreach (var file in Directory.EnumerateFiles(sharePath))
                {
                    Console.WriteLine(file);
                    Console.WriteLine(File.ReadAllText(file));
                }

                File.Delete(testFilePath);
                
            }

        }
    }
}
