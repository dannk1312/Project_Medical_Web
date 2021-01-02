using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Web_Store.Models
{
    [MetadataType(typeof(AccountMetaData))]
    public partial class Account
    {

    }

    public class AccountMetaData
    {
        [Required]
        [Display(Name = "Tài Khoản")]
        [MaxLength(50, ErrorMessage = "Tài Khoản chỉ có thể chứa 50 kí tự")]
        public string Username { get; set; }

        [Required]
        [Display(Name = "Mật Khẩu")]
        [MaxLength(50, ErrorMessage = "Tài Khoản chỉ có thể chứa 50 kí tự")]
        public string Password { get; set; }

        [Required]
        [Display(Name = "Họ và Tên")]
        [MaxLength(50, ErrorMessage = "Tài Khoản chỉ có thể chứa 50 kí tự")]
        public string Name { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        [Display(Name = "Ngày Tạo")]
        public Nullable<System.DateTime> CreateDate { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        [Display(Name = "Ngày Sinh")]
        public Nullable<System.DateTime> Birthday { get; set; }

        [Required]
        [Display(Name = "Địa Chỉ")]
        public string Address { get; set; }

        [Required]
        [Display(Name = "Số Điện Thoại")]
        [MaxLength(50, ErrorMessage = "SĐT chỉ có thể chứa 10 kí tự")]
        [DataType(DataType.PhoneNumber)]
        public string Phone { get; set; }

        [Required]
        [Display(Name = "Email")]
        [MaxLength(50, ErrorMessage = "Email chỉ có thể chứa 50 kí tự")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Display(Name = "Quyền Truy Cập")]
        public int AccessId { get; set; }
    }


    [MetadataType(typeof(CategoryMetaData))]
    public partial class Category
    {

    }
    public class CategoryMetaData
    {
        [Display(Name = "Thể Loại")]
        [MaxLength(50, ErrorMessage = "Họ và Tên chỉ có thể chứa 50 kí tự")]
        public string Name { get; set; }

        [Display(Name = "Giới Thiệu")]
        [DataType(DataType.MultilineText)]
        public string Introduce { get; set; }
    }

    [MetadataType(typeof(AuthorMetaData))]
    public partial class Author
    {

    }
    public class AuthorMetaData
    {
        [Display(Name = "Tác Giả")]
        [MaxLength(50, ErrorMessage = "Họ và Tên chỉ có thể chứa 50 kí tự")]
        public string Name { get; set; }

        [Display(Name = "Giới Thiệu")]
        [DataType(DataType.MultilineText)]
        public string Introduce { get; set; }
    }

    [MetadataType(typeof(PublisherMetaData))]
    public partial class Publisher
    {

    }
    public class PublisherMetaData
    {
        [Display(Name = "Nhà Xuất Bản")]
        [MaxLength(50, ErrorMessage = "Tên Nhà Xuất Bản chỉ có thể chứa 50 kí tự")]
        public string Name { get; set; }

        [Display(Name = "Giới Thiệu")]
        [DataType(DataType.MultilineText)]
        public string Introduce { get; set; }

        [Display(Name = "Địa Chỉ")]
        public string Address { get; set; }

        [Display(Name = "Số Điện Thoại")]
        [MaxLength(50, ErrorMessage = "SĐT chỉ có thể chứa 10 kí tự")]
        [DataType(DataType.PhoneNumber)]
        public string Phone { get; set; }
    }



    [MetadataType(typeof(ItemMetaData))]
    public partial class Item
    {

    }
    public class ItemMetaData
    {
        [Display(Name = "Vật Phẩm")]
        public string Name { get; set; }

        [Display(Name = "Ngày Xuất Bản")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> PublishDate { get; set; }
        public int AuthorId { get; set; }

        [Display(Name = "Số Lượng")]
        public int Quantity { get; set; }
        [Display(Name = "Giá Thành")]
        public decimal Price { get; set; }
        [Display(Name = "Giới Thiệu")]
        [DataType(DataType.MultilineText)]
        public string Introduce { get; set; }
        [Display(Name = "Hình Ảnh")]
        public string ImagePath { get; set; }
    }

    [MetadataType(typeof(NewsMetaData))]
    public partial class News
    {

    }
    public class NewsMetaData
    {
        [Display(Name = "Nội Dung")]
        [DataType(DataType.MultilineText)]
        public string Content { get; set; }

        [Display(Name = "Ngày Tạo")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> Date { get; set; }

        [Display(Name = "Trạng Thái")]
        public bool isPublic { get; set; }
    }

    [MetadataType(typeof(DiscussMetaData))]
    public partial class Discuss
    {

    }
    public class DiscussMetaData
    {
        [Display(Name = "Tên Thảo Luận")]
        [DataType(DataType.MultilineText)]
        public string Name { get; set; }

        [Display(Name = "Ngày Tạo")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> StartDate { get; set; }

        [Display(Name = "Giới Thiệu")]
        [DataType(DataType.MultilineText)]
        public string Introduce { get; set; }


    }

    [MetadataType(typeof(PaidBillMetaData))]
    public partial class PaidBill
    {

    }
    public partial class PaidBillMetaData
    {
        public int BillId { get; set; }

        [Display(Name = "Ngày Tạo")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public System.DateTime Date { get; set; }


        public int StatusId { get; set; }
        public int PublisherId { get; set; }

        [Display(Name = "Giá Cả")]
        public Nullable<decimal> Price { get; set; }
        public virtual Publisher Publisher { get; set; }
    }
}