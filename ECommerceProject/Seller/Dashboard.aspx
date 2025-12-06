<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ECommerceProject.Seller.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Satıcı Paneli - E-Ticaret</title>
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
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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
        
        .navbar .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .btn-logout {
            background: rgba(255,255,255,0.2);
            color: white;
            border: 1px solid white;
            padding: 8px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .btn-logout:hover {
            background: white;
            color: #f5576c;
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .welcome-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .welcome-box h2 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .welcome-box p {
            color: #666;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-left: 4px solid #f5576c;
        }
        
        .stat-card h3 {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .stat-card .number {
            font-size: 32px;
            font-weight: bold;
            color: #333;
        }
        
        .menu-card {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        
        .menu-card .icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        
        .menu-card h3 {
            color: #333;
            margin-bottom: 10px;
            font-size: 24px;
        }
        
        .menu-card p {
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>🏪 Satıcı Paneli</h1>
            <div class="user-info">
                <span>Hoş geldin, <strong><asp:Label ID="lblFullName" runat="server"></asp:Label></strong></span>
                <asp:Button ID="btnLogout" runat="server" Text="Çıkış Yap" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>
        
        <div class="container">
            <div class="welcome-box">
                <h2>Satıcı Dashboard</h2>
                <p>Ürünlerinizi buradan yönetebilirsiniz. Yeni ürün ekleyebilir, mevcut ürünlerinizi düzenleyebilirsiniz.</p>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <h3>Toplam Ürünüm</h3>
                    <div class="number">
                        <asp:Label ID="lblTotalProducts" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
                
                <div class="stat-card">
                    <h3>Aktif Ürün</h3>
                    <div class="number">
                        <asp:Label ID="lblActiveProducts" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
                
                <div class="stat-card">
                    <h3>Toplam Stok</h3>
                    <div class="number">
                        <asp:Label ID="lblTotalStock" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
            </div>
            
            <a href="Products.aspx" class="menu-card">
                <div class="icon">📦</div>
                <h3>Ürün Yönetimi</h3>
                <p>Ürünlerinizi ekleyin, düzenleyin ve yönetin</p>
            </a>
        </div>
    </form>
</body>
</html>
