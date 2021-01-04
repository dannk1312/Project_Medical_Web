using OfficeOpenXml;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_Store.Models;

namespace Web_Store.Areas.Admin.Controllers
{
    [Authorize(Roles = "ADMIN")]
    [ValidateInput(false)]
    public class ItemsController : Controller
    {
        private DB_StoreEntities db = new DB_StoreEntities();

        // GET: Admin/Items
        public ActionResult List(int? page)
        {
            if (page == null) page = 1;
            var Item = (from l in db.Items.Include(a => a.Author)
                        select l).OrderBy(x => x.ItemId);
            int pageSize = 15;
            // 4.1 Toán tử ?? trong C# mô tả nếu page khác null thì lấy giá trị page, còn nếu page = null thì lấy giá trị 1 cho biến pageNumber.
            int pageNumber = (page ?? 1);
            // 5. Trả về các Link được phân trang theo kích thước và số trang.
            return View(Item.ToPagedList(pageNumber, pageSize));
        }
        // GET: Admin/Items/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Item Item = db.Items.Find(id);
            if (Item == null)
            {
                return HttpNotFound();
            }
            return View(Item);
        }

        // GET: Admin/Items/Create
        public ActionResult Create()
        {
            ViewBag.AuthorId = new SelectList(db.Authors, "AuthorId", "Name");
            ViewBag.Categories = new MultiSelectList(db.Categories, "CategoryId", "Name");

            return View();
        }

