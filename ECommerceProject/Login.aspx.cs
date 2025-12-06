using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ECommerceProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Eğer kullanıcı zaten giriş yapmışsa, ana sayfaya yönlendir
                if (Session["UserID"] != null)
                {
                    RedirectUserByRole();
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Stored procedure ile kullanıcı kontrolü
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Username", username),
                    new SqlParameter("@Password", password)
                };

                DataTable dt = DBHelper.ExecuteStoredProcedure("sp_UserLogin", parameters);

                if (dt.Rows.Count > 0)
                {
                    // Giriş başarılı - Session'a kullanıcı bilgilerini kaydet
                    DataRow user = dt.Rows[0];

                    Session["UserID"] = user["UserID"];
                    Session["Username"] = user["Username"];
                    Session["FullName"] = user["FullName"];
                    Session["Email"] = user["Email"];
                    Session["RoleName"] = user["RoleName"];
                    Session["RoleID"] = user["RoleID"];

                    // Role göre yönlendirme
                    RedirectUserByRole();
                }
                else
                {
                    // Giriş başarısız
                    ShowMessage("Kullanıcı adı veya şifre hatalı!", false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, false);
            }
        }

        // Kullanıcıyı rolüne göre ilgili sayfaya yönlendir
        private void RedirectUserByRole()
        {
            if (Session["RoleName"] != null)
            {
                string role = Session["RoleName"].ToString();

                switch (role)
                {
                    case "Admin":
                        Response.Redirect("~/Admin/Dashboard.aspx");
                        break;
                    case "Seller":
                        Response.Redirect("~/Seller/Dashboard.aspx");
                        break;
                    case "Customer":
                        Response.Redirect("~/Customer/Products.aspx");
                        break;
                    default:
                        Response.Redirect("~/Login.aspx");
                        break;
                }
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