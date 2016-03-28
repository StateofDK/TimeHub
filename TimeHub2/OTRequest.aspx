<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OTRequest.aspx.cs" Inherits="TimeHub2.OTRequest1" %>

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

                    <h1 class="page-header">court compensation request</h1>

                    <div class="divCardInfo">
                        <asp:Label runat="server" ID="lblCardNumber" AssociatedControlID="tbCardNumber" Visible="true">Card Number:</asp:Label>
                        <asp:TextBox runat="server" ID="tbCardNumber" ReadOnly="true" Visible="true"></asp:TextBox>
                        <asp:TextBox runat="server" ID="tbStatusId" ReadOnly="true" Visible="false"></asp:TextBox>
                        <asp:TextBox runat="server" ID="tbUserCredited" ReadOnly="true" Visible="false"></asp:TextBox>
                    </div>
                    <div class="card">
                        <div class="box">
                            <div class="line">
                                <div class="in-line-block  thirds">
                                    <label for="tbLastName">(print) last name</label>
                                    <asp:TextBox runat="server" CssClass="textbox" ID="tbLastName"></asp:TextBox>
                                </div>
                                <div class="in-line-block  thirds">
                                    <label for="tbFirstName">first</label>
                                    <asp:TextBox runat="server" CssClass="textbox" ID="tbFirstName"></asp:TextBox>
                                </div>
                                <div class="in-line-block  thirds">
                                    <label for="tbMiddleInitial">middle initial</label>
                                    <asp:TextBox runat="server" CssClass="textbox" ID="tbMiddleInitial"></asp:TextBox>
                                </div>
                            </div>
                            <div class="line">
                                <div class="in-line-block">
                                    <label for="ddlAssignment">assignment</label>
                                    <asp:DropDownList runat="server" CssClass="textbox" ID="ddlAssignment" Enabled="false"></asp:DropDownList>
                                </div>
                                <div class="in-line-block">
                                    <label for="tbDetail">detailed to</label>
                                    <asp:TextBox runat="server" CssClass="textbox" ID="tbDetail"></asp:TextBox>
                                </div>
                            </div>
                            <div class="line">
                                <label for="tbBeginningDate">beginning date of overtime</label>
                                <asp:TextBox runat="server" CssClass="textbox" ID="tbBeginningDate" type="date"></asp:TextBox>
                            </div>
                            <div class="line">
                                <label for="tbEndingDate">ending date of overtime</label>
                                <asp:TextBox runat="server" CssClass="textbox" ID="tbEndingDate" type="date"></asp:TextBox>
                            </div>
                            <div class="bottom-line">
                                <div class="in-line-block halves">
                                    <label for="tbILHoliday">in-lieu of Holiday</label>
                                    <asp:TextBox runat="server" CssClass="textbox" ID="tbILHoliday"></asp:TextBox>
                                </div>
                                <div class="in-line-block halves">
                                    <label for="rblTimePay">request</label>
                                    <asp:RadioButtonList runat="server" CssClass="textbox" ID="rblTimePay" RepeatDirection="Horizontal">
                                        <asp:ListItem>time</asp:ListItem>
                                        <asp:ListItem>pay</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="box">
                            <div class="line">
                                <label for="ddlOTCode">ot code no.</label>
                                <asp:DropDownList runat="server" CssClass="textbox" ID="ddlOTCode"></asp:DropDownList>
                            </div>
                            <div class="line">
                                <label for="ddlShift">regular shift</label>
                                <asp:DropDownList runat="server" CssClass="textbox" ID="ddlShift"></asp:DropDownList>
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
                        <div class="box">
                            <div class="box-left">
                                <div class="line">
                                    <label for="tbSubmittedBy">signature</label>
                                    <asp:Button runat="server" ID="btnSign" Text="Sign Card" OnClick="btnSignClick" Visible="true" />
                                    <asp:Button runat="server" ID="btnUnsign" Text="Unsign Card" OnClick="btnUnsignClick" Visible="false" />
                                    <asp:TextBox runat="server" ID="tbSubmittedBy"></asp:TextBox>
                                </div>
                                <div class="bottom-line">
                                    <div class="halves in-line-block">
                                        <div class="halves in-line-block">
                                            <label for="tbUserRank">rank</label>
                                            <asp:TextBox runat="server" CssClass="textbox" ID="tbUserRank"></asp:TextBox>
                                        </div>
                                        <div class="halves in-line-block">
                                            <label for="tbUserStar">star</label>
                                            <asp:TextBox runat="server" CssClass="textbox" ID="tbUserStar" type="number"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="halves in-line-block">
                                        <label for="tbSubmittedDate">date submitted</label>
                                        <asp:TextBox runat="server" CssClass="textbox" ID="tbSubmittedDate"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="box-right">
                                <div class="line">
                                    <label for="tbApprovedBy">approved by commanding officer</label>
                                    <asp:TextBox runat="server" CssClass="textbox" ID="tbApprovedBy" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="bottom-right">
                                    <div class="halves in-line-block">
                                        <div class="halves in-line-block">
                                            <label for="tbApprovedRank">rank</label>
                                            <asp:TextBox runat="server" CssClass="textbox" ID="tbApprovedRank" ReadOnly="true"></asp:TextBox>
                                        </div>
                                        <div class="halves in-line-block">
                                            <label for="tbApprovedStar">star</label>
                                            <asp:TextBox runat="server" CssClass="textbox" ID="tbApprovedStar" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="halves in-line-block">
                                        <label for="tbApprovedDate">date aproved</label>
                                        <asp:TextBox runat="server" CssClass="textbox" ID="tbApprovedDate" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <br />
                    <div class="card">
                        <div class="box">
                            <div class="line">
                                <label for="tbCaseNumber">nature of work: include incident case number</label>
                                <asp:TextBox runat="server" CssClass="textbox" ID="tbCaseNumber"></asp:TextBox>
                            </div>
                            <div class="line">
                                <label for="tbCertifiedBy">overtime hours certified by:</label>
                                <asp:TextBox runat="server" CssClass="textbox" ID="tbCertifiedBy" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="bottom-line">
                                <label for="tbInputBy">entered into H.R.M.S. by:</label>
                                <asp:TextBox runat="server" CssClass="textbox" ID="tbInputBy" ReadOnly="true"></asp:TextBox>
                                <label for="tbEventNumber">f.o.b. event/account number</label>
                                <asp:TextBox runat="server" CssClass="textbox" ID="tbEventNumber"></asp:TextBox>
                            </div>
                        </div>
                        <div class="box">
                            <div class="bottom-line">
                                <div>
                                    <span>overtime categories</span>
                                    <asp:BulletedList runat="server" CssClass="in-line-block" BulletStyle="Numbered" FirstBulletNumber="1">
                                        <asp:ListItem>10b ples</asp:ListItem>
                                        <asp:ListItem>investigations</asp:ListItem>
                                    </asp:BulletedList>
                                    <asp:BulletedList runat="server" CssClass="in-line-block" BulletStyle="Numbered" FirstBulletNumber="3">
                                        <asp:ListItem>arrest</asp:ListItem>
                                        <asp:ListItem>miscellaneous</asp:ListItem>
                                    </asp:BulletedList>
                                    <asp:BulletedList runat="server" CssClass="in-line-block" BulletStyle="Numbered" FirstBulletNumber="5">
                                        <asp:ListItem>extended work week</asp:ListItem>
                                        <asp:ListItem>holiday</asp:ListItem>
                                    </asp:BulletedList>
                                </div>
                            </div>
                        </div>
                        <div class="comment-box">
                            <div class="bottom-line">
                                <label for="tbComments">comments:</label>
                                <asp:TextBox runat="server" CssClass="textbox" ID="tbComments" Rows="6" cols="89"></asp:TextBox>
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
