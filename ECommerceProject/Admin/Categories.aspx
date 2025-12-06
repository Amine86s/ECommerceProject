<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="ECommerceProject.Admin.Categories" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Kategori Yönetimi - Admin</title>
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
            border-color: #667eea;
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
            background: #667eea;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>📁 Kategori Yönetimi</h1>
            <asp:Button ID="btnBack" runat="server" Text="← Dashboard" CssClass="btn btn-back" OnClick="btnBack_Click" />
        </div>
        
        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <!-- Kategori Ekleme/Düzenleme Formu -->
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">
                    <asp:Label ID="lblFormTitle" runat="server" Text="Yeni Kategori Ekle"></asp:Label>
                </h2>
                
                <div class="form-group">
                    <label>Kategori Adı *</label>
                    <asp:TextBox ID="txtCategoryName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" 
                        ControlToValidate="txtCategoryName" 
                        ErrorMessage="Kategori adı gerekli" 
                        ForeColor="Red" 
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>
                
                <div class="form-group">
                    <label>Açıklama</label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
                
                <div>
                    <asp:Button ID="btnSave" runat="server" Text="Kaydet" CssClass="btn btn-success" OnClick="btnSave_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Temizle" CssClass="btn btn-warning" OnClick="btnClear_Click" CausesValidation="false" />
                    <asp:HiddenField ID="hfCategoryID" runat="server" Value="0" />
                </div>
            </div>
            
            <!-- Kategori Listesi -->
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">Kategori Listesi</h2>
                
                <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" 
                    CssClass="gridview" 
                    OnRowCommand="gvCategories_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="CategoryID" HeaderText="ID" />
                        <asp:BoundField DataField="CategoryName" HeaderText="Kategori Adı" />
                        <asp:BoundField DataField="Description" HeaderText="Açıklama" />
                        <asp:TemplateField HeaderText="İşlemler">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" Text="Düzenle" 
                                    CommandName="EditCategory" 
                                    CommandArgument='<%# Eval("CategoryID") %>' 
                                    CssClass="btn btn-primary" 
                                    CausesValidation="false" />
                                <asp:Button ID="btnDelete" runat="server" Text="Sil" 
                                    CommandName="DeleteCategory" 
                                    CommandArgument='<%# Eval("CategoryID") %>' 
                                    CssClass="btn btn-danger" 
                                    OnClientClick="return confirm('Bu kategoriyi silmek istediğinize emin misiniz?');" 
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