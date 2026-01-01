using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceProject
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckUserSession();
                LoadCategories();
                LoadProducts();
            }
        }

        // Kullanıcı oturum kontrolü
        private void CheckUserSession()
        {
            if (Session["UserID"] != null)
            {
                // Kullanıcı giriş yapmış
                pnlGuest.Visible = false;
                pnlLoggedIn.Visible = true;
                lblUserName.Text = Session["FullName"].ToString();

                // Role göre menü göster
                string role = Session["RoleName"].ToString();

                if (role == "Customer")
                {
                    pnlCustomerLinks.Visible = true;
                }
                else if (role == "Seller")
                {
                    pnlSellerLinks.Visible = true;
                }
                else if (role == "Admin")
                {
                    pnlAdminLinks.Visible = true;
                }
            }
            else
            {
                // Misafir kullanıcı
                pnlGuest.Visible = true;
                pnlLoggedIn.Visible = false;
            }
        }

        // Kategorileri yükle
        private void LoadCategories()
        {
            try
            {
                string query = "SELECT CategoryID, CategoryName FROM Categories WHERE IsActive = 1 ORDER BY CategoryName";
                DataTable dt = DBHelper.ExecuteQuery(query);

                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();

                // "Tüm Kategoriler" seçeneğini başa ekle
                ddlCategory.Items.Insert(0, new ListItem("Tüm Kategoriler", "0"));
            }
            catch (Exception ex)
            {
                // Hata durumunda sessiz geç
            }
        }

        // Ürünleri yükle
        private void LoadProducts()
        {
            try
            {
                int categoryID = Convert.ToInt32(ddlCategory.SelectedValue);
                string query;
                SqlParameter[] parameters = null;

                if (categoryID == 0)
                {
                    // Tüm ürünleri getir
                    query = @"SELECT 
                                p.ProductID, 
                                p.ProductName, 
                                p.Description, 
                                p.Price, 
                                p.Stock,
                                c.CategoryName,
                                u.FullName AS SellerName,
                                p.ImageURL
                            FROM Products p
                            INNER JOIN Categories c ON p.CategoryID = c.CategoryID
                            INNER JOIN Users u ON p.SellerID = u.UserID
                            WHERE p.IsActive = 1 AND p.Stock > 0
                            ORDER BY p.CreatedDate DESC";

                    DataTable dt = DBHelper.ExecuteQuery(query);
                    rptProducts.DataSource = dt;
                    rptProducts.DataBind();
                }
                else
                {
                    // Kategoriye göre filtrele
                    query = @"SELECT 
                                p.ProductID, 
                                p.ProductName, 
                                p.Description, 
                                p.Price, 
                                p.Stock,
                                c.CategoryName,
                                u.FullName AS SellerName,
                                p.ImageURL
                            FROM Products p
                            INNER JOIN Categories c ON p.CategoryID = c.CategoryID
                            INNER JOIN Users u ON p.SellerID = u.UserID
                            WHERE p.CategoryID = @CategoryID 
                              AND p.IsActive = 1 
                              AND p.Stock > 0
                            ORDER BY p.ProductName";

                    parameters = new SqlParameter[]
                    {
                        new SqlParameter("@CategoryID", categoryID)
                    };

                    DataTable dt = DBHelper.ExecuteQuery(query, parameters);
                    rptProducts.DataSource = dt;
                    rptProducts.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Ürünler yüklenirken hata oluştu: " + ex.Message, false);
            }
        }

        // Kategori değiştiğinde
        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProducts();
        }

        // Sepete ekle
        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                // Kullanıcı giriş yapmış mı kontrol et
                if (Session["UserID"] == null)
                {
                    // Giriş yapmamış - Login sayfasına yönlendir
                    ShowMessage("Sepete ürün eklemek için lütfen giriş yapın.", false);
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Sadece Customer rolü sepete ekleyebilir
                if (Session["RoleName"].ToString() != "Customer")
                {
                    ShowMessage("Sepete ürün eklemek için müşteri hesabı ile giriş yapmalısınız.", false);
                    return;
                }

                try
                {
                    int customerID = Convert.ToInt32(Session["UserID"]);
                    int productID = Convert.ToInt32(e.CommandArgument);

                    // Ürün stok kontrolü
                    string stockQuery = "SELECT Stock FROM Products WHERE ProductID = @ProductID";
                    SqlParameter[] stockParams = new SqlParameter[]
                    {
                        new SqlParameter("@ProductID", productID)
                    };
                    DataTable stockDt = DBHelper.ExecuteQuery(stockQuery, stockParams);

                    if (stockDt.Rows.Count > 0)
                    {
                        int stock = Convert.ToInt32(stockDt.Rows[0]["Stock"]);
                        if (stock <= 0)
                        {
                            ShowMessage("Bu ürün stokta yok!", false);
                            return;
                        }
                    }

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

                    ShowMessage("✓ Ürün sepete eklendi!", true);
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
            Response.Redirect("Default.aspx");
        }

        // Mesaj göster
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            pnlMessage.Visible = true;
            pnlMessage.CssClass = isSuccess ? "message success" : "message error";
        }

        // Kategoriye göre ürün ikonu döndür
        protected string GetProductIcon(string categoryName)
        {
            switch (categoryName.ToLower())
            {
                case "akilli telefonlar":
                    return "📱";
                case "laptop & bilgisayar":
                    return "💻";
                case "televizyon":
                    return "📺";
                case "ses sistemleri":
                    return "🎧";
                case "kamera":
                    return "📷";
                default:
                    return "📦";
            }
        }

        // Kategoriye göre gradient renk döndür
        protected string GetProductGradient(string categoryName)
        {
            switch (categoryName.ToLower())
            {
                case "akilli telefonlar":
                    return "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);";
                case "laptop & bilgisayar":
                    return "background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);";
                case "televizyon":
                    return "background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);";
                case "ses sistemleri":
                    return "background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);";
                case "kamera":
                    return "background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);";
                default:
                    return "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);";
            }
        }
    }
}