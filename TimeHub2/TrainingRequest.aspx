<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainingRequest.aspx.cs" Inherits="TimeHub2.TRRequest1" %>

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

                    <h1 class="page-header">training compensation request</h1>

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
                                <label for="tbBeginningDate">beginning day & date of overtime</label>
                                <asp:TextBox runat="server" ID="tbBeginningDate" type="date" onChange="return getBegDay()"></asp:TextBox>
                            </div>
                            <div class="line">
                                <label for="tbEndingDate">ending day & date of overtime</label>
                                <asp:TextBox runat="server" ID="tbEndingDate" type="date" onChange="return getEndDay()"></asp:TextBox>
                            </div>
                            <div class="bottom-line">
                                <label for="tbILHoliday">in-lieu of Holiday</label>
                                <asp:TextBox runat="server" ID="tbILHoliday"></asp:TextBox>
                                <label for="rblTimePay">request</label>
                                <asp:RadioButtonList runat="server" ID="rblTimePay" RepeatDirection="Horizontal">
                                    <asp:ListItem>time</asp:ListItem>
                                    <asp:ListItem>pay</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="box">
                            <div class="box">
                                <div class="line">
                                    <label for="ddlOTCode">ot code no.</label>
                                    <asp:DropDownList runat="server" ID="ddlOTCode">
                                        <asp:ListItem Value='0' Text='Select' />
                                        <asp:ListItem>1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                        <asp:ListItem>4</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                        <asp:ListItem>6</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="line">
                                    <label for="ddlShift">regular shift</label>
                                    <asp:DropDownList runat="server" ID="ddlShift">
                                        <asp:ListItem Value='NULL' Text='Select' />
                                        <asp:ListItem Value='1' Text='0000/0800' />
                                        <asp:ListItem Value='25' Text='0000/0900' />
                                        <asp:ListItem Value='49' Text='0000/1000' />
                                        <asp:ListItem Value='2' Text='0100/0900' />
                                        <asp:ListItem Value='26' Text='0100/1000' />
                                        <asp:ListItem Value='50' Text='0100/1100' />
                                        <asp:ListItem Value='3' Text='0200/1000' />
                                        <asp:ListItem Value='27' Text='0200/1100' />
                                        <asp:ListItem Value='51' Text='0200/1200' />
                                        <asp:ListItem Value='4' Text='0300/1100' />
                                        <asp:ListItem Value='28' Text='0300/1200' />
                                        <asp:ListItem Value='52' Text='0300/1300' />
                                        <asp:ListItem Value='5' Text='0400/1200' />
                                        <asp:ListItem Value='29' Text='0400/1300' />
                                        <asp:ListItem Value='53' Text='0400/1400' />
                                        <asp:ListItem Value='6' Text='0500/1300' />
                                        <asp:ListItem Value='30' Text='0500/1400' />
                                        <asp:ListItem Value='54' Text='0500/1500' />
                                        <asp:ListItem Value='7' Text='0600/1400' />
                                        <asp:ListItem Value='31' Text='0600/1500' />
                                        <asp:ListItem Value='55' Text='0600/1600' />
                                        <asp:ListItem Value='8' Text='0700/1500' />
                                        <asp:ListItem Value='32' Text='0700/1600' />
                                        <asp:ListItem Value='56' Text='0700/1700' />
                                        <asp:ListItem Value='9' Text='0800/1600' />
                                        <asp:ListItem Value='33' Text='0800/1700' />
                                        <asp:ListItem Value='57' Text='0800/1800' />
                                        <asp:ListItem Value='10' Text='0900/1700' />
                                        <asp:ListItem Value='34' Text='0900/1800' />
                                        <asp:ListItem Value='58' Text='0900/1900' />
                                        <asp:ListItem Value='11' Text='1000/1800' />
                                        <asp:ListItem Value='35' Text='1000/1900' />
                                        <asp:ListItem Value='59' Text='1000/2000' />
                                        <asp:ListItem Value='12' Text='1100/1900' />
                                        <asp:ListItem Value='36' Text='1100/2000' />
                                        <asp:ListItem Value='60' Text='1100/2100' />
                                        <asp:ListItem Value='13' Text='1200/2000' />
                                        <asp:ListItem Value='37' Text='1200/2100' />
                                        <asp:ListItem Value='61' Text='1200/2200' />
                                        <asp:ListItem Value='14' Text='1300/2100' />
                                        <asp:ListItem Value='38' Text='1300/2200' />
                                        <asp:ListItem Value='62' Text='1300/2300' />
                                        <asp:ListItem Value='15' Text='1400/2200' />
                                        <asp:ListItem Value='39' Text='1400/2300' />
                                        <asp:ListItem Value='63' Text='1400/0000' />
                                        <asp:ListItem Value='16' Text='1500/2300' />
                                        <asp:ListItem Value='40' Text='1500/0000' />
                                        <asp:ListItem Value='64' Text='1500/0100' />
                                        <asp:ListItem Value='17' Text='1600/0000' />
                                        <asp:ListItem Value='41' Text='1600/0100' />
                                        <asp:ListItem Value='65' Text='1600/0200' />
                                        <asp:ListItem Value='18' Text='1700/0100' />
                                        <asp:ListItem Value='42' Text='1700/0200' />
                                        <asp:ListItem Value='66' Text='1700/0300' />
                                        <asp:ListItem Value='19' Text='1800/0200' />
                                        <asp:ListItem Value='43' Text='1800/0300' />
                                        <asp:ListItem Value='67' Text='1800/0400' />
                                        <asp:ListItem Value='20' Text='1900/0300' />
                                        <asp:ListItem Value='44' Text='1900/0400' />
                                        <asp:ListItem Value='68' Text='1900/0500' />
                                        <asp:ListItem Value='21' Text='2000/0400' />
                                        <asp:ListItem Value='45' Text='2000/0500' />
                                        <asp:ListItem Value='69' Text='2000/0600' />
                                        <asp:ListItem Value='22' Text='2100/0500' />
                                        <asp:ListItem Value='46' Text='2100/0600' />
                                        <asp:ListItem Value='70' Text='2100/0700' />
                                        <asp:ListItem Value='23' Text='2200/0600' />
                                        <asp:ListItem Value='47' Text='2200/0700' />
                                        <asp:ListItem Value='71' Text='2200/0800' />
                                        <asp:ListItem Value='24' Text='2300/0700' />
                                        <asp:ListItem Value='48' Text='2300/0800' />
                                        <asp:ListItem Value='72' Text='2300/0900' />
                                    </asp:DropDownList>
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
                                    <label for="tbSubmittedDate">date submitted</label>
                                    <asp:TextBox runat="server" ID="tbSubmittedDate"></asp:TextBox>
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
                                    <label for="tbApprovedDate">date aproved</label>
                                    <asp:TextBox runat="server" ID="tbApprovedDate"></asp:TextBox>
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
                                <asp:TextBox runat="server" ID="tbCaseNumber"></asp:TextBox>
                            </div>
                            <div class="line">
                                <label for="tbCertifiedBy">
                                    <asp:TextBox runat="server" ID="tbCertifiedBy"></asp:TextBox>
                                </label>
                            </div>
                            <div class="line">
                                <div>
                                    <span>overtime categories</span>
                                    <asp:BulletedList runat="server" BulletStyle="Numbered" FirstBulletNumber="1">
                                        <asp:ListItem>fto compensation</asp:ListItem>
                                        <asp:ListItem>range requalification</asp:ListItem>
                                    </asp:BulletedList>
                                    <asp:BulletedList runat="server" BulletStyle="Numbered" FirstBulletNumber="3">
                                        <asp:ListItem>physical agility test</asp:ListItem>
                                        <asp:ListItem>biweekly training</asp:ListItem>
                                    </asp:BulletedList>
                                    <asp:BulletedList runat="server" BulletStyle="Numbered" FirstBulletNumber="5">
                                        <asp:ListItem>remediation</asp:ListItem>
                                        <asp:ListItem>other</asp:ListItem>
                                    </asp:BulletedList>
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
