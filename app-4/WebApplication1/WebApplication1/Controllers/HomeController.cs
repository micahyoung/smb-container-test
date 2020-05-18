using Steeltoe.Common.Net;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace WebApplication1.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
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
                    Console.WriteLine(System.IO.File.ReadAllText(file));
                }

                System.IO.File.Delete(testFilePath);
            }

            ViewBag.Title = "Home Page";

            return View();
        }
    }
}
