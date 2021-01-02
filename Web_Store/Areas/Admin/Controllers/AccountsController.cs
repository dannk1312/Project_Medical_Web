using PagedList;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_Store.Models;

namespace Web_Store.Areas.Admin.Controllers
{
    [Authorize(Roles = "ADMIN")]
    public class AccountsController : Controller
    {
        private DB_StoreEntities db = new DB_StoreEntities();

        // GET: Admin/Accounts
        public ActionResult List(int? page)
        {
            if (page == null) page = 1;
            var Account = (from l in db.Accounts.Include(a => a.Access)
                           select l).OrderBy(x => x.Username);
            int pageSize = 15;
            // 4.1 Toán tử ?? trong C# mô tả nếu page khác null thì lấy giá trị page, còn nếu page = null thì lấy giá trị 1 cho biến pageNumber.
            int pageNumber = (page ?? 1);
            // 5. Trả về các Link được phân trang theo kích thước và số trang.
            return View(Account.ToPagedList(pageNumber, pageSize));
        }


    // GET: Admin/Accounts/Details/5
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
        return View(account);
    }

    // GET: Admin/Accounts/Create
    public ActionResult Create()
    {
        ViewBag.Alert = "none";
        ViewBag.AccessId = new SelectList(db.Accesses, "AccessId", "Name");
        return View();
    }

    // POST: Admin/Accounts/Create
    // To protect from overposting attacks, enable the specific properties you want to bind to, for 
    // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
    [HttpPost]
    [ValidateAntiForgeryToken]
    public ActionResult Create([Bind(Include = "Username,Password,Name,CreateDate,Birthday,Address,Phone,AccessId")] Account account)
    {
        if (ModelState.IsValid)
        {
            if (db.Accounts.Find(account.Username) == null)
            {
                account.CreateDate = DateTime.Now;
                db.Accounts.Add(account);
                db.SaveChanges();
                return RedirectToAction("List");
            }
            else
            {
                ViewBag.Alert = "block";
                ViewBag.Error = "Tài Khoản đã tồn tại";
            }
        }

        ViewBag.AccessId = new SelectList(db.Accesses, "AccessId", "Name", account.AccessId);
        return View(account);
    }

    // GET: Admin/Accounts/Edit/5
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
        return View(account);
    }

    // POST: Admin/Accounts/Edit/5
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
            return RedirectToAction("List");
        }
        ViewBag.AccessId = new SelectList(db.Accesses, "AccessId", "Name", account.AccessId);
        return View(account);
    }

    // GET: Admin/Accounts/Delete/5
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

    // POST: Admin/Accounts/Delete/5
    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public ActionResult DeleteConfirmed(string id)
    {
        Account account = db.Accounts.Find(id);
        db.Accounts.Remove(account);
        db.SaveChanges();
        return RedirectToAction("List");
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
