<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="ECommerceProject.Seller.Products" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ürün Yönetimi - Satıcı</title>
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
            color: #f5576c;
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
            margin-bottom: 20px;
        }
        
        .form-section {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #f5576c;
        }
        
        .btn-success {
            background: #28a745;
            color: white;
        }
        
        .btn-success:hover {
            background: #218838;
        }
        
        .btn-warning {
            background: #ffc107;
            color: #333;
            margin-left: 10px;
        }
        
        .btn-primary {
            background: #f5576c;
            color: white;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
            margin-left: 5px;
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
            background: #f5576c;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>📦 Ürün Yönetimi</h1>
            <asp:Button ID="btnBack" runat="server" Text="← Dashboard" CssClass="btn btn-back" OnClick="btnBack_Click" />
        </div>
        
        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <!-- Ürün Ekleme/Düzenleme Formu -->
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">
                    <asp:Label ID="lblFormTitle" runat="server" Text="Yeni Ürün Ekle"></asp:Label>
                </h2>
                
                <div class="form-section">
                    <div class="form-group">
                        <label>Ürün Adı *</label>
                        <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server" 
                            ControlToValidate="txtProductName" 
                            ErrorMessage="Ürün adı gerekli" 
                            ForeColor="Red" 
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label>Kategori *</label>
                        <asp:DropDownList ID="ddlCategory" runat="server">
                        </asp:DropDownList>
                    </div>
                    
                    <div class="form-group">
                        <label>Fiyat (₺) *</label>
                        <asp:TextBox ID="txtPrice" runat="server" TextMode="Number" step="0.01"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server" 
                            ControlToValidate="txtPrice" 
                            ErrorMessage="Fiyat gerekli" 
                            ForeColor="Red" 
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label>Stok Miktarı *</label>
                        <asp:TextBox ID="txtStock" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvStock" runat="server" 
                            ControlToValidate="txtStock" 
                            ErrorMessage="Stok miktarı gerekli" 
                            ForeColor="Red" 
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Açıklama</label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
                
                <div class="form-group">
                    <label>Görsel URL</label>
                    <asp:TextBox ID="txtImageURL" runat="server"></asp:TextBox>
                </div>
                
                <div style="margin-top: 20px;">
                    <asp:Button ID="btnSave" runat="server" Text="Kaydet" CssClass="btn btn-success" OnClick="btnSave_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Temizle" CssClass="btn btn-warning" OnClick="btnClear_Click" CausesValidation="false" />
                    <asp:HiddenField ID="hfProductID" runat="server" Value="0" />
                </div>
            </div>
            
            <!-- Ürün Listesi -->
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">Ürünlerim</h2>
                
                <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
                    CssClass="gridview" 
                    OnRowCommand="gvProducts_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="ID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Ürün Adı" />
                        <asp:BoundField DataField="CategoryName" HeaderText="Kategori" />
                        <asp:TemplateField HeaderText="Fiyat">
                            <ItemTemplate>
                                <span class="price">₺<%# String.Format("{0:N2}", Eval("Price")) %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Stock" HeaderText="Stok" />
                        <asp:TemplateField HeaderText="İşlemler">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" Text="Düzenle" 
                                    CommandName="EditProduct" 
                                    CommandArgument='<%# Eval("ProductID") %>' 
                                    CssClass="btn btn-primary" 
                                    CausesValidation="false" />
                                <asp:Button ID="btnDelete" runat="server" Text="Sil" 
                                    CommandName="DeleteProduct" 
                                    CommandArgument='<%# Eval("ProductID") %>' 
                                    CssClass="btn btn-danger" 
                                    OnClientClick="return confirm('Bu ürünü silmek istediğinize emin misiniz?');" 
                                    CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>