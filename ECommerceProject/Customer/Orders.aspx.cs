using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ECommerceProject.Customer
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Customer kontrolü
            if (Session["UserID"] == null || Session["RoleName"].ToString() != "Customer")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        // Siparişleri yükle
        private void LoadOrders()
        {
            try
            {
                int customerID = Convert.ToInt32(Session["UserID"]);

                string query = @"SELECT 
                                    OrderID,
                                    OrderDate,
                                    TotalAmount,
                                    Status,
                                    ShippingAddress
                                FROM Orders
                                WHERE CustomerID = @CustomerID
                                ORDER BY OrderDate DESC";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@CustomerID", customerID)
                };

                DataTable dt = DBHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    pnlEmptyOrders.Visible = false;
                    pnlOrders.Visible = true;

                    gvOrders.DataSource = dt;
                    gvOrders.DataBind();
                }
                else
                {
                    pnlEmptyOrders.Visible = true;
                    pnlOrders.Visible = false;
                }
            }
            catch (Exception ex)
            {
                // Hata durumunda boş göster
                pnlEmptyOrders.Visible = true;
                pnlOrders.Visible = false;
            }
        }

        // Durum CSS class'ı döndür
        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "pending":
                    return "pending";
                case "shipped":
                    return "shipped";
                case "delivered":
                    return "delivered";
                case "cancelled":
                    return "cancelled";
                default:
                    return "pending";
            }
        }

        // Durum metnini Türkçe'ye çevir
        protected string GetStatusText(string status)
        {
            switch (status.ToLower())
            {
                case "pending":
                    return "Hazırlanıyor";
                case "shipped":
                    return "Kargoda";
                case "delivered":
                    return "Teslim Edildi";
                case "cancelled":
                    return "İptal Edildi";
                default:
                    return status;
            }
        }
    }
}