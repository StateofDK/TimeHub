<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="TimeHub2.WebForm7" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>Dashboard</title>
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="content/bootstrap.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
    <link href="stylesheets/styles.css" rel="stylesheet">
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
    <form id="userHome" runat="server">
        <div id="dialog" style="display: none"></div>
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">TimeHub - SFPD</a>
                </div>
                <div hidden="false">
                    <asp:Label runat="server" ID="lblUserLoggedIn"></asp:Label>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="userprofile.aspx">Profile</a></li>
                        <li><a href="cardmgr.aspx">Help</a></li>
                        <li>
                            <asp:LinkButton runat="server" ID="lbtn_logout" Text="log out" OnClick="lbtn_logout_Click"></asp:LinkButton></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid">

            <div class="row row-offcanvas row-offcanvas-left">

                <div class="col-sm-3 col-md-2 sidebar-offcanvas" id="sidebar" role="navigation">

                    <ul class="nav nav-sidebar">
                        <li class="active"><a href="UserHome.aspx">Home</a></li>
                        <li><a href="cardmgr.aspx">Card Manager</a></li>
                        <li><a href="approvalmgr.aspx">Approval manager</a></li>
                        <li><a href="Search.aspx">Search</a></li>
                    </ul>
                </div>
                <!--/span-->

                <div class="col-sm-9 col-md-10 main">

                    <!--toggle sidebar button-->
                    <p class="visible-xs">
                        <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas"><i class="glyphicon glyphicon-chevron-left"></i></button>
                    </p>

                    <h1 class="page-header">Dashboard</h1>

                    <div class="row placeholders">
                        <div class="col-xs-12 col-sm-3 placeholder text-center">
                            <img src="//placehold.it/200/6666ff/fff" class="center-block img-responsive img-circle" alt="Generic placeholder thumbnail">
                            <asp:Button runat="server" class="cardButton" ID="Button1" href="OTRequest.aspx" Text="new overtime card" OnClick="RedirectOTCard" />
                            <h4>new ovetime card</h4>
                        </div>
                        <div class="col-xs-12 col-sm-3 placeholder text-center">
                            <img src="//placehold.it/200/66ff66/fff" class="center-block img-responsive img-circle" alt="Generic placeholder thumbnail">
                            <asp:Button runat="server" class="cardButton" ID="Button2" href="CORequest.aspx" Text="new court card" OnClick="RedirectCourtCard" />
                            <h4>new court card</h4>
                        </div>
                        <div class="col-xs-12 col-sm-3 placeholder text-center">
                            <img src="//placehold.it/200/6666ff/fff" class="center-block img-responsive img-circle" alt="Generic placeholder thumbnail">
                            <asp:Button runat="server" class="cardButton" ID="Button3" href="TORequest.aspx" Text="new time off card" OnClick="RedirectTimeOffCard" />
                            <h4>new time-off card</h4>
                        </div>
                        <div class="col-xs-12 col-sm-3 placeholder text-center">
                            <img src="//placehold.it/200/66ff66/fff" class="center-block img-responsive img-circle" alt="Generic placeholder thumbnail">
                            <asp:Button runat="server" class="cardButton" ID="Button4" href="TRRequest.aspx" Text="new training card" OnClick="RedirectTrainingCard" />
                            <h4>new training card</h4>
                        </div>
                        <div class="col-xs-12 col-sm-3 placeholder text-center">
                            <img src="//placehold.it/200/6666ff/fff" class="center-block img-responsive img-circle" alt="Generic placeholder thumbnail">
                            <asp:Button runat="server" class="cardButton" ID="Button5" href="EPRequest.aspx" Text="new equal pay card" OnClick="RedirectEqualPayCard" />
                            <h4>new equal pay card</h4>
                        </div>
                    </div>

                    <hr>

                    <h2 class="sub-header">your recent requests</h2>
                    <div class="table-responsive">
                        <asp:GridView runat="server" class="table table-striped table-hover" ID="gvRecentRequests" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                            <Columns>
                                <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                <asp:BoundField DataField="RequestType" HeaderText="Card Type" />
                                <asp:BoundField DataField="beginning_date" HeaderText="Date" DataFormatString="{0:MM-dd-yyyy}" />
                                <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                <asp:BoundField DataField="total_time" HeaderText="hours" />
                                <asp:BoundField DataField="status_id" HeaderText="Status" />
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        edit
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <a href="<%#Eval("RequestType") %>Request.aspx?id=<%#Eval("card_number") %>">edit/view</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="cursor-pointer" />
                        </asp:GridView>
                    </div>
                </div>
                <!--/row-->
            </div>
        </div>
        <!--/.container-->

        <footer>
            <p class="pull-right">©2015 Hubz Development</p>
        </footer>
    </form>
</body>
</html>
