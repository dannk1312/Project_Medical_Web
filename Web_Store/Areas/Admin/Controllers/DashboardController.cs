using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_Store.Models;

namespace Web_Store.Areas.Admin.Controllers
{
    [Authorize(Roles = "ADMIN")]
    public class DashboardController : Controller
    {
        private DB_StoreEntities db = new DB_StoreEntities();
        // GET: Admin/Dashboard
        public ActionResult Statistic(int? year)
        {
            if (year == null) year = DateTime.Now.Year;
            decimal earn = 0;
            decimal paid = 0;
            int quantityItem = 0;
            int quantitySold = 0;
            int User = db.Accounts.Count();
            int[] earn12 = new int[13];
            int[] paid12 = new int[13];
            string[] month = { "", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "July", "Aug", "Sep", "Oct", "Nov", "Dec" };

            var earnBill = db.EarnBills;
            foreach (var r in earnBill)
                if (r.Date.Year == year && r.Status.Name != "Đã Huỷ")
                {
                    earn += (decimal)r.Price;
                    earn12[r.Date.Month] += Convert.ToInt32(r.Price);
                }

            var paidBill = db.PaidBills;
            foreach (var r in paidBill)
                if (r.Date.Year == year)
                {
                    paid += (decimal)r.Price;
                    paid12[r.Date.Month] += Convert.ToInt32(r.Price);
                }

            var item = db.Items;
            foreach (var r in item)
            {
                quantityItem += r.Quantity;
                quantitySold += (int)r.QuantitySold;
            }

            ViewBag.Year = year;
            ViewBag.qUser = User;
            ViewBag.qItem = quantityItem;
            ViewBag.sItem = quantitySold;
            ViewBag.mEarn = earn;
            ViewBag.mPaid = paid;
            ViewBag.EarnBill = earnBill;
            ViewBag.PaidBill = paidBill;
            ViewBag.cEarn = earn12;
            ViewBag.cPaid = paid12;
            ViewBag.Month = month;
            return View();
        }

        public ActionResult Opinion()
        {
            return View(db.Discusses.Where(x=>x.Name.Contains("#DGYK")).ToList());
        }

        public void DeleteOpinion(int id)
        {
            try
            {
                db.Discusses.Remove(db.Discusses.First(x => x.DiscussId == id));
                db.SaveChanges();
            }
            catch
            {

            }
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