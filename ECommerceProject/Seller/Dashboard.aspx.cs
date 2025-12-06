using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ECommerceProject.Seller
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

            // Seller rolü kontrolü
            if (Session["RoleName"].ToString() != "Seller")
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
                int sellerID = Convert.ToInt32(Session["UserID"]);

                // Toplam ürün sayısı
                string queryTotal = "SELECT COUNT(*) FROM Products WHERE SellerID = @SellerID";
                SqlParameter[] paramsTotal = new SqlParameter[]
                {
                    new SqlParameter("@SellerID", sellerID)
                };
                object totalCount = DBHelper.ExecuteScalar(queryTotal, paramsTotal);
                lblTotalProducts.Text = totalCount != null ? totalCount.ToString() : "0";

                // Aktif ürün sayısı
                string queryActive = "SELECT COUNT(*) FROM Products WHERE SellerID = @SellerID AND IsActive = 1";
                SqlParameter[] paramsActive = new SqlParameter[]
                {
                    new SqlParameter("@SellerID", sellerID)
                };
                object activeCount = DBHelper.ExecuteScalar(queryActive, paramsActive);
                lblActiveProducts.Text = activeCount != null ? activeCount.ToString() : "0";

                // Toplam stok
                string queryStock = "SELECT ISNULL(SUM(Stock), 0) FROM Products WHERE SellerID = @SellerID AND IsActive = 1";
                SqlParameter[] paramsStock = new SqlParameter[]
                {
                    new SqlParameter("@SellerID", sellerID)
                };
                object stockCount = DBHelper.ExecuteScalar(queryStock, paramsStock);
                lblTotalStock.Text = stockCount != null ? stockCount.ToString() : "0";
            }
            catch (Exception ex)
            {
                lblTotalProducts.Text = "0";
                lblActiveProducts.Text = "0";
                lblTotalStock.Text = "0";
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