using PagedList;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using Web_Store.Models;

namespace Web_Store.Controllers
{
    [ValidateInput(false)]
    public class HomeController : Controller
    {
        private DB_StoreEntities db = new DB_StoreEntities();

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public ActionResult ViewItem(int id)
        {
            return PartialView("../Partial/_Item_Details", db.Items.First(x => x.ItemId == id));
        }
        public ActionResult RateItem(int id)
        {
            try
            {
                ItemRate ir = db.ItemRates.First(x => x.ItemId == id && x.Username == HttpContext.User.Identity.Name);
                ViewBag.Rate = ir.Rate;
                ViewBag.Comment = ir.Comment;
            }
            catch
            {

            }
            return PartialView("../Partial/_Rate", db.Items.Find(id));
        }


        [HttpGet]
        public ActionResult Contact()
        {
            return PartialView("../Partial/_Contact");
        }
        public void Contact(string introduce)
        {
            db.Discusses.Add(new Discuss()
            {
                Name = "#DGYK",
                Introduce = introduce,
                StartDate = DateTime.Now,
                Username = HttpContext.User.Identity.Name,
            });
            db.SaveChanges();
        }
        public void SendRate(int id, double Rate, string Comment)
        {
            Item it = db.Items.Find(id);
            try
            {
                ItemRate ir = db.ItemRates.First(x => x.ItemId == id && x.Username == HttpContext.User.Identity.Name);
                it.Rate = (it.Rate * it.ItemRates.Count() - ir.Rate + Rate) / (it.ItemRates.Count());
                ir.Rate = Rate;
                ir.Comment = Comment;
                db.Entry(ir).State = EntityState.Modified;
            }
            catch
            {
                db.ItemRates.Add(new ItemRate()
                {
                    ItemId = id,
                    Username = HttpContext.User.Identity.Name,
                    Rate = Rate,
                    Comment = Comment
                });

                if (it.Rate == null)
                {
                    it.Rate = Rate;
                }
                else
                {

                    it.Rate = (it.Rate * (it.ItemRates.Count() - 1) + Rate) / it.ItemRates.Count();
                }
            }
            db.SaveChanges();
        }
        public bool postNews(string post)
        {
            try
            {
                News news = new News();
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
                news.Content = post;
                news.isPublic = false;
                db.News.Add(news);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool postDiscuss(string name, string introduce)
        {
            db.Discusses.Add(new Discuss()
            {
                Name = name,
                Introduce = introduce,
                StartDate = DateTime.Now,
                Username = HttpContext.User.Identity.Name,
            });
            db.SaveChanges();
            return true;
        }
        public bool sendMessage(int id, string message)
        {
            try
            {
                var discuss = db.Discusses.First(x => x.DiscussId == id);
                var mess = new Message()
                {
                    Username = HttpContext.User.Identity.Name,
                    Time = DateTime.Now,
                    Content = message,
                    DiscussId = discuss.DiscussId,
                };
                db.Messages.Add(mess);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public ActionResult loadMessage(int id)
        {
            ViewBag.Type = "block";
            var discuss = db.Discusses.First(x => x.DiscussId == id);
            return PartialView("../Partial/_Discuss", discuss);
        }
        public ActionResult News(int? page)
        {
            if (page == null) page = 1;
            var news = (from l in db.News.Include(a => a.Discuss).Include(a => a.Account).Where(x=>x.isPublic==true)
                        select l).OrderBy(x => x.Username);
            int pageSize = 1;
            int pageNumber = (page ?? 1);
            ViewBag.Type = "none";
            ViewBag.UserBagItem = Support.BillCount(db, HttpContext.User.Identity.Name);
            return View(news.ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Desk(int? page)
        {
            if (page == null)
                page = 1;
            var listItem = (from l in db.Items.Include(a => a.Author).Include(a => a.Categories).Include(a => a.ItemRates)
                            select l).OrderBy(x => x.ItemId);

            int pageSize = 20;
            int pageNumber = (page ?? 1);

            decimal min = 100000000;
            decimal max = 0;
            foreach (var run in listItem)
            {
                min = Math.Min(min, run.Price);
                max = Math.Max(max, run.Price);
            }

            if (Convert.ToInt32(min) == 100000000 && Convert.ToInt32(max) == 0)
            {
                max = 100000000;
                min = 0;
            }

            ViewBag.MaxPrice = Convert.ToInt32(max);
            ViewBag.MinPrice = Convert.ToInt32(min);

            return ListToDesk(listItem.ToPagedList(pageNumber, pageSize));
        }
        public ViewResult ListToDesk(IEnumerable<Item> listItem)
        {
            ViewBag.UserBagItem = Support.BillCount(db, HttpContext.User.Identity.Name);
            ViewBag.Categories = new MultiSelectList(db.Categories, "CategoryId", "Name");
            ViewBag.AuthorId = new SelectList(db.Authors, "AuthorId", "Name");
            ViewBag.ItemId = new SelectList(db.Items, "ItemId", "Name");
            return View("Desk", listItem);
        }
        public bool buyItem()
        {
            return Support.ChangeBill(db, HttpContext.User.Identity.Name, null);
        }
        public ActionResult Search(int ItemId)
        {
            if (ItemId != -1)
            {
                var lItem = db.Items.Include(a => a.Author).Include(a => a.Categories).Include(a => a.ItemRates).Where(x => x.ItemId == ItemId);
                var item = lItem.ToList()[0];
                ViewBag.MaxPrice = Convert.ToInt32(item.Price);
                ViewBag.MinPrice = Convert.ToInt32(item.Price);
                return ListToDesk(lItem.OrderBy(x => x.ItemId).ToPagedList(1, 1));
            }
            return Desk(null);
        }
        public ActionResult Filter(int? page, int? AuthorId, int[] Categories, int minPrice, int maxPrice, string nameSort, string typeSort)
        {
            ViewBag.MaxPrice = maxPrice;
            ViewBag.MinPrice = minPrice;

            maxPrice += 1;
            minPrice -= 1;
            IEnumerable<Item> listItem;
            if (AuthorId != -1)
            {
                ViewBag.Author = AuthorId;

                listItem = (from l in db.Items.Include(a => a.Author).Include(a => a.Categories).Include(a => a.ItemRates).Where(x => x.AuthorId == AuthorId && x.Price >= minPrice && x.Price <= maxPrice)
                            select l).OrderBy(x => x.ItemId);
            }
            else
                listItem = (from l in db.Items.Include(a => a.Author).Include(a => a.Categories).Include(a => a.ItemRates).Where(x => x.Price >= minPrice && x.Price <= maxPrice)
                            select l).OrderBy(x => x.ItemId);

            List<Item> list = listItem.ToList();
            if (Categories != null)
            {
                string[] str = new string[Categories.Length];
                for (int i = 0; i < Categories.Length; i++)
                    str[i] = Categories[i].ToString();
                ViewBag.Cate = '[' + String.Join(",", str) + ']';
                for (int i = 0; i < Categories.Length && listItem.Count() > 0; i++)
                {
                    list = list.Where(x => x.Categories.Any(a => a.CategoryId == Categories[i])).ToList();
                }
            }

            int n = list.Count();

            switch (nameSort)
            {
                case "Đánh Giá":
                    ViewBag.nameSort = nameSort;
                    for (int i = 0; i < n - 1; i++)
                    {
                        int min_idx = i;
                        for (int j = i + 1; j < n; j++)
                            if (Convert.ToDouble(list[j].Rate).CompareTo(Convert.ToDouble(list[min_idx].Rate)) < 0)
                                min_idx = j;
                        var temp = list[min_idx];
                        list[min_idx] = list[i];
                        list[i] = temp;
                    }
                    break;
                case "Giá Cả":
                    ViewBag.nameSort = nameSort;
                    for (int i = 0; i < n - 1; i++)
                    {
                        int min_idx = i;
                        for (int j = i + 1; j < n; j++)
                            if (list[j].Price.CompareTo(list[min_idx].Price) < 0)
                                min_idx = j;

                        var temp = list[min_idx];
                        list[min_idx] = list[i];
                        list[i] = temp;
                    }
                    break;
                case "Lượt Mua":
                    ViewBag.nameSort = nameSort;
                    for (int i = 0; i < n - 1; i++)
                    {
                        int min_idx = i;
                        for (int j = i + 1; j < n; j++)
                            if (Convert.ToDouble(list[j].QuantitySold).CompareTo(Convert.ToDouble(list[min_idx].QuantitySold)) < 0)
                                min_idx = j;
                        var temp = list[min_idx];
                        list[min_idx] = list[i];
                        list[i] = temp;
                    }
                    break;
            }

            if (typeSort == "Giảm Dần")
                list.Reverse();
            ViewBag.typeSort = typeSort;

            if (page == null) page = 1;

            int pageSize = 20;
            int pageNumber = (page ?? 1);

            return ListToDesk(list.ToPagedList(pageNumber, pageSize));
        }

        [Authorize]
        public ActionResult Discuss(int? page)
        {
            if (page == null) page = 1;
            var dis = (from l in db.Discusses
                        select l).OrderBy(x => x.StartDate);
            int pageSize = 15;
            int pageNumber = (page ?? 1);
            ViewBag.UserBagItem = Support.BillCount(db, HttpContext.User.Identity.Name);
            return View(dis.ToPagedList(pageNumber, pageSize));
        }

        public int ResetUserItemBag(int id, int quantity, bool add = false)
        {
            if (Support.ResetBag(db, id, quantity, HttpContext.User.Identity.Name, add: add) == 0)
                return -1;
            return Support.BillCount(db, HttpContext.User.Identity.Name);
        }

        public ActionResult UserBag()
        {
            Account user = db.Accounts.Find(HttpContext.User.Identity.Name);
            try
            {
                EarnBill bill = user.EarnBills.First(x => x.Status.Name == "Đang Chờ");
                return PartialView("../Partial/_BillItem", bill);
            }
            catch
            {
                EarnBill bill = new EarnBill()
                {
                    Date = DateTime.Now,
                    Username = user.Username,
                    StatusId = db.Status.First(x => x.Name == "Đang Chờ").StatusId,
                    Price = 0,
                    Address = user.Address,
                };
                db.EarnBills.Add(bill);
                db.SaveChanges();
                return PartialView("../Partial/_BillItem", bill);
            }
        }

        public ActionResult findBill(string state)
        {
            return PartialView("../Partial/_ListBill", db.Accounts.Find(HttpContext.User.Identity.Name).EarnBills.Where(x => x.Status.Name.Contains(state)));
        }

        

    }
}