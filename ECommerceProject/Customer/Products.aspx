<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="ECommerceProject.Customer.Products" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ürünler - E-Ticaret</title>
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
            color: #4facfe;
        }
        
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .welcome-box {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .welcome-box h2 {
            color: #333;
        }
        
        .message {
            padding: 12px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
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
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        
        .product-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 64px;
        }
        
        .product-info {
            padding: 20px;
        }
        
        .product-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .product-category {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }
        
        .product-price {
            font-size: 24px;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 10px;
        }
        
        .product-stock {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
        }
        
        .btn-add-cart {
            width: 100%;
            padding: 12px;
            background: #4facfe;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-add-cart:hover {
            background: #3b9bde;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>🛒 E-Ticaret</h1>
            <div class="nav-links">
                <span>Hoş geldin, <strong><asp:Label ID="lblFullName" runat="server"></asp:Label></strong></span>
                <a href="Products.aspx">🏠 Ürünler</a>
                <a href="Cart.aspx">🛒 Sepetim</a>
                <a href="Orders.aspx">📦 Siparişlerim</a>
                <asp:Button ID="btnLogout" runat="server" Text="Çıkış" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>
        
        <div class="container">
            <div class="welcome-box">
                <h2>Tüm Ürünler</h2>
                <p style="color: #666;">İstediğiniz ürünleri sepete ekleyip sipariş verebilirsiniz</p>
            </div>
            
            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <div class="products-grid">
                <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                    <ItemTemplate>
                        <div class="product-card">
                            <div class="product-image">📱</div>
                            <div class="product-info">
                                <div class="product-name"><%# Eval("ProductName") %></div>
                                <div class="product-category">📁 <%# Eval("CategoryName") %></div>
                                <div class="product-price">₺<%# String.Format("{0:N2}", Eval("Price")) %></div>
                                <div class="product-stock">Stok: <%# Eval("Stock") %> adet</div>
                                <asp:Button ID="btnAddToCart" runat="server" 
                                    Text="Sepete Ekle" 
                                    CssClass="btn-add-cart"
                                    CommandName="AddToCart"
                                    CommandArgument='<%# Eval("ProductID") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>