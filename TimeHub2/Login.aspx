<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TimeHub2.WebForm6" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>timehub - login</title>
    <script src="scripts/jquery-1.11.2.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-theme.css" rel="stylesheet" />
    <link href="Content/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="stylesheets/login.css">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function ShowPopup(message) {
            $(function () {
                $("#dialog").html(message);
                $("#dialog").dialog({
                    title: '<%=PopupTitle%>',
                    buttons: {
                        Close: function () {
                            $(this).dialog('close');
                        }
                    },
                    modal: true
                });
            });
        };
    </script>
</head>
<body>
    <div class="container text-center">
        <form class="form-signin text-center" id="userLog" runat="server">
            <div id="dialog" style="display: none"></div>
            <h2 class="form-signin-heading">login to timeHub</h2>
            <asp:TextBox runat="server" Class="form-control" ID="tb_username" placeholder="username" autofocus></asp:TextBox>
            <asp:TextBox runat="server" class="form-control" ID="tb_password" TextMode="Password" placeholder="password"></asp:TextBox>
            <asp:Button class="btn btn-lg btn-primary btn-block" ID="submit" runat="server" Text="login" OnClick="Login_Click" />
            <div>
                <asp:LinkButton runat="server" class="pull-left" ID="lbtn_register" Text="register new user" OnClick="RegisterClick"></asp:LinkButton>
                <asp:LinkButton runat="server" class="pull-right" ID="lbtn_recovery" Text="forgot login?"></asp:LinkButton>
            </div>
        </form>
    </div>
</body>
</html>
