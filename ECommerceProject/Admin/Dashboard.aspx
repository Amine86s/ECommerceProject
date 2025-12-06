<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ECommerceProject.Admin.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - E-Ticaret</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            color: #667eea;
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
            border-left: 4px solid #667eea;
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
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .menu-card {
            background: white;
            padding: 30px;
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
            font-size: 48px;
            margin-bottom: 15px;
        }
        
        .menu-card h3 {
            color: #333;
            margin-bottom: 5px;
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
            <h1>🛒 Admin Panel</h1>
            <div class="user-info">
                <span>Hoş geldin, <strong><asp:Label ID="lblFullName" runat="server"></asp:Label></strong></span>
                <asp:Button ID="btnLogout" runat="server" Text="Çıkış Yap" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>
        
        <div class="container">
            <div class="welcome-box">
                <h2>Admin Dashboard</h2>
                <p>Sistem yönetim paneline hoş geldiniz. Kullanıcılar, ürünler ve kategorileri yönetebilirsiniz.</p>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <h3>Toplam Kullanıcı</h3>
                    <div class="number">
                        <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
                
                <div class="stat-card">
                    <h3>Toplam Ürün</h3>
                    <div class="number">
                        <asp:Label ID="lblTotalProducts" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
                
                <div class="stat-card">
                    <h3>Toplam Kategori</h3>
                    <div class="number">
                        <asp:Label ID="lblTotalCategories" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
                
                <div class="stat-card">
                    <h3>Toplam Sipariş</h3>
                    <div class="number">
                        <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
            </div>
            
            <div class="menu-grid">
                <a href="Users.aspx" class="menu-card">
                    <div class="icon">👥</div>
                    <h3>Kullanıcı Yönetimi</h3>
                    <p>Kullanıcıları görüntüle, ekle, düzenle</p>
                </a>
                
                <a href="Categories.aspx" class="menu-card">
                    <div class="icon">📁</div>
                    <h3>Kategori Yönetimi</h3>
                    <p>Kategorileri yönet</p>
                </a>
                
                <a href="AllProducts.aspx" class="menu-card">
                    <div class="icon">📦</div>
                    <h3>Tüm Ürünler</h3>
                    <p>Sistemdeki tüm ürünleri gör</p>
                </a>
            </div>
        </div>
    </form>
</body>
</html>