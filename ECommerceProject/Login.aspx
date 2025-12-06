<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ECommerceProject.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Giriş Yap - E-Ticaret</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            width: 400px;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .login-header p {
            color: #666;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
        }
        
        .message {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .message.error {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }
        
        .message.success {
            background: #efe;
            color: #3c3;
            border: 1px solid #cfc;
        }
        
        .test-accounts {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }
        
        .test-accounts h3 {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }
        
        .test-accounts p {
            font-size: 12px;
            color: #888;
            line-height: 1.6;
        }
        
        .test-accounts strong {
            color: #667eea;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-header">
                <h1>🛒 E-Ticaret</h1>
                <p>Elektronik cihaz satış platformu</p>
            </div>
            
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message error">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <div class="form-group">
                <label for="txtUsername">Kullanıcı Adı</label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Kullanıcı adınızı girin"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                    ControlToValidate="txtUsername" 
                    ErrorMessage="Kullanıcı adı gerekli" 
                    ForeColor="Red" 
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtPassword">Şifre</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Şifrenizi girin"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Şifre gerekli" 
                    ForeColor="Red" 
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>
            
            <asp:Button ID="btnLogin" runat="server" Text="Giriş Yap" CssClass="btn-login" OnClick="btnLogin_Click" />
            
            <div class="test-accounts">
                <h3>Test Hesapları:</h3>
                <p>
                    <strong>Admin:</strong> admin / 123456<br />
                    <strong>Satıcı:</strong> seller1 / 123456<br />
                    <strong>Müşteri:</strong> customer1 / 123456
                </p>
            </div>
        </div>
    </form>
</body>
</html>