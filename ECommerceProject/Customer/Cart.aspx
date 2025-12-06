<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ECommerceProject.Customer.Cart" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sepetim - E-Ticaret</title>
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
            margin-bottom: 20px;
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
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
        
        .total-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
            text-align: right;
        }
        
        .total-price {
            font-size: 28px;
            font-weight: bold;
            color: #28a745;
            margin: 10px 0;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .btn-success {
            background: #28a745;
            color: white;
        }
        
        .btn-success:hover {
            background: #218838;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-cart .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>🛒 Sepetim</h1>
            <div class="nav-links">
                <a href="Products.aspx">🏠 Ürünler</a>
                <a href="Cart.aspx">🛒 Sepetim</a>
                <a href="Orders.aspx">📦 Siparişlerim</a>
            </div>
        </div>
        
        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">Alışveriş Sepetim</h2>
                
                <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="empty-cart">
                    <div class="icon">🛒</div>
                    <h3>Sepetiniz Boş</h3>
                    <p>Ürün eklemek için <a href="Products.aspx">buraya tıklayın</a></p>
                </asp:Panel>
                
                <asp:Panel ID="pnlCartItems" runat="server">
                    <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" 
                        CssClass="gridview" 
                        OnRowCommand="gvCart_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="ProductName" HeaderText="Ürün Adı" />
                            <asp:TemplateField HeaderText="Fiyat">
                                <ItemTemplate>
                                    ₺<%# String.Format("{0:N2}", Eval("Price")) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Quantity" HeaderText="Adet" />
                            <asp:TemplateField HeaderText="Toplam">
                                <ItemTemplate>
                                    <strong>₺<%# String.Format("{0:N2}", Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %></strong>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="İşlem">
                                <ItemTemplate>
                                    <asp:Button ID="btnRemove" runat="server" Text="Sil" 
                                        CommandName="RemoveItem" 
                                        CommandArgument='<%# Eval("CartID") %>' 
                                        CssClass="btn btn-danger" 
                                        OnClientClick="return confirm('Bu ürünü sepetten çıkarmak istediğinize emin misiniz?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    
                    <div class="total-section">
                        <h3>Toplam Tutar:</h3>
                        <div class="total-price">
                            ₺<asp:Label ID="lblTotalAmount" runat="server" Text="0.00"></asp:Label>
                        </div>
                        <asp:Button ID="btnCheckout" runat="server" Text="Siparişi Tamamla" 
                            CssClass="btn btn-success" 
                            OnClick="btnCheckout_Click" />
                    </div>
                </asp:Panel>
            </div>
        </div>
    </form>
</body>
</html>