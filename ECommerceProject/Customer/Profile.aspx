<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="ECommerceProject.Customer.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profilim - E-Ticaret</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
        }
        
        .navbar {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar h1 {
            font-size: 24px;
        }
        
        .navbar .nav-links {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s;
            background: rgba(255,255,255,0.1);
        }
        
        .navbar a:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .profile-header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 30px;
        }
        
        .profile-avatar {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            flex-shrink: 0;
        }
        
        .profile-info h2 {
            color: #333;
            margin-bottom: 5px;
        }
        
        .profile-info p {
            color: #666;
        }
        
        .content-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
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
        
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #4facfe;
        }
        
        .form-group input[readonly] {
            background: #f5f5f5;
            cursor: not-allowed;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: #4facfe;
            color: white;
        }
        
        .btn-primary:hover {
            background: #3b9bde;
        }
        
        .message {
            padding: 12px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>👤 Profilim</h1>
            <div class="nav-links">
                <a href="../Default.aspx">🏠 Ana Sayfa</a>
                <a href="Products.aspx">🛍️ Ürünler</a>
                <a href="Cart.aspx">🛒 Sepetim</a>
                <a href="Orders.aspx">📦 Siparişlerim</a>
                <a href="Profile.aspx">👤 Profilim</a>
            </div>
        </div>
        
        <div class="container">
            <div class="profile-header">
                <div class="profile-avatar">👤</div>
                <div class="profile-info">
                    <h2><asp:Label ID="lblFullName" runat="server"></asp:Label></h2>
                    <p><asp:Label ID="lblEmail" runat="server"></asp:Label></p>
                </div>
            </div>
            
            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <!-- Profil Bilgileri -->
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">Kişisel Bilgiler</h2>
                
                <div class="form-group">
                    <label>Kullanıcı Adı</label>
                    <asp:TextBox ID="txtUsername" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
                
                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
                
                <div class="form-group">
                    <label>Ad Soyad *</label>
                    <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                        ControlToValidate="txtFullName" 
                        ErrorMessage="Ad soyad gerekli" 
                        ForeColor="Red" 
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>
                
                <div class="form-group">
                    <label>Telefon</label>
                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                </div>
                
                <div class="form-group">
                    <label>Adres *</label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" 
                        ControlToValidate="txtAddress" 
                        ErrorMessage="Adres gerekli (sipariş için)" 
                        ForeColor="Red" 
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>
                
                <asp:Button ID="btnSave" runat="server" Text="Bilgileri Güncelle" CssClass="btn btn-primary" OnClick="btnSave_Click" />
            </div>
            
            <!-- Şifre Değiştir -->
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">Şifre Değiştir</h2>
                
                <div class="form-group">
                    <label>Yeni Şifre</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                </div>
                
                <div class="form-group">
                    <label>Yeni Şifre (Tekrar)</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:CompareValidator ID="cvPassword" runat="server" 
                        ControlToValidate="txtConfirmPassword" 
                        ControlToCompare="txtNewPassword" 
                        ErrorMessage="Şifreler eşleşmiyor" 
                        ForeColor="Red" 
                        Display="Dynamic">
                    </asp:CompareValidator>
                </div>
                
                <asp:Button ID="btnChangePassword" runat="server" Text="Şifreyi Değiştir" CssClass="btn btn-primary" OnClick="btnChangePassword_Click" CausesValidation="false" />
            </div>
        </div>
    </form>
</body>
</html>