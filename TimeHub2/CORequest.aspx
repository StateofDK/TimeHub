﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CORequest.aspx.cs" Inherits="TimeHub2.CORequestNew" %>

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
            });
        };

        <%--function hoursCalc () {
            var startTime = document.getElementById('<%= tbBeginningTime.ClientID %>');
            var endTime = document.getElementById('<%= tbEndingTime.ClientID %>');
            var totalTime = document.getElementById('<%= tbTotalTime.ClientID %>');
            var t1 = 0;
            var t2 = 0;

            if (startTime.value != "") t1 = startTime.value;
            if (endTime.value != "") t2 = endTime.value;

            if (endTime.value < startTime.value) t2 = parseInt(endTime.value) + 2400;

            totalTime.value = parseInt((parseInt(t2) - parseInt(t1)) / 100);
        }--%>

        function hoursCalc() {
            var number = document.getElementById('<%= tbBeginningTime.ClientID %>');

            var startTime = document.getElementById('<%= tbBeginningTime.ClientID %>');
            var startTimeHour = 0;
            var startTimeMin = 0;
            var startTimeNew = 0;
            var endTime = document.getElementById('<%= tbEndingTime.ClientID %>');
            var endTimeHour = 0;
            var endTimeMin = 0;
            var endTimeNew = 0;
            var totalTime = document.getElementById('<%= tbTotalTime.ClientID %>');

            output = [];
            sNumber = number.toString();

            for (var i = 0, len = sNumber.length; i < len; i += 1) {
                output.push(+sNumber.charAt(i));

                console.log(output);
            }

            
        }

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
                    </ul>
                </div>
                <!--/span-->

                <div class="col-sm-9 col-md-10 main">

                    <!--toggle sidebar button-->
                    <p class="visible-xs">
                        <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas"><i class="glyphicon glyphicon-chevron-left"></i></button>
                    </p>

                    <h1 class="page-header">court compensation request</h1>

                    <div class="box">
                        <span>court compensation request</span>
                    </div>
                    <div class="divCardInfo">
                        <div id="divCardNumber">
                            <asp:Label runat="server" ID="lblCardNumber" AssociatedControlID="tbCardNumber" Visible="true">Card Number:</asp:Label>
                            <asp:TextBox runat="server" ID="tbCardNumber" ReadOnly="true" Visible="true"></asp:TextBox>
                        </div>
                        <asp:TextBox runat="server" ID="tbStatusId" ReadOnly="true" Visible="false"></asp:TextBox>
                        <asp:TextBox runat="server" ID="tbUserCredited" ReadOnly="true" Visible="false"></asp:TextBox>
                    </div>
                    <div class="card">
                        <div class="box">
                            <div class="box">
                                <div class="line">
                                    <label for="tbLastName">last name</label>
                                    <asp:TextBox runat="server" ID="tbLastName" CssClass="form-control-static" ReadOnly="true"></asp:TextBox>
                                    <label runat="server" for="tbFirstName">first name</label>
                                    <asp:TextBox runat="server" ID="tbFirstName" ReadOnly="true"></asp:TextBox>
                                    <label runat="server" for="tbMiddleInitial">initial</label>
                                    <asp:TextBox runat="server" ID="tbMiddleInitial" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="line">
                                    <label for="ddlAssignment">assignment</label>
                                    <asp:DropDownList runat="server" ID="ddlAssignment" Enabled="false">
                                        <asp:ListItem Value='NULL' Text='Select' />
                                        <asp:ListItem Value="1" Text='Central Station' />
                                        <asp:ListItem Value="2" Text='Central Station - SIT' />
                                        <asp:ListItem Value="3" Text='Southern Station' />
                                        <asp:ListItem Value="4" Text='Southern Station - SIT' />
                                        <asp:ListItem Value="5" Text='Bayview Station' />
                                        <asp:ListItem Value="6" Text='Bayview Station - SIT' />
                                        <asp:ListItem Value="7" Text='Mission Station' />
                                        <asp:ListItem Value="8" Text='Mission Station - SIT' />
                                        <asp:ListItem Value="9" Text='Northern Station' />
                                        <asp:ListItem Value="10" Text='Northern Station - SIT' />
                                        <asp:ListItem Value="11" Text='Park Station' />
                                        <asp:ListItem Value="12" Text='Park Station - SIT' />
                                        <asp:ListItem Value="13" Text='Richmond Station' />
                                        <asp:ListItem Value="14" Text='Richmond Station - SIT' />
                                        <asp:ListItem Value="15" Text='Ingleside Station' />
                                        <asp:ListItem Value="16" Text='Ingleside Station - SIT' />
                                        <asp:ListItem Value="17" Text='Taraval Station' />
                                        <asp:ListItem Value="18" Text='Taraval Station - SIT' />
                                        <asp:ListItem Value="19" Text='Tenderloin Station' />
                                        <asp:ListItem Value="20" Text='Tenderloin Station - SIT' />
                                        <asp:ListItem Value="21" Text='Traffic Company' />
                                        <asp:ListItem Value="22" Text='Crime Scene Investigations' />
                                        <asp:ListItem Value="23" Text='Department Operations Center' />
                                        <asp:ListItem Value="24" Text='Equal Employment Opportunity' />
                                        <asp:ListItem Value="25" Text='Facilities Management' />
                                        <asp:ListItem Value="26" Text='Field Operations Bureau' />
                                        <asp:ListItem Value="27" Text='Fleet Management' />
                                        <asp:ListItem Value="28" Text='Fugitive Recovery Enforcement Team' />
                                        <asp:ListItem Value="29" Text='Gang Task Force' />
                                        <asp:ListItem Value="30" Text='Graffiti Abatement' />
                                        <asp:ListItem Value="31" Text='Hit & Run' />
                                        <asp:ListItem Value="32" Text='Homeland Security Unit' />
                                        <asp:ListItem Value="33" Text='Homicide' />
                                        <asp:ListItem Value="34" Text='Housing Unit' />
                                        <asp:ListItem Value="35" Text='Municipal Transport Agency' />
                                        <asp:ListItem Value="36" Text='Narcotics' />
                                        <asp:ListItem Value="37" Text='Outside Agency' />
                                        <asp:ListItem Value="38" Text='Permits Bureau' />
                                        <asp:ListItem Value="39" Text='Property Section' />
                                        <asp:ListItem Value="40" Text='Risk Management Office' />
                                        <asp:ListItem Value="41" Text='Special Victims Unit' />
                                        <asp:ListItem Value="42" Text='Special Investigations' />
                                        <asp:ListItem Value="43" Text='Violence Reduction Team' />
                                        <asp:ListItem Value="44" Text='Administration Bureau' />
                                        <asp:ListItem Value="45" Text='Airport Bureau' />
                                        <asp:ListItem Value="46" Text='Alcoholic Beverage Control Liaison' />
                                        <asp:ListItem Value="47" Text='Arson Unit' />
                                        <asp:ListItem Value="0" Text='Other - Not In List' />
                                    </asp:DropDownList>
                                    <label for="tbDetail">detailed to</label>
                                    <asp:TextBox runat="server" ID="tbDetail"></asp:TextBox>
                                </div>
                                <div class="line">
                                    <label for="tbBeginningDate">beginning day and date</label>
                                    <div>
                                        <asp:TextBox runat="server" type="date" ID="tbBeginningDate"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="line">
                                    <label for="tbEndingDate">ending day and date</label>
                                    <div>
                                        <asp:TextBox runat="server" type="date" ID="tbEndingDate"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="line">
                                    <label for="tbCertifiedBy">hours certified by court liaison</label>
                                    <asp:TextBox runat="server" ID="tbCertifiedBy" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="box">
                                <div class="line">
                                    <label for="tbInputBy">entered into HRMS by:</label>
                                    <asp:TextBox runat="server" ID="tbInputBy" ReadOnly="true"></asp:TextBox>
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
                                    <asp:TextBox runat="server" ID="tbBeginningTime" type="number" AllowNegatives="false" onblur="javascript:hoursCalc();"></asp:TextBox>
                                </div>
                                <div class="line">
                                    <label for="tbEndingTime">ending time</label>
                                    <asp:TextBox runat="server" ID="tbEndingTime" type="number" AllowNegatives="false" onblur="javascript:hoursCalc();"></asp:TextBox>
                                </div>
                                <div class="line">
                                    <label for="tbTotalTime">total time</label>
                                    <asp:TextBox runat="server" ID="tbTotalTime" type="number" ReadOnly="true" AllowNegatives="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="box-left">
                                <div class="line">
                                    <label for="tbSubmittedBy">signature of member</label>
                                    <asp:Button runat="server" ID="btnSign" Text="Sign Card" OnClick="btnSignClick" Visible="false" />
                                    <asp:Button runat="server" ID="btnUnsign" Text="Unsign Card" OnClick="btnUnsignClick" Visible="false" />
                                    <asp:TextBox runat="server" ID="tbSubmittedBy" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="line">
                                    <label for="tbUserRank">rank</label>
                                    <asp:TextBox runat="server" ID="tbUserRank" ReadOnly="true"></asp:TextBox>
                                    <label for="tbUserStar">star</label>
                                    <asp:TextBox runat="server" ID="tbUserStar" ReadOnly="true"></asp:TextBox>
                                    <label for="tbSubmittedDate">date submitted</label>
                                    <asp:TextBox runat="server" ID="tbSubmittedDate" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="box-right">
                                <div class="line">
                                    <label for="tbApprovedBy">approved by commanding officer</label>
                                    <asp:TextBox runat="server" ID="tbApprovedBy" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="line">
                                    <label for="tbApprovedRank">rank</label>
                                    <asp:TextBox runat="server" ID="tbApprovedRank" ReadOnly="true"></asp:TextBox>
                                    <label for="tbApprovedStar">star</label>
                                    <asp:TextBox runat="server" ID="tbApprovedStar" ReadOnly="true"></asp:TextBox>
                                    <label for="tbApprovedDate">date approved</label>
                                    <asp:TextBox runat="server" ID="tbApprovedDate" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <br />
                    <div class="card">
                        <div class="box">
                            <label for="rblCourtSession">Court Session</label>
                            <asp:RadioButtonList runat="server" ID="rblCourtSession">
                                <asp:ListItem>morning</asp:ListItem>
                                <asp:ListItem>afternoon</asp:ListItem>
                                <asp:ListItem>standby</asp:ListItem>
                            </asp:RadioButtonList>
                            <label for="rblAppearanceType">Appearance Type</label>
                            <asp:RadioButtonList runat="server" ID="rblAppearanceType">
                                <asp:ListItem>trailing</asp:ListItem>
                                <asp:ListItem>da Conference</asp:ListItem>
                                <asp:ListItem>administrative hearing</asp:ListItem>
                            </asp:RadioButtonList>
                            <label for="tbDepartment">Subpoenaed to: Dept. No.</label>
                            <asp:TextBox runat="server" ID="tbDepartment"></asp:TextBox>
                            <asp:RadioButtonList runat="server" ID="rblCourtType">
                                <asp:ListItem>superior</asp:ListItem>
                                <asp:ListItem>ygc</asp:ListItem>
                                <asp:ListItem>traffic</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="box-left">
                            <div class="line">
                                <label for="tbDefendant">name of defendant</label>
                                <asp:TextBox runat="server" ID="tbDefendant"></asp:TextBox>
                            </div>
                            <div class="line">
                                <label for="tbCaseNumber">case number</label>
                                <asp:TextBox runat="server" ID="tbCaseNumber"></asp:TextBox>
                            </div>
                        </div>
                        <div class="box-right">
                            <div class="line">
                                <label for="tbCharges">charges</label>
                                <asp:TextBox runat="server" ID="tbCharges"></asp:TextBox>
                            </div>
                            <div class="line">
                                <label for="tbCourttNumber">court number</label>
                                <asp:TextBox runat="server" ID="tbCourtNumber"></asp:TextBox>
                            </div>
                        </div>
                        <div class="box">
                            <div class="line">
                                <label for="tbComments">comments:</label>
                                <asp:TextBox type="textarea" runat="server" ID="tbComments"></asp:TextBox>
                            </div>
                            <div class="line">
                                <label for="tbDaSigned">signature of da</label>
                                <asp:TextBox runat="server" ID="tbDaSigned" ReadOnly="true"></asp:TextBox>
                                <label for="tbDaSignedDate">date</label>
                                <asp:TextBox runat="server" ID="tbDaSignedDate" ReadOnly="true"></asp:TextBox>
                                <label for="tbDaSignedTime">time</label>
                                <asp:TextBox runat="server" ID="tbDaSignedTime" ReadOnly="true"></asp:TextBox>
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
