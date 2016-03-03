<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApprovalMgr.aspx.cs" Inherits="TimeHub2.ApprovalMgrTest" %>

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
    <script src="scripts/jquery-1.11.2.js"></script>
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
                $(".ui-dialog-titlebar").hide();
            });
        };

        $(function () {
            $("#tabs").tabs();
        });

        $('#beginningTime, #endingTime').blur(function () {
            var beginTime = $('#beginningTime').val();
            var endTime = $('#endingTime').val();
            var strBeginTime = beginTime.toString();
            var strEndTime = endTime.toString();

            var totalTime = $('#totalTime');
            var timeArray = [];

            for (var i = 0; i < strBeginTime.length; i += 2) {
                var strGroup = strBeginTime.charAt(i) + strBeginTime.charAt(i + 1);
                timeArray.push(strGroup);
            };

            for (var i = 0; i < strEndTime.length; i += 2) {
                var strGroup = strEndTime.charAt(i) + strEndTime.charAt(i + 1);
                timeArray.push(strGroup);
            };

            var beginTimeHours = parseInt(timeArray[0]);
            var beginTimeMinutes = parseInt(timeArray[1]) / 60;
            var endTimeHours = parseInt(timeArray[2]);
            var endTimeMinutes = parseInt(timeArray[3]) / 60;

            var totalTimeHours = endTimeHours - beginTimeHours;
            var totalTimeMinutes = endTimeMinutes - beginTimeMinutes;
            var calculatedTime = totalTimeHours + totalTimeMinutes;

            if (parseInt(calculatedTime) < 0) {
                calculatedTime = calculatedTime + 24;
            };

            totalTime.val(calculatedTime.toString());
        });
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
                            <asp:LinkButton runat="server" ID="lbtn_logout" Text="log out" OnClick="logOutClick"></asp:LinkButton></li>
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
                        <li class="active"><a href="approvalmgr.aspx">Approval manager</a></li>
                    </ul>
                </div>
                <!--/span-->

                <div class="col-sm-9 col-md-10 main">

                    <!--toggle sidebar button-->
                    <p class="visible-xs">
                        <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas"><i class="glyphicon glyphicon-chevron-left"></i></button>
                    </p>

                    <h1 class="page-header">Dashboard</h1>

                    <div class="cardmanagers" id="tabs">
                        <ul>
                            <li><a href="#tabs-1">Overtime</a></li>
                            <li><a href="#tabs-2">Court</a></li>
                            <li><a href="#tabs-3">Time-off</a></li>
                            <li><a href="#tabs-4">Training</a></li>
                            <li><a href="#tabs-5">Equal Pay</a></li>
                        </ul>
                        <div id="tabs-1">
                            <div style="height: 600px; overflow: auto;">
                                <asp:GridView runat="server" class="table table-striped table-hover" ID="gvPendingRequestsOT" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                    <Columns>
                                        <asp:BoundField DataField="submitted_by" HeaderText="submitted by" />
                                        <asp:BoundField DataField="date_submitted" HeaderText="date submitted" />
                                        <asp:BoundField DataField="card_number" HeaderText="card number" />
                                        <asp:BoundField DataField="beginning_date" HeaderText="date" />
                                        <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                        <asp:BoundField DataField="total_time" HeaderText="hours" />
                                        <asp:BoundField DataField="ot_code" HeaderText="OT Type" />
                                        <asp:BoundField DataField="status_id" HeaderText="status" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                edit
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <a href="OTRequest.aspx?id=<%#Eval("card_number") %>">edit</a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div id="tabs-2">
                            <div style="height: 600px; overflow: auto;">
                                <asp:GridView runat="server" class="table table-striped table-hover" ID="gvPendingRequestsCO" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                    <Columns>
                                        <asp:BoundField DataField="submitted_by" HeaderText="submitted by" />
                                        <asp:BoundField DataField="date_submitted" HeaderText="date submitted" />
                                        <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                        <asp:BoundField DataField="beginning_date" HeaderText="Date" />
                                        <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                        <asp:BoundField DataField="total_time" HeaderText="hours" />
                                        <asp:BoundField DataField="status_id" HeaderText="Status" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                edit
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <a href="CORequest.aspx?id=<%#Eval("card_number") %>">edit</a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div id="tabs-3">
                            <div style="height: 600px; overflow: auto;">
                                <asp:GridView runat="server" class="table table-striped table-hover" ID="gvPendingRequestsTO" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                    <Columns>
                                        <asp:BoundField DataField="submitted_by" HeaderText="submitted by" />
                                        <asp:BoundField DataField="date_submitted" HeaderText="date submitted" />
                                        <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                        <asp:BoundField DataField="beginning_date" HeaderText="Date" />
                                        <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                        <asp:BoundField DataField="total_time" HeaderText="hours" />
                                        <asp:BoundField DataField="time_used" HeaderText="Time Used" />
                                        <asp:BoundField DataField="status_id" HeaderText="Status" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                edit
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <a href="TORequest.aspx?id=<%#Eval("card_number") %>">edit</a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div id="tabs-4">
                            <div style="height: 600px; overflow: auto;">
                                <asp:GridView runat="server" class="table table-striped table-hover" ID="gvPendingRequestsTR" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                    <Columns>
                                        <asp:BoundField DataField="submitted_by" HeaderText="submitted by" />
                                        <asp:BoundField DataField="date_submitted" HeaderText="date submitted" />
                                        <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                        <asp:BoundField DataField="beginning_date" HeaderText="Date" />
                                        <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                        <asp:BoundField DataField="total_time" HeaderText="hours" />
                                        <asp:BoundField DataField="timepay" HeaderText="Time/ Pay" />
                                        <asp:BoundField DataField="ot_code" HeaderText="OT Type" />
                                        <asp:BoundField DataField="status_id" HeaderText="Status" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                edit
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <a href="TRRequest.aspx?id=<%#Eval("card_number") %>">edit</a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div id="tabs-5">
                            <div style="height: 600px; overflow: auto;">
                                <asp:GridView runat="server" class="table table-striped table-hover" ID="gvPendingRequestsEP" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                    <Columns>
                                        <asp:BoundField DataField="submitted_by" HeaderText="submitted by" />
                                        <asp:BoundField DataField="date_submitted" HeaderText="date submitted" />
                                        <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                        <asp:BoundField DataField="beginning_date" HeaderText="Date" />
                                        <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                        <asp:BoundField DataField="total_time" HeaderText="hours" />
                                        <asp:BoundField DataField="in_place_rank" HeaderText="Time/ Pay" />
                                        <asp:BoundField DataField="status_id" HeaderText="Status" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                edit
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <a href="EPRequest.aspx?id=<%#Eval("card_number") %>">edit</a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
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
</body>
</html>
