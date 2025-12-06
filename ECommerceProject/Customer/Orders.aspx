<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="ECommerceProject.Customer.Orders" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Siparişlerim - E-Ticaret</title>
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
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .content-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .gridview {
            width: 100%;
            border-collapse: collapse;
        }
        
        .gridview th {
            background: #4facfe;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 500;
        }
        
        .gridview td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .gridview tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-shipped {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .status-delivered {
            background: #d4edda;
            color: #155724;
        }
        
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        
        .empty-orders {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-orders .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>📦 Siparişlerim</h1>
            <div class="nav-links">
                <a href="Products.aspx">🏠 Ürünler</a>
                <a href="Cart.aspx">🛒 Sepetim</a>
                <a href="Orders.aspx">📦 Siparişlerim</a>
            </div>
        </div>
        
        <div class="container">
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">Sipariş Geçmişim</h2>
                
                <asp:Panel ID="pnlEmptyOrders" runat="server" Visible="false" CssClass="empty-orders">
                    <div class="icon">📦</div>
                    <h3>Henüz Siparişiniz Yok</h3>
                    <p>Sipariş vermek için <a href="Products.aspx">buraya tıklayın</a></p>
                </asp:Panel>
                
                <asp:Panel ID="pnlOrders" runat="server">
                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="gridview">
                        <Columns>
                            <asp:BoundField DataField="OrderID" HeaderText="Sipariş No" />
                            <asp:TemplateField HeaderText="Tarih">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("OrderDate")).ToString("dd.MM.yyyy HH:mm") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Toplam Tutar">
                                <ItemTemplate>
                                    <strong>₺<%# String.Format("{0:N2}", Eval("TotalAmount")) %></strong>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Durum">
                                <ItemTemplate>
                                    <span class='status-badge status-<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                        <%# GetStatusText(Eval("Status").ToString()) %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ShippingAddress" HeaderText="Teslimat Adresi" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
        </div>
    </form>
</body>
</html>