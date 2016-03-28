<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="TimeHub2.stylesheets.Search" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>Search</title>
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="content/bootstrap.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
    <link href="stylesheets/styles.css" rel="stylesheet">
    <script src="scripts/jquery-1.11.2.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function ShowPopup(message) {
            $(function () {
                $("#dialog").html(message);
                $("#dialog").dialog({
                    title: "jQuery Dialog Popup",
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
    <form id="search" runat="server">
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
                <div hidden="true">
                    <asp:Label runat="server" ID="lblUserLoggedIn"></asp:Label>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="userprofile.aspx">Profile</a></li>
                        <li><a href="cardmgr.aspx">Help</a></li>
                        <li>
                            <asp:LinkButton runat="server" ID="lbtn_logout" Text="log out" OnClick="btnLogOutClick"></asp:LinkButton></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row row-offcanvas row-offcanvas-left">

                <div class="col-sm-3 col-md-2 sidebar-offcanvas" id="sidebar" role="navigation">

                    <ul class="nav nav-sidebar">
                        <li><a href="UserHome.aspx">Home</a></li>
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
                    <h1 class="page-header">search</h1>
                    <div>
                        <label id="lblCardNumber" for="tbCardNumber">Card number</label>
                        <asp:TextBox runat="server" ID="tbCardNumber"></asp:TextBox>
                        <Label ID="lblUsername" for="tbUsername">Username</Label>
                        <asp:TextBox runat="server" ID="tbUsername"></asp:TextBox>
                        <label id="lblUserStar" for="tbUserStar">User Star</label>
                        <asp:TextBox runat="server" ID="tbUserStar"></asp:TextBox>
                        <Label ID="lblAssignment" for="ddlAssignment">Assignment</Label>
                        <asp:DropDownList runat="server" ID="ddlAssignment" Enabled="true"></asp:DropDownList>
                        <Label ID="lblRequestType" for="cdlRequestType">Request Type</Label>
                        <asp:CheckBoxList runat="server" ID="cblRequestType" RepeatDirection="Horizontal"></asp:CheckBoxList>
                        <Label ID="lblBeginningDate" for="tbBeginningDate">Date</Label>
                        <asp:TextBox runat="server" ID="tbBeginningDate" type="date"></asp:TextBox>
                        <Label>Date-range</Label>
                        <Label id="lblDateRangeBegin" for="tbDateRangeBegin">From</Label>
                        <asp:TextBox runat="server" ID="tbDateRangeBegin" type="date"></asp:TextBox>
                        <label id="lblDateRangeEnd" for="tbDateRangeEnd">To</label>
                        <asp:TextBox runat="server" ID="tbDateRangeEnd" type="date"></asp:TextBox>
                        <Label ID="lblAccountNumber" for="tbAccountNumber">Account Number</Label>
                        <asp:TextBox runat="server" ID="tbAccountNumber"></asp:TextBox>
                        <label ID="lblCaseNumber" for="tbCaseNumber">CaseNumber</label>
                        <asp:textbox runat="server" ID="tbCaseNumber"></asp:textbox>
                        <div id="OTSubTypes">
                            <label for="cblOTCode">ot code no.</label>
                            <asp:CheckBoxList runat="server" ID="cblOTCode" RepeatDirection="Horizontal"></asp:CheckBoxList>
                        </div>
                        <div id="COSubTypes">
                            <label for="cblCourtSession">Court Session</label>
                            <asp:CheckBoxList runat="server" ID="cblCourtSession" RepeatDirection="Horizontal"></asp:CheckBoxList>
                            <label for="cblCourtType">Court Type</label>
                            <asp:CheckBoxList runat="server" ID="cblCourtType" RepeatDirection="Horizontal"></asp:CheckBoxList>
                            <label for="cblAppearanceType">Appearance Type</label>
                            <asp:CheckBoxList runat="server" ID="cblAppearanceType" RepeatDirection="Horizontal"></asp:CheckBoxList>
                        </div>
                        <div id="TRSubTypes ">
                            <label for="cblTrainingCode">Training Code</label>
                            <asp:CheckBoxList runat="server" ID="cblTrainingCode" RepeatDirection="Horizontal"></asp:CheckBoxList>
                        </div>
                        <div>
                            <asp:Button runat="server" ID="btnSearch" Text="search" OnClick="btnSearchClick" />
                            <asp:Button runat="server" ID="btnClearFields" Text="clear fields"/>
                        </div>
                        <div class="table-responsive">
                            <asp:GridView runat="server" class="table table-striped table-hover" ID="gvSearchResults" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:TemplateField HeaderText="Card ID">
                                    <ItemTemplate>
                                        <a href="<%#Eval("RequestType") %>Request.aspx?id=<%#Eval("card_number") %>"><%#Eval("RequestType") %><%#Eval("card_number") %></a>
                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                    <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                    <asp:BoundField DataField="RequestType" HeaderText="Card Type" />
                                    <asp:BoundField DataField="beginning_date" HeaderText="Date" />
                                    <asp:BoundField DataField="status_id" HeaderText="Status" />
                                </Columns>
                                <RowStyle CssClass="cursor-pointer" />
                            </asp:GridView>
                        </div>
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

    <!-- script references -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>

</body>
</html>
