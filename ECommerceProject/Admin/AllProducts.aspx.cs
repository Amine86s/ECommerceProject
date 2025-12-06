using System;
using System.Data;
using System.Web.UI;

namespace ECommerceProject.Admin
{
    public partial class AllProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Admin kontrolü
            if (Session["UserID"] == null || Session["RoleName"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        // Tüm ürünleri listele
        private void LoadProducts()
        {
            try
            {
                string query = @"SELECT 
                                    p.ProductID,
                                    p.ProductName,
                                    p.Price,
                                    p.Stock,
                                    c.CategoryName,
                                    u.FullName AS SellerName
                                FROM Products p
                                INNER JOIN Categories c ON p.CategoryID = c.CategoryID
                                INNER JOIN Users u ON p.SellerID = u.UserID
                                WHERE p.IsActive = 1
                                ORDER BY p.CreatedDate DESC";

                DataTable dt = DBHelper.ExecuteQuery(query);
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
            catch (Exception ex)
            {
                // Hata durumunda boş göster
            }
        }

        // Dashboard'a dön
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        // Stok durumuna göre CSS class döndür
        protected string GetStockClass(object stock)
        {
            int stockCount = Convert.ToInt32(stock);

            if (stockCount == 0)
                return "stock-out";
            else if (stockCount < 10)
                return "stock-low";
            else
                return "stock-ok";
        }
    }
}