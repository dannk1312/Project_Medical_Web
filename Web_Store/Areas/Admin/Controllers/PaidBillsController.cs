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
    public class PaidBillsController : Controller
    {
        private DB_StoreEntities db = new DB_StoreEntities();

        // GET: Admin/PaidBills
        public ActionResult List(int? page, int? type)
        {
            if (page == null)
                page = 1;
            if (type == null)
                type = 4;
            var paidBills = (from l in db.PaidBills.Include(e => e.Publisher).Include(e => e.Status).Where(x => x.StatusId == type)
                             select l).OrderBy(x => x.PublisherId);
            int pageSize = 15;
            // 4.1 Toán tử ?? trong C# mô tả nếu page khác null thì lấy giá trị page, còn nếu page = null thì lấy giá trị 1 cho biến pageNumber.
            int pageNumber = (page ?? 1);
            // 5. Trả về các Link được phân trang theo kích thước và số trang.
            ViewBag.StatusId = new SelectList(db.Status.Where(x => x.StatusId > 3), "StatusId", "Name", type);
            return View(paidBills.ToPagedList(pageNumber, pageSize));
        }
        public bool Change(int id, int status)
        {
            return Support.ChangePaidBill(db, id, status);
        }

        public bool Delete(int id)
        {
            return Support.DeletePaidBill(db, id);
        }

        // GET: Admin/PaidBills/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PaidBill paidBill = db.PaidBills.Find(id);
            if (paidBill == null)
            {
                return HttpNotFound();
            }
            return View(paidBill);
        }

        // GET: Admin/PaidBills/Create
        public ActionResult Create()
        {
            ViewBag.PublisherId = new SelectList(db.Publishers, "PublisherId", "Name");
            ViewBag.StatusId = new SelectList(db.Status.Where(x => x.StatusId == 4 || x.StatusId == 6), "StatusId", "Name");
            ViewBag.ItemId = new SelectList(db.Items, "ItemId", "Name");
            return View();
        }

        // POST: Admin/PaidBills/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BillId,Date,StatusId,PublisherId")] PaidBill paidBill, string billtext)
        {
            if (ModelState.IsValid)
            {
                List<Receipt> r = new List<Receipt>();
                var lines = billtext.Split('\n');
                foreach (var line in lines)
                {
                    if (line == "")
                        continue;
                    var data = line.Split('\t');
                    var a = new Receipt();
                    a.ItemId = Convert.ToInt32(data[0].Split(':')[0]);
                    a.Quantity = Convert.ToInt32(data[1].Split(':')[1]);
                    a.Price = Convert.ToInt32(data[2].Split(':')[1]);

                    int index = r.FindIndex(x => x.ItemId == a.ItemId);
                    if (index > -1)
                    {
                        r[index].Quantity += a.Quantity;
                        r[index].Price = (r[index].Price > a.Price) ? r[index].Price : a.Price;
                    }
                    else
                        r.Add(a);
                }

                paidBill.Price = 0;
                paidBill.Date = DateTime.Now;
                db.PaidBills.Add(paidBill);
                db.SaveChanges();
                paidBill = db.PaidBills.Where(x => x.Publisher.PublisherId == paidBill.PublisherId).ToList().FindLast(x => x.PublisherId > -1);
                foreach (var receipt in r)
                {
                    receipt.BillId = paidBill.BillId;
                    db.Receipts.Add(receipt);
                    paidBill.Price += receipt.Price * receipt.Quantity;
                }
                db.Entry(paidBill).State = EntityState.Modified;
                db.SaveChanges();

                if (db.Status.Find(paidBill.StatusId).Name == "Đã Hoàn Thành")
                {
                    Support.ReceiptItem(db, paidBill.BillId);
                }

                return RedirectToAction("List");
            }

            ViewBag.PublisherId = new SelectList(db.Publishers, "PublisherId", "Name", paidBill.PublisherId);
            ViewBag.StatusId = new SelectList(db.Status.Where(x => x.StatusId == 4 || x.StatusId == 6), "StatusId", "Name");
            ViewBag.ItemId = new SelectList(db.Items, "ItemId", "Name");
            ViewBag.billtext = billtext;
            return View(paidBill);
        }


        // GET: Admin/PaidBills/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PaidBill paidBill = db.PaidBills.Find(id);
            if (paidBill == null)
            {
                return HttpNotFound();
            }
            ViewBag.PublisherId = new SelectList(db.Publishers, "PublisherId", "Name", paidBill.PublisherId);
            ViewBag.StatusId = new SelectList(db.Status, "StatusId", "Name", paidBill.StatusId);
            return View(paidBill);
        }

        // POST: Admin/PaidBills/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BillId,Date,StatusId,PublisherId,Price")] PaidBill paidBill)
        {
            if (ModelState.IsValid)
            {
                db.Entry(paidBill).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.PublisherId = new SelectList(db.Publishers, "PublisherId", "Name", paidBill.PublisherId);
            ViewBag.StatusId = new SelectList(db.Status, "StatusId", "Name", paidBill.StatusId);
            return View(paidBill);
        }

        // GET: Admin/PaidBills/Delete/5
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
