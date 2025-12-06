using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceProject.Admin
{
    public partial class Categories : System.Web.UI.Page
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
                LoadCategories();
            }
        }

        // Kategorileri listele
        private void LoadCategories()
        {
            try
            {
                string query = @"SELECT CategoryID, CategoryName, Description, IsActive
                                FROM Categories
                                WHERE IsActive = 1
                                ORDER BY CategoryName";

                DataTable dt = DBHelper.ExecuteQuery(query);
                gvCategories.DataSource = dt;
                gvCategories.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Kategoriler yüklenirken hata: " + ex.Message, false);
            }
        }

        // Kaydet butonu
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int categoryID = Convert.ToInt32(hfCategoryID.Value);

                if (categoryID == 0)
                {
                    // Yeni kategori ekle
                    InsertCategory();
                }
                else
                {
                    // Kategori güncelle
                    UpdateCategory(categoryID);
                }

                ClearForm();
                LoadCategories();
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, false);
            }
        }

        // Yeni kategori ekle
        private void InsertCategory()
        {
            string query = @"INSERT INTO Categories (CategoryName, Description)
                            VALUES (@CategoryName, @Description)";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CategoryName", txtCategoryName.Text.Trim()),
                new SqlParameter("@Description", txtDescription.Text.Trim())
            };

            int result = DBHelper.ExecuteNonQuery(query, parameters);

            if (result > 0)
            {
                ShowMessage("Kategori başarıyla eklendi!", true);
            }
            else
            {
                ShowMessage("Kategori eklenirken hata oluştu!", false);
            }
        }

        // Kategori güncelle
        private void UpdateCategory(int categoryID)
        {
            string query = @"UPDATE Categories 
                            SET CategoryName = @CategoryName, 
                                Description = @Description
                            WHERE CategoryID = @CategoryID";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CategoryID", categoryID),
                new SqlParameter("@CategoryName", txtCategoryName.Text.Trim()),
                new SqlParameter("@Description", txtDescription.Text.Trim())
            };

            int result = DBHelper.ExecuteNonQuery(query, parameters);

            if (result > 0)
            {
                ShowMessage("Kategori başarıyla güncellendi!", true);
            }
            else
            {
                ShowMessage("Kategori güncellenirken hata oluştu!", false);
            }
        }

        // GridView komutları (Düzenle, Sil)
        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int categoryID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditCategory")
            {
                LoadCategoryForEdit(categoryID);
            }
            else if (e.CommandName == "DeleteCategory")
            {
                DeleteCategory(categoryID);
                LoadCategories();
            }
        }

        // Kategoriyi düzenleme için yükle
        private void LoadCategoryForEdit(int categoryID)
        {
            try
            {
                string query = "SELECT * FROM Categories WHERE CategoryID = @CategoryID";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@CategoryID", categoryID)
                };

                DataTable dt = DBHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfCategoryID.Value = row["CategoryID"].ToString();
                    txtCategoryName.Text = row["CategoryName"].ToString();
                    txtDescription.Text = row["Description"].ToString();

                    lblFormTitle.Text = "Kategori Düzenle";
                    btnSave.Text = "Güncelle";
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Kategori yüklenirken hata: " + ex.Message, false);
            }
        }

        // Kategori sil (soft delete)
        private void DeleteCategory(int categoryID)
        {
            try
            {
                string query = "UPDATE Categories SET IsActive = 0 WHERE CategoryID = @CategoryID";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@CategoryID", categoryID)
                };

                int result = DBHelper.ExecuteNonQuery(query, parameters);

                if (result > 0)
                {
                    ShowMessage("Kategori başarıyla silindi!", true);
                }
                else
                {
                    ShowMessage("Kategori silinirken hata oluştu!", false);
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
            hfCategoryID.Value = "0";
            txtCategoryName.Text = "";
            txtDescription.Text = "";

            lblFormTitle.Text = "Yeni Kategori Ekle";
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