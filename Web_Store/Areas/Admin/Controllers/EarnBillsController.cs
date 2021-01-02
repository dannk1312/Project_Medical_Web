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
    public class EarnBillsController : Controller
    {
        private DB_StoreEntities db = new DB_StoreEntities();

        // GET: Admin/EarnBills
        public ActionResult List(int? page, int? type)
        {
            if (page == null)
                page = 1;
            if (type == null)
                type = 2;
            var earnBills = (from l in db.EarnBills.Include(e => e.Account).Include(e => e.Status).Where(x => x.StatusId == type)
                             select l).OrderBy(x => x.Username);
            int pageSize = 15;
            // 4.1 Toán tử ?? trong C# mô tả nếu page khác null thì lấy giá trị page, còn nếu page = null thì lấy giá trị 1 cho biến pageNumber.
            int pageNumber = (page ?? 1);
            // 5. Trả về các Link được phân trang theo kích thước và số trang.
            ViewBag.StatusId = new SelectList(db.Status.Where(x => x.StatusId >1 && x.StatusId <= 5), "StatusId", "Name",type);
            return View(earnBills.ToPagedList(pageNumber, pageSize));
        }

        public bool Change(int id,int status)
        {
            return Support.ChangeBill(db,id,status);
        }
        // GET: Admin/EarnBills/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EarnBill earnBill = db.EarnBills.Find(id);
            if (earnBill == null)
            {
                return HttpNotFound();
            }
            return View(earnBill);
        }

        // GET: Admin/EarnBills/Create
        public ActionResult Create()
        {
            ViewBag.Username = new SelectList(db.Accounts, "Username", "Password");
            ViewBag.StatusId = new SelectList(db.Status, "StatusId", "Name");
            return View();
        }

        // POST: Admin/EarnBills/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BillId,Date,StatusId,Username,Price")] EarnBill earnBill)
        {
            if (ModelState.IsValid)
            {
                db.EarnBills.Add(earnBill);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Username = new SelectList(db.Accounts, "Username", "Password", earnBill.Username);
            ViewBag.StatusId = new SelectList(db.Status, "StatusId", "Name", earnBill.StatusId);
            return View(earnBill);
        }

        // GET: Admin/EarnBills/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EarnBill earnBill = db.EarnBills.Find(id);
            if (earnBill == null)
            {
                return HttpNotFound();
            }
            ViewBag.Username = new SelectList(db.Accounts, "Username", "Password", earnBill.Username);
            ViewBag.StatusId = new SelectList(db.Status, "StatusId", "Name", earnBill.StatusId);
            return View(earnBill);
        }

        // POST: Admin/EarnBills/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BillId,Date,StatusId,Username,Price")] EarnBill earnBill)
        {
            if (ModelState.IsValid)
            {
                db.Entry(earnBill).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Username = new SelectList(db.Accounts, "Username", "Password", earnBill.Username);
            ViewBag.StatusId = new SelectList(db.Status, "StatusId", "Name", earnBill.StatusId);
            return View(earnBill);
        }

        // GET: Admin/EarnBills/Delete/5
        public bool Delete(int id)
        {
            return Support.DeleteBill(db,id);
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
