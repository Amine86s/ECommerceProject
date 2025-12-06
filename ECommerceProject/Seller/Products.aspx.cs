using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceProject.Seller
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Seller kontrolü
            if (Session["UserID"] == null || Session["RoleName"].ToString() != "Seller")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }
        }

        // Kategorileri dropdown'a yükle
        private void LoadCategories()
        {
            try
            {
                string query = "SELECT CategoryID, CategoryName FROM Categories WHERE IsActive = 1";
                DataTable dt = DBHelper.ExecuteQuery(query);

                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Kategoriler yüklenirken hata: " + ex.Message, false);
            }
        }

        // Satıcının ürünlerini listele
        private void LoadProducts()
        {
            try
            {
                int sellerID = Convert.ToInt32(Session["UserID"]);

                string query = @"SELECT 
                                    p.ProductID,
                                    p.ProductName,
                                    p.Price,
                                    p.Stock,
                                    c.CategoryName
                                FROM Products p
                                INNER JOIN Categories c ON p.CategoryID = c.CategoryID
                                WHERE p.SellerID = @SellerID AND p.IsActive = 1
                                ORDER BY p.CreatedDate DESC";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@SellerID", sellerID)
                };

                DataTable dt = DBHelper.ExecuteQuery(query, parameters);
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Ürünler yüklenirken hata: " + ex.Message, false);
            }
        }

        // Kaydet butonu
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int productID = Convert.ToInt32(hfProductID.Value);

                if (productID == 0)
                {
                    // Yeni ürün ekle
                    InsertProduct();
                }
                else
                {
                    // Ürün güncelle
                    UpdateProduct(productID);
                }

                ClearForm();
                LoadProducts();
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, false);
            }
        }

        // Yeni ürün ekle
        private void InsertProduct()
        {
            int sellerID = Convert.ToInt32(Session["UserID"]);

            string query = @"INSERT INTO Products (ProductName, Description, Price, Stock, CategoryID, SellerID, ImageURL)
                            VALUES (@ProductName, @Description, @Price, @Stock, @CategoryID, @SellerID, @ImageURL)";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@ProductName", txtProductName.Text.Trim()),
                new SqlParameter("@Description", txtDescription.Text.Trim()),
                new SqlParameter("@Price", Convert.ToDecimal(txtPrice.Text)),
                new SqlParameter("@Stock", Convert.ToInt32(txtStock.Text)),
                new SqlParameter("@CategoryID", ddlCategory.SelectedValue),
                new SqlParameter("@SellerID", sellerID),
                new SqlParameter("@ImageURL", txtImageURL.Text.Trim())
            };

            int result = DBHelper.ExecuteNonQuery(query, parameters);

            if (result > 0)
            {
                ShowMessage("Ürün başarıyla eklendi!", true);
            }
            else
            {
                ShowMessage("Ürün eklenirken hata oluştu!", false);
            }
        }

        // Ürün güncelle
        private void UpdateProduct(int productID)
        {
            string query = @"UPDATE Products 
                            SET ProductName = @ProductName,
                                Description = @Description,
                                Price = @Price,
                                Stock = @Stock,
                                CategoryID = @CategoryID,
                                ImageURL = @ImageURL
                            WHERE ProductID = @ProductID";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@ProductID", productID),
                new SqlParameter("@ProductName", txtProductName.Text.Trim()),
                new SqlParameter("@Description", txtDescription.Text.Trim()),
                new SqlParameter("@Price", Convert.ToDecimal(txtPrice.Text)),
                new SqlParameter("@Stock", Convert.ToInt32(txtStock.Text)),
                new SqlParameter("@CategoryID", ddlCategory.SelectedValue),
                new SqlParameter("@ImageURL", txtImageURL.Text.Trim())
            };

            int result = DBHelper.ExecuteNonQuery(query, parameters);

            if (result > 0)
            {
                ShowMessage("Ürün başarıyla güncellendi!", true);
            }
            else
            {
                ShowMessage("Ürün güncellenirken hata oluştu!", false);
            }
        }

        // GridView komutları
        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int productID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditProduct")
            {
                LoadProductForEdit(productID);
            }
            else if (e.CommandName == "DeleteProduct")
            {
                DeleteProduct(productID);
                LoadProducts();
            }
        }

        // Ürünü düzenleme için yükle
        private void LoadProductForEdit(int productID)
        {
            try
            {
                string query = "SELECT * FROM Products WHERE ProductID = @ProductID";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@ProductID", productID)
                };

                DataTable dt = DBHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfProductID.Value = row["ProductID"].ToString();
                    txtProductName.Text = row["ProductName"].ToString();
                    txtDescription.Text = row["Description"].ToString();
                    txtPrice.Text = row["Price"].ToString();
                    txtStock.Text = row["Stock"].ToString();
                    ddlCategory.SelectedValue = row["CategoryID"].ToString();
                    txtImageURL.Text = row["ImageURL"].ToString();

                    lblFormTitle.Text = "Ürün Düzenle";
                    btnSave.Text = "Güncelle";
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Ürün yüklenirken hata: " + ex.Message, false);
            }
        }

        // Ürün sil
        private void DeleteProduct(int productID)
        {
            try
            {
                string query = "UPDATE Products SET IsActive = 0 WHERE ProductID = @ProductID";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@ProductID", productID)
                };

                int result = DBHelper.ExecuteNonQuery(query, parameters);

                if (result > 0)
                {
                    ShowMessage("Ürün başarıyla silindi!", true);
                }
                else
                {
                    ShowMessage("Ürün silinirken hata oluştu!", false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, false);
            }
        }

        // Formu temizle
        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfProductID.Value = "0";
            txtProductName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtStock.Text = "";
            txtImageURL.Text = "";
            ddlCategory.SelectedIndex = 0;

            lblFormTitle.Text = "Yeni Ürün Ekle";
            btnSave.Text = "Kaydet";
        }

        // Dashboard'a dön
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
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