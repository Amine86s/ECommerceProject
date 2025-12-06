<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllProducts.aspx.cs" Inherits="ECommerceProject.Admin.AllProducts" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tüm Ürünler - Admin</title>
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
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .btn-back {
            background: rgba(255,255,255,0.2);
            color: white;
            border: 1px solid white;
        }
        
        .btn-back:hover {
            background: white;
            color: #667eea;
        }
        
        .container {
            max-width: 1400px;
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
            background: #667eea;
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
        
        .price {
            font-weight: bold;
            color: #28a745;
        }
        
        .stock {
            padding: 4px 8px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .stock-ok {
            background: #d4edda;
            color: #155724;
        }
        
        .stock-low {
            background: #fff3cd;
            color: #856404;
        }
        
        .stock-out {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>📦 Tüm Ürünler</h1>
            <asp:Button ID="btnBack" runat="server" Text="← Dashboard" CssClass="btn btn-back" OnClick="btnBack_Click" />
        </div>
        
        <div class="container">
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">Sistemdeki Tüm Ürünler</h2>
                
                <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="gridview">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="ID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Ürün Adı" />
                        <asp:BoundField DataField="CategoryName" HeaderText="Kategori" />
                        <asp:BoundField DataField="SellerName" HeaderText="Satıcı" />
                        <asp:TemplateField HeaderText="Fiyat">
                            <ItemTemplate>
                                <span class="price">₺<%# String.Format("{0:N2}", Eval("Price")) %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Stok Durumu">
                            <ItemTemplate>
                                <span class='stock <%# GetStockClass(Eval("Stock")) %>'>
                                    <%# Eval("Stock") %> adet
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>