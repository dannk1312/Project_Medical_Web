using PagedList;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Windows.Forms;
using Web_Store.Models;

namespace Web_Store.Areas.Admin.Controllers
{
    [Authorize(Roles = "ADMIN")]
    [ValidateInput(false)]
    public class NewsController : Controller
    {
        private DB_StoreEntities db = new DB_StoreEntities();

        // GET: Admin/News
        public ActionResult List(int? page)
        {
            if (page == null) page = 1;
            var News = (from l in db.News.Include(n => n.Account).Include(n => n.Discuss)
                        select l).OrderBy(x => x.Username);
            int pageSize = 15;
            // 4.1 Toán tử ?? trong C# mô tả nếu page khác null thì lấy giá trị page, còn nếu page = null thì lấy giá trị 1 cho biến pageNumber.
            int pageNumber = (page ?? 1);
            // 5. Trả về các Link được phân trang theo kích thước và số trang.
            return View(News.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/News/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            News news = db.News.Find(id);
            if (news == null)
            {
                return HttpNotFound();
            }
            return View(news);
        }

        // GET: Admin/News/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/News/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "NewsId,Username,Content,isPublic,DiscussId,Date")] News news)
        {
            if (ModelState.IsValid)
            {
                news.Date = DateTime.Now;
                Account creater = db.Accounts.Find(HttpContext.User.Identity.Name);
                Discuss dc = new Discuss()
                {
                    Account = creater,
                    StartDate = news.Date,
                    Introduce = "Nói về tin tức",
                    Name = "#New",
                };
                db.Discusses.Add(dc);
                db.SaveChanges();

                var list = db.Discusses.Where(x => x.Username == creater.Username).ToList();
                dc = list[list.Count - 1];
                news.Discuss = dc;
                news.Account = creater;
                db.News.Add(news);
                db.SaveChanges();
                return RedirectToAction("List");
            }

            return View(news);
        }

        // GET: Admin/News/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            News news = db.News.Find(id);
            if (news == null)
            {
                return HttpNotFound();
            }

            return View(news);
        }

        // POST: Admin/News/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "NewsId,Username,Content,isPublic,DiscussId,Date")] News news)
        {
            if (ModelState.IsValid)
            {
                db.Entry(news).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("List");
            }

            return View(news);
        }

        // GET: Admin/News/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            News news = db.News.Find(id);
            if (news == null)
            {
                return HttpNotFound();
            }
            return View(news);
        }

        // POST: Admin/News/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            News news = db.News.Find(id);
            db.News.Remove(news);
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
