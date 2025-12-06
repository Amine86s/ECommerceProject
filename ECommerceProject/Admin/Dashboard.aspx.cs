using System;
using System.Data;
using System.Web.UI;

namespace ECommerceProject.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kullanıcı giriş yapmış mı kontrol et
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // Admin rolü kontrolü
            if (Session["RoleName"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadStatistics();
            }
        }

        // Kullanıcı bilgilerini yükle
        private void LoadUserInfo()
        {
            if (Session["FullName"] != null)
            {
                lblFullName.Text = Session["FullName"].ToString();
            }
        }

        // İstatistikleri yükle
        private void LoadStatistics()
        {
            try
            {
                // Toplam kullanıcı sayısı
                string queryUsers = "SELECT COUNT(*) FROM Users WHERE IsActive = 1";
                object userCount = DBHelper.ExecuteScalar(queryUsers);
                lblTotalUsers.Text = userCount != null ? userCount.ToString() : "0";

                // Toplam ürün sayısı
                string queryProducts = "SELECT COUNT(*) FROM Products WHERE IsActive = 1";
                object productCount = DBHelper.ExecuteScalar(queryProducts);
                lblTotalProducts.Text = productCount != null ? productCount.ToString() : "0";

                // Toplam kategori sayısı
                string queryCategories = "SELECT COUNT(*) FROM Categories WHERE IsActive = 1";
                object categoryCount = DBHelper.ExecuteScalar(queryCategories);
                lblTotalCategories.Text = categoryCount != null ? categoryCount.ToString() : "0";

                // Toplam sipariş sayısı
                string queryOrders = "SELECT COUNT(*) FROM Orders";
                object orderCount = DBHelper.ExecuteScalar(queryOrders);
                lblTotalOrders.Text = orderCount != null ? orderCount.ToString() : "0";
            }
            catch (Exception ex)
            {
                // Hata durumunda sıfır göster
                lblTotalUsers.Text = "0";
                lblTotalProducts.Text = "0";
                lblTotalCategories.Text = "0";
                lblTotalOrders.Text = "0";
            }
        }

        // Çıkış yap
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}