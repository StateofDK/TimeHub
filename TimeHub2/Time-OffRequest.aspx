<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Time-OffRequest.aspx.cs" Inherits="TimeHub2.TORequest" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <link href="content/bootstrap.min.css" rel="stylesheet">
    <link href="stylesheets/styles.css" rel="stylesheet">
    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>--%>
    <%--<script src="js/bootstrap.min.js"></script>--%>
    <%--<script src="js/scripts.js"></script>--%>
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
            $('#tbBeginningTime, #tbEndingTime').blur(function () {
                var beginTime = $('#tbBeginningTime').val();
                var endTime = $('#tbEndingTime').val();
                var strBeginTime = beginTime.toString();
                var strEndTime = endTime.toString();

                var totalTime = $('#tbTotalTime');
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

                    <h1 class="page-header">Time Off Request</h1>

                    <div class="divCardInfo">
                        <asp:Label runat="server" ID="lblCardNumber" AssociatedControlID="tbCardNumber" Visible="true">Card Number:</asp:Label>
                        <asp:TextBox runat="server" ID="tbCardNumber" ReadOnly="true" Visible="true"></asp:TextBox>
                        <asp:TextBox runat="server" ID="tbStatusId" ReadOnly="true" Visible="false"></asp:TextBox>
                        <asp:TextBox runat="server" ID="tbUserCredited" ReadOnly="true" Visible="false"></asp:TextBox>
                    </div>
                    <div class="card">
            <div class="box">
                <div class="line">
                    <label for="tbLastName">(print) last name</label>
                    <asp:TextBox runat="server" ID="tbLastName"></asp:TextBox>
                    <label for="tbFirstName">first</label>
                    <asp:TextBox runat="server" ID="tbFirstName"></asp:TextBox>
                    <label for="tbMiddleInitial">middle initial</label>
                    <asp:TextBox runat="server" ID="tbMiddleInitial"></asp:TextBox>
                </div>
                <div class="line">
                    <label for="ddlAssignment">assignment</label>
                    <asp:DropDownList runat="server" ID="ddlAssignment" Enabled="false"></asp:DropDownList>
                    <label for="tbDetail">detailed to</label>
                    <asp:TextBox runat="server" ID="tbDetail"></asp:TextBox>
                </div>
                <div class="line">
                    <label for="tbBeginningDate">beginning date of overtime</label>
                    <asp:TextBox runat="server" ID="tbBeginningDate" type="date"></asp:TextBox>
                </div>
                <div class="line">
                    <label for="tbEndingDate">ending date of overtime</label>
                    <asp:TextBox runat="server" ID="tbEndingDate" type="date" onChange="return getEndDay()"></asp:TextBox>
                </div>
                <div class="bottom-line">
                    <asp:RadioButtonList runat="server" ID="rblTimeUsed" RepeatDirection="Horizontal">
                        <asp:ListItem>equivalent use Holiday</asp:ListItem>
                        <asp:ListItem>fitness time</asp:ListItem>
                        <asp:ListItem>compensatory time use</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="box">
                <div class="box">
                    <div class="line">
                        <label for="tbSubmittedDate">date submitted</label>
                        <asp:TextBox runat="server" ID="tbSubmittedDate" type="date"></asp:TextBox>
                    </div>
                    <div class="line">
                        <label for="tbBeginningTime">beginning time</label>
                        <asp:TextBox runat="server" ID="tbBeginningTime" type="number" AllowNegatives="false"></asp:TextBox>
                    </div>
                    <div class="line">
                        <label for="tbEndingTime">ending time</label>
                        <asp:TextBox runat="server" ID="tbEndingTime" type="number" AllowNegatives="false"></asp:TextBox>
                    </div>
                    <div class="bottom-line">
                        <label for="tbTotalTime">total time worked</label>
                        <asp:TextBox runat="server" ID="tbTotalTime" type="number" ReadOnly="true" AllowNegatives="false"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="box">
                <div class="box">
                    <div class="line">
                        <label for="tbSubmittedBy">signature</label>
                        <asp:Button runat="server" ID="btnSign" Text="Sign Card" OnClick="btnSignClick" Visible="true" />
                        <asp:Button runat="server" ID="btnUnsign" Text="Unsign Card" OnClick="btnUnsignClick" Visible="false" />
                        <asp:TextBox runat="server" ID="tbSubmittedBy"></asp:TextBox>
                    </div>
                    <div class="bottom-line">
                        <label for="tbUserRank">rank</label>
                        <asp:TextBox runat="server" ID="tbUserRank"></asp:TextBox>
                        <label for="tbUserStar">star</label>
                        <asp:TextBox runat="server" ID="tbUserStar" type="number"></asp:TextBox>
                    </div>
                </div>
                <div class="box">
                    <div class="line">
                        <label for="tbApprovedBy">approved by commanding officer</label>
                        <asp:TextBox runat="server" ID="tbApprovedBy"></asp:TextBox>
                    </div>
                    <div class="bottom-line">
                        <label for="tbApprovedRank">rank</label>
                        <asp:TextBox runat="server" ID="tbApprovedRank"></asp:TextBox>
                        <label for="tbApprovedStar">star</label>
                        <asp:TextBox runat="server" ID="tbApprovedStar"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
                    <asp:Label runat="server" ID="lblSupervisorComments" for="tbSupervisorComments" AssociatedControlID="tbSupervisorComments" Visible="false">Supervisor Comments:</asp:Label>
                    <asp:TextBox runat="server" ID="tbSupervisorComments" ReadOnly="true" Visible="false"></asp:TextBox>
                    <asp:Button runat="server" ID="btnSave" Text="save card" OnClick="btnSaveClick" Visible="false" />
                    <asp:Button runat="server" ID="btnWithdraw" Text="withdraw card" OnClick="btnWithdrawClick" Visible="false" />
                    <asp:Button runat="server" ID="btnSubmit" Text="submit card" OnClick="btnSubmitClick" Visible="false" />
                    <asp:Button runat="server" ID="btnNewCard" Text="create new card" OnClick="btnNewCardClick" Visible="true" />
                    <asp:Button runat="server" ID="btnDelete" Text="Delete Card" OnClick="btnDeleteClick" Visible="false" />
                    <asp:Button runat="server" ID="btnCancel" Text="Cancel" OnClick="btnCancelClick" Visible="false" />
                    <asp:Button runat="server" ID="btnApprove" Text="approve" OnClick="btnApproveClick" Visible="false" />
                    <asp:Button runat="server" ID="btnReturn" Text="return Card" OnClick="btnReturnClick" Visible="false" />
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