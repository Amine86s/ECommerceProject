using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceProject.Customer
{
    public partial class Products : System.Web.UI.Page
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
                LoadUserInfo();
                LoadProducts();
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

        // Ürünleri listele
        private void LoadProducts()
        {
            try
            {
                DataTable dt = DBHelper.ExecuteStoredProcedure("sp_GetActiveProducts");
                rptProducts.DataSource = dt;
                rptProducts.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Ürünler yüklenirken hata: " + ex.Message, false);
            }
        }

        // Sepete ekle
        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                try
                {
                    int customerID = Convert.ToInt32(Session["UserID"]);
                    int productID = Convert.ToInt32(e.CommandArgument);

                    // Ürün zaten sepette mi kontrol et
                    string checkQuery = @"SELECT CartID, Quantity FROM Cart 
                                         WHERE CustomerID = @CustomerID AND ProductID = @ProductID";

                    SqlParameter[] checkParams = new SqlParameter[]
                    {
                        new SqlParameter("@CustomerID", customerID),
                        new SqlParameter("@ProductID", productID)
                    };

                    DataTable dt = DBHelper.ExecuteQuery(checkQuery, checkParams);

                    if (dt.Rows.Count > 0)
                    {
                        // Ürün zaten sepette, miktarı artır
                        int cartID = Convert.ToInt32(dt.Rows[0]["CartID"]);
                        int currentQuantity = Convert.ToInt32(dt.Rows[0]["Quantity"]);

                        string updateQuery = "UPDATE Cart SET Quantity = @Quantity WHERE CartID = @CartID";
                        SqlParameter[] updateParams = new SqlParameter[]
                        {
                            new SqlParameter("@Quantity", currentQuantity + 1),
                            new SqlParameter("@CartID", cartID)
                        };

                        DBHelper.ExecuteNonQuery(updateQuery, updateParams);
                    }
                    else
                    {
                        // Yeni ürün ekle
                        string insertQuery = @"INSERT INTO Cart (CustomerID, ProductID, Quantity)
                                              VALUES (@CustomerID, @ProductID, 1)";

                        SqlParameter[] insertParams = new SqlParameter[]
                        {
                            new SqlParameter("@CustomerID", customerID),
                            new SqlParameter("@ProductID", productID)
                        };

                        DBHelper.ExecuteNonQuery(insertQuery, insertParams);
                    }

                    ShowMessage("Ürün sepete eklendi!", true);
                }
                catch (Exception ex)
                {
                    ShowMessage("Hata: " + ex.Message, false);
                }
            }
        }

        // Çıkış yap
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
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