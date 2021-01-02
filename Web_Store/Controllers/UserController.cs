using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Web_Store.Models;

namespace Web_Store.Controllers
{
    public class UserController : Controller
    {
        private DB_StoreEntities db = new DB_StoreEntities();

        // GET: User
        [HttpGet]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Desk", "Home");
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login([Bind(Include = "Username,Password")] Account account)
        {
            Account check = db.Accounts.Find(account.Username);
            if (check != null && check.Password == account.Password)
            {
                FormsAuthentication.SetAuthCookie(check.Username, false);
                return RedirectToAction("Desk", "Home");
            }
            return View(account);
        }

        // GET: User/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Account account = db.Accounts.Find(id);
            if (account == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserBagItem = Support.BillCount(db, HttpContext.User.Identity.Name);
            return View(account);
        }

        //Sign up
        public ActionResult SignUp()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SignUp([Bind(Include = "Username,Password,Name,Birthday,Address,Phone,Email")] Account account)
        {
            if (ModelState.IsValid && db.Accounts.Find(account.Username) == null)
            {
                account.AccessId = 2;
                account.CreateDate = DateTime.Now;
                db.Accounts.Add(account);
                db.SaveChanges();
                FormsAuthentication.SetAuthCookie(account.Username, false);
                return RedirectToAction("Desk", "Home");
            }

            ViewBag.AccessId = new SelectList(db.Accesses, "AccessId", "Name", account.AccessId);
            return View(account);
        }

        [HttpGet]
        public ActionResult ForgotPassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ForgotPassword(string Username)
        {
            try
            {
                var user = db.Accounts.First(x => x.Username == Username);
                string sub = "Thông tin mật khẩu [" + user.Username + "]";
                string sms = "Mật Khẩu: " + user.Password;
                MailMessage mail = new MailMessage("severtest26@gmail.com", user.Email, sub, sms);
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
                client.EnableSsl = true;
                client.Credentials = new NetworkCredential("severtest26@gmail.com", "HD123456");
                mail.IsBodyHtml = true;
                client.Send(mail);
            }
            catch
            {
                ViewBag.err = "Username is not exist";
                return View();
            }
            ViewBag.err = "Password is send to email";
            return RedirectToAction("Login");
        }

        // GET: User/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Account account = db.Accounts.Find(id);
            if (account == null)
            {
                return HttpNotFound();
            }
            ViewBag.AccessId = new SelectList(db.Accesses, "AccessId", "Name", account.AccessId);
            ViewBag.UserBagItem = Support.BillCount(db, HttpContext.User.Identity.Name);
            return View(account);
        }

        // POST: User/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Username,Password,Name,CreateDate,Birthday,Address,Phone,AccessId,Email")] Account account)
        {
            if (ModelState.IsValid)
            {
                db.Entry(account).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Details", "User", new { id = account.Username });
            }
            ViewBag.AccessId = new SelectList(db.Accesses, "AccessId", "Name", account.AccessId);
            ViewBag.UserBagItem = Support.BillCount(db, HttpContext.User.Identity.Name);
            return View(account);
        }

        // GET: User/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Account account = db.Accounts.Find(id);
            if (account == null)
            {
                return HttpNotFound();
            }
            return View(account);
        }

        // POST: User/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Account account = db.Accounts.Find(id);
            db.Accounts.Remove(account);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
