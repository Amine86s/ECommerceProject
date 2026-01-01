<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ECommerceProject.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ElektroMarket - Elektronik Cihaz Satış</title>
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
        
        /* Header */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 28px;
            font-weight: bold;
        }
        
        .nav-menu {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .nav-menu a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            transition: all 0.3s;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .nav-menu a:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .user-section {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .btn-login {
            background: rgba(255,255,255,0.2);
            color: white;
            border: 2px solid white;
            padding: 10px 25px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-login:hover {
            background: white;
            color: #667eea;
        }
        
        .welcome-text {
            font-size: 14px;
        }
        
        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 20px;
            text-align: center;
        }
        
        .hero h1 {
            font-size: 48px;
            margin-bottom: 15px;
        }
        
        .hero p {
            font-size: 20px;
            opacity: 0.9;
        }
        
        /* Container */
        .container {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        /* Filter Section */
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .filter-section label {
            font-weight: 600;
            color: #333;
        }
        
        .filter-section select {
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }
        
        .btn-filter {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
        }
        
        /* Products Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }
        
        .product-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: all 0.3s;
            cursor: pointer;
        }
        
        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .product-image {
            width: 100%;
            height: 220px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 72px;
            position: relative;
            overflow: hidden;
        }
        
        .product-image::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 30% 30%, rgba(255,255,255,0.2) 0%, transparent 50%);
        }
        
        .product-info {
            padding: 20px;
        }
        
        .product-category {
            font-size: 12px;
            color: #667eea;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 8px;
        }
        
        .product-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            min-height: 44px;
        }
        
        .product-description {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .product-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #e0e0e0;
        }
        
        .product-price {
            font-size: 28px;
            font-weight: bold;
            color: #28a745;
        }
        
        .product-stock {
            font-size: 12px;
            color: #666;
        }
        
        .btn-add-cart {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 15px;
        }
        
        .btn-add-cart:hover {
            background: #5568d3;
            transform: scale(1.02);
        }
        
        /* Message */
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
        
        /* Footer */
        .footer {
            background: #2d3748;
            color: white;
            padding: 40px 20px;
            margin-top: 60px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <div class="header">
            <div class="header-content">
                <div class="logo">🛒 ElektroMarket</div>
                <div class="nav-menu">
                    <a href="Default.aspx">🏠 Ana Sayfa</a>
                    
                    <asp:Panel ID="pnlGuest" runat="server">
                        <a href="Login.aspx" class="btn-login">Giriş Yap / Kayıt Ol</a>
                    </asp:Panel>
                    
                    <asp:Panel ID="pnlLoggedIn" runat="server" Visible="false">
                        <div class="user-section">
                            <span class="welcome-text">Hoş geldin, <strong><asp:Label ID="lblUserName" runat="server"></asp:Label></strong></span>
                            
                            <asp:Panel ID="pnlCustomerLinks" runat="server" Visible="false">
                                <a href="Customer/Cart.aspx">🛒 Sepetim</a>
                                <a href="Customer/Orders.aspx">📦 Siparişlerim</a>
                            </asp:Panel>
                            
                            <asp:Panel ID="pnlSellerLinks" runat="server" Visible="false">
                                <a href="Seller/Dashboard.aspx">🏪 Satıcı Paneli</a>
                            </asp:Panel>
                            
                            <asp:Panel ID="pnlAdminLinks" runat="server" Visible="false">
                                <a href="Admin/Dashboard.aspx">⚙️ Admin Paneli</a>
                            </asp:Panel>
                            
                            <asp:Button ID="btnLogout" runat="server" Text="Çıkış" CssClass="btn-login" OnClick="btnLogout_Click" />
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        
        <!-- Hero Section -->
        <div class="hero">
            <h1>En Yeni Elektronik Ürünler</h1>
            <p>Kaliteli ve uygun fiyatlı elektronik cihazlar için doğru yerdesiniz</p>
        </div>
        
        <!-- Main Content -->
        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <!-- Filter Section -->
            <div class="filter-section">
                <label>Kategori:</label>
                <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                    <asp:ListItem Value="0" Text="Tüm Kategoriler" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <!-- Products Grid -->
            <div class="products-grid">
                <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                    <ItemTemplate>
                        <div class="product-card">
                            <div class="product-image" style='<%# GetProductGradient(Eval("CategoryName").ToString()) %>'>
                                <%# GetProductIcon(Eval("CategoryName").ToString()) %>
                            </div>
                            <div class="product-info">
                                <div class="product-category"><%# Eval("CategoryName") %></div>
                                <div class="product-name"><%# Eval("ProductName") %></div>
                                <div class="product-description"><%# Eval("Description") %></div>
                                <div class="product-footer">
                                    <div>
                                        <div class="product-price">₺<%# String.Format("{0:N2}", Eval("Price")) %></div>
                                        <div class="product-stock">Stok: <%# Eval("Stock") %> adet</div>
                                    </div>
                                </div>
                                <asp:Button ID="btnAddToCart" runat="server" 
                                    Text="🛒 Sepete Ekle" 
                                    CssClass="btn-add-cart"
                                    CommandName="AddToCart"
                                    CommandArgument='<%# Eval("ProductID") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        
        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2025 ElektroMarket - Tüm hakları saklıdır</p>
            <p>Elektronik cihaz satış platformu</p>
        </div>
    </form>
</body>
</html>