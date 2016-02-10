<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterUser.aspx.cs" Inherits="TimeHub2.RegisterUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>timehub - register</title>
    <script src="scripts/jquery-1.11.2.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-theme.css" rel="stylesheet" />
    <link href="Content/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="stylesheets/register.css">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />
    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>--%>
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
                $(".ui-dialog-titlebar").hide();
            });
        };
    </script>
</head>
<body>
    <div class="container text-center">
        <form class="form text-center" id="registerUser" runat="server">
            <div id="dialog" style="display: none"></div>
            <h2 class="form-heading">register new user</h2>
            <asp:TextBox runat="server" class="form-control" ID="tbUsername" placeholder="username"></asp:TextBox>
            <asp:TextBox runat="server" class="form-control" ID="tbPassword" TextMode="Password" placeholder="password"></asp:TextBox>
            <asp:TextBox runat="server" class="form-control" ID="tbConfirmPassword" TextMode="Password" placeholder="confirm password"></asp:TextBox>
            <asp:Button runat="server" class="btn btn-lg btn-primary btn-block" ID="btnSubmit" OnClick="SubmitClick" Text="Register"  />
            <asp:LinkButton runat="server" class="text-center" id="lbtnReset" text="clear fields"></asp:LinkButton>
            <br />
            <a href="Login.aspx" class="text-center">Login</a>
        </form>
    </div>
</body>
</html>