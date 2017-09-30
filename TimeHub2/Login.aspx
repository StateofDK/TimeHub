<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TimeHub2.Login" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TimeHub | SFPD | Login</title>

    <!-- Bootstrap -->
    <link href="Vendors/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" />

    <!-- Custom Theme Style -->
    <link href="Vendors/custom.css" rel="stylesheet" />
</head>

<body style="background: #F7F7F7;">
    <div class="">
        <a class="hiddenanchor" id="toregister"></a>
        <a class="hiddenanchor" id="tologin"></a>

        <div id="wrapper">
            <div id="login" class="form">
                <div class="login_content">
                    <form runat="server">
                        <h1>Login to TimeHub</h1>
                        <div>
                            <asp:TextBox runat="server" ID="tbUsername" Class="form-control" placeholder="Username" required=""></asp:TextBox>
                        </div>
                        <div>
                            <asp:TextBox runat="server" type="password" ID="tbPassword" class="form-control" placeholder="Password" required=""></asp:TextBox>
                        </div>
                        <div>
                            <asp:Button runat="server" class="btn btn-default btn-lg submit" Text="Log in" OnClick="Login_Click" />
                        </div>
                        <div>
                            <p class="change_link">
                                New to site?
                                <a href="RegisterUser.aspx" class="to_register">Create Account </a>
                            </p>
                            <a class="change_link" href="#">Lost your password?</a>
                        </div>
                        <div class="clearfix"></div>
                        <div class="separator">
                            <div class="clearfix"></div>
                            <br>
                            <div>
                                <h1><i class="fa fa-clock-o" style="font-size: 26px;"></i>TimeHub</h1>

                                <p>©2015 Hubs Development.</p>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
