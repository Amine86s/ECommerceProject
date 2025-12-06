<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="ECommerceProject.Admin.Users" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Kullanıcı Yönetimi - Admin</title>
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
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5568d3;
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
        
        .page-header {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .form-group input:focus,
        .form-group select:focus {
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
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
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
        
        .badge {
            padding: 4px 8px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .badge-admin {
            background: #667eea;
            color: white;
        }
        
        .badge-seller {
            background: #ffc107;
            color: #333;
        }
        
        .badge-customer {
            background: #28a745;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>👥 Kullanıcı Yönetimi</h1>
            <asp:Button ID="btnBack" runat="server" Text="← Dashboard" CssClass="btn btn-back" OnClick="btnBack_Click" />
        </div>
        
        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <!-- Kullanıcı Ekleme/Düzenleme Formu -->
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">
                    <asp:Label ID="lblFormTitle" runat="server" Text="Yeni Kullanıcı Ekle"></asp:Label>
                </h2>
                
                <div class="form-section">
                    <div class="form-group">
                        <label>Kullanıcı Adı *</label>
                        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                            ControlToValidate="txtUsername" 
                            ErrorMessage="Kullanıcı adı gerekli" 
                            ForeColor="Red" 
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label>Şifre *</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                            ControlToValidate="txtPassword" 
                            ErrorMessage="Şifre gerekli" 
                            ForeColor="Red" 
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
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
                        <label>Email *</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                            ControlToValidate="txtEmail" 
                            ErrorMessage="Email gerekli" 
                            ForeColor="Red" 
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label>Telefon</label>
                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label>Rol *</label>
                        <asp:DropDownList ID="ddlRole" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Adres</label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
                
                <div style="margin-top: 20px;">
                    <asp:Button ID="btnSave" runat="server" Text="Kaydet" CssClass="btn btn-success" OnClick="btnSave_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Temizle" CssClass="btn btn-warning" OnClick="btnClear_Click" CausesValidation="false" />
                    <asp:HiddenField ID="hfUserID" runat="server" Value="0" />
                </div>
            </div>
            
            <!-- Kullanıcı Listesi -->
            <div class="content-box">
                <h2 style="margin-bottom: 20px;">Kullanıcı Listesi</h2>
                
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                    CssClass="gridview" 
                    OnRowCommand="gvUsers_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="ID" />
                        <asp:BoundField DataField="Username" HeaderText="Kullanıcı Adı" />
                        <asp:BoundField DataField="FullName" HeaderText="Ad Soyad" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Phone" HeaderText="Telefon" />
                        <asp:TemplateField HeaderText="Rol">
                            <ItemTemplate>
                                <span class='badge badge-<%# GetRoleBadgeClass(Eval("RoleName").ToString()) %>'>
                                    <%# Eval("RoleName") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="İşlemler">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" Text="Düzenle" 
                                    CommandName="EditUser" 
                                    CommandArgument='<%# Eval("UserID") %>' 
                                    CssClass="btn btn-primary" 
                                    CausesValidation="false" />
                                <asp:Button ID="btnDelete" runat="server" Text="Sil" 
                                    CommandName="DeleteUser" 
                                    CommandArgument='<%# Eval("UserID") %>' 
                                    CssClass="btn btn-danger" 
                                    OnClientClick="return confirm('Bu kullanıcıyı silmek istediğinize emin misiniz?');" 
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