        // POST: Admin/Items/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ItemId,Name,PublishDate,AuthorId,Quantity,Price,Introduce,ImagePath")] Item Item, int[] Categories)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.Items.First(x => x.Name.Contains(Item.Name));
                    ViewBag.sms = "Item exist ...";
                }
                catch
                {
                    if (Categories != null)
                        for (int i = 0; i < Categories.Length; i++)
                        {
                            Item.Categories.Add(db.Categories.Find(Categories[i]));
                        }
                    Account creater = db.Accounts.Find(HttpContext.User.Identity.Name);
                    Discuss dc = new Discuss()
                    {
                        Account = creater,
                        StartDate = DateTime.Now,
                        Introduce = "Nói về sách " + Item.Name,
                        Name = "#TL",
                    };
                    db.Discusses.Add(dc);
                    db.SaveChanges();

                    var list = db.Discusses.Where(x => x.Username == creater.Username).ToList();
                    dc = list[list.Count - 1];
                    Item.Discuss = dc;
                    Item.Quantity = 0;
                    Item.Rate = 0;
                    Item.QuantitySold = 0;
                    db.Items.Add(Item);
                    db.SaveChanges();
                    return RedirectToAction("List");
                }
            }
            
            ViewBag.AuthorId = new SelectList(db.Authors, "AuthorId", "Name", Item.AuthorId);
            ViewBag.Categories = new MultiSelectList(db.Categories, "CategoryId", "Name", Item.Categories);
            return View(Item);
        }

        // GET: Admin/Items/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Item Item = db.Items.Find(id);
            if (Item == null)
            {
                return HttpNotFound();
            }

            ViewBag.Categories = new MultiSelectList(db.Categories, "CategoryId", "Name");
            ViewBag.AuthorId = new SelectList(db.Authors, "AuthorId", "Name");
            return View(Item);
        }

        // POST: Admin/Items/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ItemId,Name,PublishDate,AuthorId,Quantity,Price,Introduce,ImagePath")] Item Item, int[] Categories)
        {
            if (ModelState.IsValid)
            {
                if (Categories != null)
                    foreach (int i in Categories)
                        Item.Categories.Add(db.Categories.Find(i));
                var existingItem = db.Items.Include("Categories")
                        .Where(s => s.ItemId == Item.ItemId).FirstOrDefault<Item>();

                var deletedCategories = existingItem.Categories.Except(Item.Categories).ToList<Category>();
                var addedCategories = Item.Categories.Except(existingItem.Categories).ToList<Category>();

                deletedCategories.ForEach(c => existingItem.Categories.Remove(c));

                foreach (Category c in addedCategories)
                {
                    if (db.Entry(c).State == EntityState.Detached)
                        db.Categories.Attach(c);

                    existingItem.Categories.Add(c);
                }
                existingItem.Name = Item.Name;
                existingItem.Introduce = Item.Introduce;
                existingItem.AuthorId = Item.AuthorId;
                existingItem.Price = Item.Price;
                existingItem.PublishDate = Item.PublishDate;
                existingItem.ImagePath = Item.ImagePath;

                db.SaveChanges();
                return RedirectToAction("List");
            }

            ViewBag.Categories = new MultiSelectList(db.Categories, "CategoryId", "Name", Item.Categories);
            ViewBag.AuthorId = new SelectList(db.Authors, "AuthorId", "Name", Item.AuthorId);
            return View(Item);
        }

        // GET: Admin/Items/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Item Item = db.Items.Find(id);
            if (Item == null)
            {
                return HttpNotFound();
            }
            return View(Item);
        }

        // POST: Admin/Items/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Item Item = db.Items.Find(id);
            db.Items.Remove(Item);
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

        public ActionResult ExportExcel()
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            ExcelPackage excel = new ExcelPackage();
            var workSheet = excel.Workbook.Worksheets.Add("Sheet1");
            var list = db.Items.ToList();

            workSheet.Cells[1, 1].Value = "ID";
            workSheet.Cells[1, 2].Value = "Tên";
            workSheet.Cells[1, 3].Value = "Thể Loại";
            workSheet.Cells[1, 4].Value = "Ngày Xuất Bản";
            workSheet.Cells[1, 5].Value = "Tên TG";
            workSheet.Cells[1, 6].Value = "SL";
            workSheet.Cells[1, 7].Value = "Giá";
            workSheet.Cells[1, 8].Value = "Sale";
            workSheet.Cells[1, 9].Value = "Đánh Giá";
            workSheet.Cells[1, 10].Value = "SL Bán";
            workSheet.Cells[1, 11].Value = "Các nơi nhập";
            workSheet.Cells[1, 12].Value = "Người mua";

            int index = 0;
            for (int i = 0; i < list.Count; i++)
            {
                index = i + 2;
                workSheet.Cells[index, 1].Value = list[i].ItemId;
                workSheet.Cells[index, 2].Value = list[i].Name;
                if (list[i].PublishDate != null)
                    workSheet.Cells[index, 4].Value = ((DateTime)list[i].PublishDate).ToString("dd/MM/yyyy");
                workSheet.Cells[index, 5].Value = list[i].Author.Name;
                workSheet.Cells[index, 6].Value = list[i].Quantity;
                workSheet.Cells[index, 7].Value = list[i].Price;
                workSheet.Cells[index, 8].Value = list[i].Sale;
                workSheet.Cells[index, 9].Value = list[i].Rate;
                workSheet.Cells[index, 10].Value = list[i].QuantitySold;

                List<string> temp = new List<string>();
                foreach (var run in list[i].Categories)
                    temp.Add(run.Name);
                workSheet.Cells[index, 3].Value = String.Join(",", temp);
                temp.Clear();

                foreach (var run in db.Publishers)
                {
                    if (!temp.Contains(run.Name))
                    {
                        if (run.PaidBills.Count(x => x.Receipts.Count(a => a.ItemId == list[i].ItemId) > 0) > 0)
                            temp.Add(run.Name);
                    }
                }
                workSheet.Cells[index, 11].Value = String.Join(",", temp);
                temp.Clear();

                foreach (var run in db.Accounts)
                {
                    if (!temp.Contains(run.Name))
                    {
                        if (run.EarnBills.Count(x => x.Deliveries.Count(a => a.ItemId == list[i].ItemId) > 0) > 0)
                            temp.Add(run.Name);
                    }
                }
                workSheet.Cells[index, 12].Value = String.Join(",", temp);
                temp.Clear();
            }

            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                //here i have set filname as Students.xlsx
                Response.AddHeader("content-disposition", "attachment;  filename=Item" + DateTime.Now.ToString("ddMMyy_hhmmss") + ".xlsx");
                excel.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }
            return RedirectToAction("List");
        }

        public ActionResult ImportExcel(HttpPostedFileBase FileUpload)
        {
            List<string> data = new List<string>();
            if (FileUpload != null)
            {
                // tdata.ExecuteCommand("truncate table OtherCompanyAssets");  
                if (FileUpload.ContentType == "application/vnd.ms-excel" || FileUpload.ContentType == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
                {
                    string filename = FileUpload.FileName;
                    string targetpath = Server.MapPath("~/Upload/");
                    FileUpload.SaveAs(targetpath + filename);
                    string pathToExcelFile = targetpath + filename;

                    using (ExcelPackage package = new ExcelPackage(new FileInfo(pathToExcelFile)))
                    {
                        ExcelWorksheet worksheet;

                        try
                        {
                            ExcelPackage.LicenseContext = LicenseContext.Commercial;
                            worksheet = package.Workbook.Worksheets.FirstOrDefault();
                        }
                        catch
                        {
                            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
                            worksheet = package.Workbook.Worksheets.FirstOrDefault();
                        }
                        int colCount = worksheet.Dimension.End.Column;
                        int rowCount = worksheet.Dimension.End.Row;
                        string str = "";
                        for (int row = 2; row <= rowCount; row++)
                        {
                            str = worksheet.Cells[row, 1].Value?.ToString().Trim();
                            Item temp = new Item();
                            temp.Name = str;

                            var itemList = db.Items.ToList();
                            bool okay = false;
                            foreach (var run in itemList)
                            {
                                if (run.Name.Trim().CompareTo(str) == 0)
                                {
                                    okay = true;
                                    break;
                                }
                            }
                            if (!okay)
                            {

                                str = worksheet.Cells[row, 2].Value?.ToString().Trim();

                                var authorList = db.Authors.ToList();
                                foreach (var run in authorList)
                                {
                                    if (run.Name.Trim().CompareTo(str) == 0)
                                    {
                                        temp.Author = run;
                                        break;
                                    }
                                }
                                if (temp.Author == null)
                                {
                                    db.Authors.Add(new Author() { Name = str });
                                }

                                try
                                {
                                    temp.PublishDate = Convert.ToDateTime(worksheet.Cells[row, 3].Value?.ToString().Trim());
                                }
                                catch
                                {
                                    temp.PublishDate = null;
                                }

                                try
                                {
                                    temp.Price = Convert.ToInt32(worksheet.Cells[row, 4].Value?.ToString().Trim());
                                    Account creater = db.Accounts.Find(HttpContext.User.Identity.Name);
                                    Discuss dc = new Discuss()
                                    {
                                        Account = creater,
                                        StartDate = DateTime.Now,
                                        Introduce = "Nói về sách " + temp.Name,
                                        Name = "#TL",
                                    };
                                    db.Discusses.Add(dc);
                                    db.SaveChanges();

                                    var list = db.Discusses.Where(x => x.Username == creater.Username).ToList();
                                    dc = list[list.Count - 1];
                                    temp.Discuss = dc;
                                    temp.Quantity = 0;
                                    temp.Rate = 0;
                                    temp.QuantitySold = 0;
                                    db.Items.Add(temp);
                                    db.SaveChanges();
                                }
                                catch
                                {

                                }

                            }
                        }
                    }
                }
            }
            return RedirectToAction("List");
        }
    }
}
