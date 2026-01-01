using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ECommerceProject.Customer
{
    public partial class Profile : System.Web.UI.Page
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
                LoadUserProfile();
            }
        }

        // Kullanıcı profilini yükle
        private void LoadUserProfile()
        {
            try
            {
                int userID = Convert.ToInt32(Session["UserID"]);

                string query = "SELECT * FROM Users WHERE UserID = @UserID";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@UserID", userID)
                };

                DataTable dt = DBHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    lblFullName.Text = row["FullName"].ToString();
                    lblEmail.Text = row["Email"].ToString();

                    txtUsername.Text = row["Username"].ToString();
                    txtEmail.Text = row["Email"].ToString();
                    txtFullName.Text = row["FullName"].ToString();
                    txtPhone.Text = row["Phone"].ToString();
                    txtAddress.Text = row["Address"].ToString();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Profil yüklenirken hata: " + ex.Message, false);
            }
        }

        // Profil bilgilerini güncelle
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int userID = Convert.ToInt32(Session["UserID"]);

                string query = @"UPDATE Users 
                                SET FullName = @FullName,
                                    Phone = @Phone,
                                    Address = @Address
                                WHERE UserID = @UserID";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@FullName", txtFullName.Text.Trim()),
                    new SqlParameter("@Phone", txtPhone.Text.Trim()),
                    new SqlParameter("@Address", txtAddress.Text.Trim())
                };

                int result = DBHelper.ExecuteNonQuery(query, parameters);

                if (result > 0)
                {
                    // Session'daki bilgileri güncelle
                    Session["FullName"] = txtFullName.Text.Trim();
                    Session["Address"] = txtAddress.Text.Trim();

                    ShowMessage("✓ Profiliniz başarıyla güncellendi!", true);
                    LoadUserProfile();
                }
                else
                {
                    ShowMessage("Profil güncellenirken hata oluştu!", false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, false);
            }
        }

        // Şifre değiştir
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            try
            {
                // Şifre alanları dolu mu kontrol et
                if (string.IsNullOrWhiteSpace(txtNewPassword.Text))
                {
                    ShowMessage("Lütfen yeni şifrenizi girin!", false);
                    return;
                }

                if (txtNewPassword.Text != txtConfirmPassword.Text)
                {
                    ShowMessage("Şifreler eşleşmiyor!", false);
                    return;
                }

                int userID = Convert.ToInt32(Session["UserID"]);

                string query = "UPDATE Users SET Password = @Password WHERE UserID = @UserID";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@Password", txtNewPassword.Text.Trim())
                };

                int result = DBHelper.ExecuteNonQuery(query, parameters);

                if (result > 0)
                {
                    ShowMessage("✓ Şifreniz başarıyla değiştirildi!", true);
                    txtNewPassword.Text = "";
                    txtConfirmPassword.Text = "";
                }
                else
                {
                    ShowMessage("Şifre değiştirilirken hata oluştu!", false);
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