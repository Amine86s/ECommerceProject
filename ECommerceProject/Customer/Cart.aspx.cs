using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceProject.Customer
{
    public partial class Cart : System.Web.UI.Page
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
                LoadCart();
            }
        }

        // Sepeti yükle
        private void LoadCart()
        {
            try
            {
                int customerID = Convert.ToInt32(Session["UserID"]);

                string query = @"SELECT 
                                    c.CartID,
                                    c.ProductID,
                                    p.ProductName,
                                    p.Price,
                                    c.Quantity
                                FROM Cart c
                                INNER JOIN Products p ON c.ProductID = p.ProductID
                                WHERE c.CustomerID = @CustomerID
                                ORDER BY c.AddedDate DESC";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@CustomerID", customerID)
                };

                DataTable dt = DBHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    pnlEmptyCart.Visible = false;
                    pnlCartItems.Visible = true;

                    gvCart.DataSource = dt;
                    gvCart.DataBind();

                    // Toplam tutarı hesapla
                    decimal totalAmount = 0;
                    foreach (DataRow row in dt.Rows)
                    {
                        decimal price = Convert.ToDecimal(row["Price"]);
                        int quantity = Convert.ToInt32(row["Quantity"]);
                        totalAmount += price * quantity;
                    }
                    lblTotalAmount.Text = totalAmount.ToString("N2");
                }
                else
                {
                    pnlEmptyCart.Visible = true;
                    pnlCartItems.Visible = false;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Sepet yüklenirken hata: " + ex.Message, false);
            }
        }

        // Sepetten ürün çıkar
        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RemoveItem")
            {
                try
                {
                    int cartID = Convert.ToInt32(e.CommandArgument);

                    string query = "DELETE FROM Cart WHERE CartID = @CartID";
                    SqlParameter[] parameters = new SqlParameter[]
                    {
                        new SqlParameter("@CartID", cartID)
                    };

                    int result = DBHelper.ExecuteNonQuery(query, parameters);

                    if (result > 0)
                    {
                        ShowMessage("Ürün sepetten çıkarıldı.", true);
                        LoadCart();
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Hata: " + ex.Message, false);
                }
            }
        }

        // Siparişi tamamla
        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            try
            {
                int customerID = Convert.ToInt32(Session["UserID"]);
                decimal totalAmount = Convert.ToDecimal(lblTotalAmount.Text);

                // Kullanıcının adresini veritabanından al
                string addressQuery = "SELECT Address FROM Users WHERE UserID = @UserID";
                SqlParameter[] addressParams = new SqlParameter[]
                {
                    new SqlParameter("@UserID", customerID)
                };
                DataTable addressDt = DBHelper.ExecuteQuery(addressQuery, addressParams);

                string shippingAddress = "Adres belirtilmedi";
                if (addressDt.Rows.Count > 0 && !string.IsNullOrWhiteSpace(addressDt.Rows[0]["Address"].ToString()))
                {
                    shippingAddress = addressDt.Rows[0]["Address"].ToString();
                }
                else
                {
                    ShowMessage("Lütfen önce profilinizden adresinizi güncelleyin!", false);
                    Response.AddHeader("REFRESH", "2;URL=Profile.aspx");
                    return;
                }

                // Stored procedure ile sipariş oluştur
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@CustomerID", customerID),
                    new SqlParameter("@TotalAmount", totalAmount),
                    new SqlParameter("@ShippingAddress", shippingAddress)
                };

                DataTable dt = DBHelper.ExecuteStoredProcedure("sp_CreateOrder", parameters);

                if (dt.Rows.Count > 0)
                {
                    int orderID = Convert.ToInt32(dt.Rows[0]["OrderID"]);
                    ShowMessage("✓ Siparişiniz başarıyla oluşturuldu! Sipariş No: " + orderID, true);

                    // 2 saniye sonra siparişler sayfasına yönlendir
                    Response.AddHeader("REFRESH", "2;URL=Orders.aspx");
                }
                else
                {
                    ShowMessage("Sipariş oluşturulurken hata oluştu!", false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, false);
            }
        }

        // Mesaj göster
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            pnlMessage.Visible = true;
            pnlMessage.CssClass = isSuccess ? "message success" : "message error";
        }
    }
}