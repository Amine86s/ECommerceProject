using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceProject.Admin
{
    public partial class Users : System.Web.UI.Page
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
                LoadRoles();
                LoadUsers();
            }
        }

        // Rolleri dropdown'a yükle
        private void LoadRoles()
        {
            try
            {
                string query = "SELECT RoleID, RoleName FROM Roles";
                DataTable dt = DBHelper.ExecuteQuery(query);

                ddlRole.DataSource = dt;
                ddlRole.DataTextField = "RoleName";
                ddlRole.DataValueField = "RoleID";
                ddlRole.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Roller yüklenirken hata: " + ex.Message, false);
            }
        }

        // Kullanıcıları listele
        private void LoadUsers()
        {
            try
            {
                string query = @"SELECT u.UserID, u.Username, u.FullName, u.Email, u.Phone, 
                                r.RoleName, u.IsActive
                                FROM Users u
                                INNER JOIN Roles r ON u.RoleID = r.RoleID
                                WHERE u.IsActive = 1
                                ORDER BY u.CreatedDate DESC";

                DataTable dt = DBHelper.ExecuteQuery(query);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Kullanıcılar yüklenirken hata: " + ex.Message, false);
            }
        }

        // Kaydet butonu
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int userID = Convert.ToInt32(hfUserID.Value);

                if (userID == 0)
                {
                    // Yeni kullanıcı ekle
                    InsertUser();
                }
                else
                {
                    // Kullanıcı güncelle
                    UpdateUser(userID);
                }

                ClearForm();
                LoadUsers();
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, false);
            }
        }

        // Yeni kullanıcı ekle
        private void InsertUser()
        {
            string query = @"INSERT INTO Users (Username, Password, Email, FullName, Phone, Address, RoleID)
                            VALUES (@Username, @Password, @Email, @FullName, @Phone, @Address, @RoleID)";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Username", txtUsername.Text.Trim()),
                new SqlParameter("@Password", txtPassword.Text.Trim()),
                new SqlParameter("@Email", txtEmail.Text.Trim()),
                new SqlParameter("@FullName", txtFullName.Text.Trim()),
                new SqlParameter("@Phone", txtPhone.Text.Trim()),
                new SqlParameter("@Address", txtAddress.Text.Trim()),
                new SqlParameter("@RoleID", ddlRole.SelectedValue)
            };

            int result = DBHelper.ExecuteNonQuery(query, parameters);

            if (result > 0)
            {
                ShowMessage("Kullanıcı başarıyla eklendi!", true);
            }
            else
            {
                ShowMessage("Kullanıcı eklenirken hata oluştu!", false);
            }
        }

        // Kullanıcı güncelle
        private void UpdateUser(int userID)
        {
            string query = @"UPDATE Users 
                            SET Username = @Username, 
                                Password = @Password, 
                                Email = @Email, 
                                FullName = @FullName, 
                                Phone = @Phone, 
                                Address = @Address, 
                                RoleID = @RoleID
                            WHERE UserID = @UserID";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@UserID", userID),
                new SqlParameter("@Username", txtUsername.Text.Trim()),
                new SqlParameter("@Password", txtPassword.Text.Trim()),
                new SqlParameter("@Email", txtEmail.Text.Trim()),
                new SqlParameter("@FullName", txtFullName.Text.Trim()),
                new SqlParameter("@Phone", txtPhone.Text.Trim()),
                new SqlParameter("@Address", txtAddress.Text.Trim()),
                new SqlParameter("@RoleID", ddlRole.SelectedValue)
            };

            int result = DBHelper.ExecuteNonQuery(query, parameters);

            if (result > 0)
            {
                ShowMessage("Kullanıcı başarıyla güncellendi!", true);
            }
            else
            {
                ShowMessage("Kullanıcı güncellenirken hata oluştu!", false);
            }
        }

        // GridView komutları (Düzenle, Sil)
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int userID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditUser")
            {
                LoadUserForEdit(userID);
            }
            else if (e.CommandName == "DeleteUser")
            {
                DeleteUser(userID);
                LoadUsers();
            }
        }

        // Kullanıcıyı düzenleme için yükle
        private void LoadUserForEdit(int userID)
        {
            try
            {
                string query = "SELECT * FROM Users WHERE UserID = @UserID";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@UserID", userID)
                };

                DataTable dt = DBHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfUserID.Value = row["UserID"].ToString();
                    txtUsername.Text = row["Username"].ToString();
                    txtPassword.Text = row["Password"].ToString();
                    txtFullName.Text = row["FullName"].ToString();
                    txtEmail.Text = row["Email"].ToString();
                    txtPhone.Text = row["Phone"].ToString();
                    txtAddress.Text = row["Address"].ToString();
                    ddlRole.SelectedValue = row["RoleID"].ToString();

                    lblFormTitle.Text = "Kullanıcı Düzenle";
                    btnSave.Text = "Güncelle";
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Kullanıcı yüklenirken hata: " + ex.Message, false);
            }
        }

        // Kullanıcı sil (soft delete)
        private void DeleteUser(int userID)
        {
            try
            {
                string query = "UPDATE Users SET IsActive = 0 WHERE UserID = @UserID";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@UserID", userID)
                };

                int result = DBHelper.ExecuteNonQuery(query, parameters);

                if (result > 0)
                {
                    ShowMessage("Kullanıcı başarıyla silindi!", true);
                }
                else
                {
                    ShowMessage("Kullanıcı silinirken hata oluştu!", false);
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
            hfUserID.Value = "0";
            txtUsername.Text = "";
            txtPassword.Text = "";
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
            ddlRole.SelectedIndex = 0;

            lblFormTitle.Text = "Yeni Kullanıcı Ekle";
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

        // Rol badge class'ı döndür (GridView için)
        protected string GetRoleBadgeClass(string roleName)
        {
            switch (roleName.ToLower())
            {
                case "admin":
                    return "admin";
                case "seller":
                    return "seller";
                case "customer":
                    return "customer";
                default:
                    return "customer";
            }
        }
    }
}