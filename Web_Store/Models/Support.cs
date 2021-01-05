using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Web_Store.Models
{
    public static class Support
    {
        public static int BillCount(DB_StoreEntities db, string username, string state = "Đang Chờ")
        {
            if (username == "")
                return 0;
            try
            {
                var all = db.Accounts.Find(username).EarnBills.First(x => x.Status.Name == state).Deliveries.ToList();
                int count = 0;
                foreach (var item in all)
                    count += item.Quantity;

                return count;
            }
            catch
            {
                return 0;
            }
        }

        public static int ResetBag(DB_StoreEntities db, int itemid, int quantity, string username, bool add = false)
        {
            Account user = db.Accounts.Find(username);
            try
            {
                EarnBill bill = user.EarnBills.First(x => x.Status.Name == "Đang Chờ");
                try
                {
                    Delivery delivery = bill.Deliveries.First(x => x.ItemId == itemid);
                    if (delivery.Quantity == quantity && !add)
                        return 0;
                    bill.Price -= delivery.Price * delivery.Quantity;
                    delivery.Quantity = (add) ? delivery.Quantity + quantity : (quantity > 0) ? quantity : 0;

                    if (delivery.Quantity == 0)
                    {
                        db.Deliveries.Remove(delivery);
                        Item item = db.Items.Find(itemid);
                        int price = Convert.ToInt32((item.Sale == null) ? item.Price : (item.Price * (100 - item.Sale) / 100));

                        delivery = new Delivery()
                        {
                            ItemId = itemid,
                            Quantity = 1,
                            Price = price,
                        };
                        EarnBill billDelete;
                        try
                        {
                            billDelete = user.EarnBills.First(x => x.Status.Name == "Đã Huỷ");
                            try
                            {
                                delivery = billDelete.Deliveries.First(x => x.ItemId == itemid);
                            }
                            catch
                            {
                                billDelete.Deliveries.Add(delivery);
                                db.Entry(billDelete).State = EntityState.Modified;
                            }
                        }
                        catch
                        {
                            billDelete = new EarnBill();
                            billDelete.Address = "";
                            billDelete.Username = user.Username;
                            billDelete.Date = DateTime.Now;
                            billDelete.StatusId = db.Status.First(x => x.Name.Contains("Đã Huỷ")).StatusId;
                            billDelete.Deliveries.Add(delivery);
                            db.EarnBills.Add(billDelete);
                        }
                    }
                    else
                    {
                        bill.Price += delivery.Price * delivery.Quantity;
                        db.Entry(delivery).State = EntityState.Modified;
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    Item item = db.Items.Find(itemid);
                    int price = Convert.ToInt32((item.Sale == null) ? item.Price : (item.Price * (100 - item.Sale) / 100));
                    bill.Deliveries.Add(new Delivery()
                    {
                        ItemId = itemid,
                        BillId = bill.BillId,
                        Quantity = 1,
                        Price = price,
                    });
                    bill.Price += price;
                }
                db.Entry(bill).State = EntityState.Modified;
                db.SaveChanges();
            }
            catch
            {
                EarnBill bill = new EarnBill();
                bill.Username = user.Username;
                bill.Date = DateTime.Now;
                bill.StatusId = db.Status.First(x => x.Name.Contains("Đang Chờ")).StatusId;
                Item item = db.Items.Find(itemid);
                int price = Convert.ToInt32((item.Sale == null) ? item.Price : (item.Price * (100 - item.Sale) / 100));
                bill.Deliveries.Add(new Delivery()
                {
                    ItemId = itemid,
                    BillId = bill.BillId,
                    Quantity = quantity,
                    Price = price,
                });
                bill.Address = user.Address;
                bill.Price = price * quantity;
                db.EarnBills.Add(bill);
                db.SaveChanges();
            }
            return 1;
        }

        public static List<EarnBill> ReloadBill(DB_StoreEntities db, string state)
        {
            return db.EarnBills.Where(x => x.Status.Name == state).ToList();
        }

        public static bool ChangeBill(DB_StoreEntities db, string username, int? billId, string state2 = "Đang Xử Lí")
        {
            Account user = db.Accounts.Find(username);
            try
            {
                EarnBill bill = (billId != null) ? user.EarnBills.First(x => x.BillId == billId) : user.EarnBills.First(x => x.Status.Name == "Đang Chờ");

                bool okay = true;
                foreach (var r in bill.Deliveries)
                {
                    Item item = db.Items.Find(r.ItemId);
                    if (item.Quantity < r.Quantity)
                    {
                        r.Quantity = item.Quantity;
                        db.Entry(r).State = EntityState.Modified;
                        okay = false;
                    }
                }
                if (!okay)
                {
                    db.SaveChanges();
                    return false;
                }

                bill.Status = db.Status.First(x => x.Name == state2);
                bill.Address = user.Address;
                db.Entry(bill).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool ChangeBill(DB_StoreEntities db, int billId, int state = 2)
        {
            var s = db.Status.First(x => x.StatusId == state);
            if (s.Name == "Đã Huỷ")
                return DeleteBill(db, billId);
            try
            {
                EarnBill bill = db.EarnBills.First(x => x.BillId == billId);
                if (bill.Status.Name == "Đang Xử Lí" && (s.Name == "Đã Hoàn Thành" || s.Name == "Đang Vận Chuyển"))
                {
                    if (!DeliveryItem(db, billId))
                        return false;
                }
                else if (bill.Status.Name == "Đang Vận Chuyển" && s.Name == "Đã Huỷ")
                {
                    DeliveryItem(db, billId, -1);
                    return DeleteBill(db, billId);
                }
                bill.Status = s;
                db.Entry(bill).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool ChangePaidBill(DB_StoreEntities db, int billId, int state = 2)
        {
            var s = db.Status.First(x => x.StatusId == state);
            try
            {
                PaidBill bill = db.PaidBills.First(x => x.BillId == billId);
                if (bill.Status != s && s.Name == "Đã Hoàn Thành")
                {
                    ReceiptItem(db, billId);
                }
                else if (bill.Status.Name == "Đang Vận Chuyển" && s.Name == "Đã Huỷ")
                {
                    ReceiptItem(db, billId, -1);
                    return DeletePaidBill(db, billId);
                }
                bill.Status = s;
                db.Entry(bill).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool DeleteBill(DB_StoreEntities db, int billId)
        {
            try
            {
                EarnBill bill = db.EarnBills.First(x => x.BillId == billId);
                if (bill.Status.Name == "Đã Huỷ")
                {
                    var listDeliverty = bill.Deliveries.ToList();
                    for (int i = 0; i < listDeliverty.Count; i++)
                    {
                        bill.Deliveries.Remove(listDeliverty[i]);
                    }
                    db.EarnBills.Remove(bill);
                }
                else
                {
                    try
                    {
                        EarnBill deleteBill = bill.Account.EarnBills.First(x => x.Status.Name == "Đã Huỷ");
                        var listDelivery = bill.Deliveries.ToList();
                        for (int i = 0; i < listDelivery.Count; i++)
                        {
                            listDelivery[i].Quantity = 1;
                            bill.Deliveries.Remove(listDelivery[i]);
                            if (deleteBill.Deliveries.Count(x => x.ItemId == listDelivery[i].ItemId) == 0)
                                db.Deliveries.Add(new Delivery()
                                {
                                    ItemId = listDelivery[i].ItemId,
                                    BillId = deleteBill.BillId,
                                    Quantity = 1,
                                    Price = listDelivery[i].Price,
                                });
                        }
                        db.EarnBills.Remove(bill);
                    }
                    catch
                    {
                        bill.Status = db.Status.First(x => x.Name == "Đã Huỷ");
                        bill.Price = 0;
                        db.Entry(bill).State = EntityState.Modified;
                    }
                }

                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool DeletePaidBill(DB_StoreEntities db, int billId)
        {
            try
            {
                PaidBill bill = db.PaidBills.First(x => x.BillId == billId);
                if (bill.Status.Name == "Đã Huỷ")
                {
                    var listDeliverty = bill.Receipts.ToList();
                    for (int i = 0; i < listDeliverty.Count; i++)
                    {
                        bill.Receipts.Remove(listDeliverty[i]);
                    }
                    db.PaidBills.Remove(bill);
                }
                else
                {
                    try
                    {
                        PaidBill deleteBill = bill.Publisher.PaidBills.First(x => x.Status.Name == "Đã Huỷ");
                        var listReceipt = bill.Receipts.ToList();
                        for (int i = 0; i < listReceipt.Count; i++)
                        {
                            listReceipt[i].Quantity = 1;
                            bill.Receipts.Remove(listReceipt[i]);
                            if (deleteBill.Receipts.Count(x => x.ItemId == listReceipt[i].ItemId) == 0)
                                db.Receipts.Add(new Receipt()
                                {
                                    ItemId = listReceipt[i].ItemId,
                                    BillId = deleteBill.BillId,
                                    Quantity = 1,
                                    Price = listReceipt[i].Price,
                                });
                        }
                        db.PaidBills.Remove(bill);
                    }
                    catch
                    {
                        bill.Status = db.Status.First(x => x.Name == "Đã Huỷ");
                        bill.Price = 0;
                        db.Entry(bill).State = EntityState.Modified;
                    }
                }

                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool ReceiptItem(DB_StoreEntities db, int billId, int type = 1)
        {
            try
            {
                PaidBill paid = db.PaidBills.First(x => x.BillId == billId);
                foreach (var r in paid.Receipts)
                {
                    Item item = db.Items.Find(r.ItemId);
                    item.Quantity += r.Quantity * type;
                    db.Entry(item).State = EntityState.Modified;
                }
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public static bool DeliveryItem(DB_StoreEntities db, int billId, int type = 1)
        {
            //type = -1 là trả về
            try
            {
                EarnBill paid = db.EarnBills.First(x => x.BillId == billId);

                foreach (var r in paid.Deliveries)
                {
                    Item item = db.Items.Find(r.ItemId);
                    item.QuantitySold += r.Quantity * type;
                    item.Quantity -= r.Quantity * type;
                    db.Entry(item).State = EntityState.Modified;
                }
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
