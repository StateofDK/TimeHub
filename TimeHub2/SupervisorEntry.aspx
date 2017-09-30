<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupervisorEntry.aspx.cs" Inherits="TimeHub2.SupervisorEntry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>Supervisor Entry</title>
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
    <script type="text/javascript">
        function alertRowIndex(tb, rowIndex) {
            //get employee info from api
            $.getJSON("api/employee?star=" + tb.value,
                function (data) {
                    //loop through each record in data returned from api
                    var employee = data.Table;

                    $.each(employee, function (key, val) {
                        //loop through each row in griview/table
                        var table = document.getElementById("gvEmployeeInfo");

                        for (var i = 0, row; row = table.rows[i]; i++) {
                            //test if textbox containing input star matches star returned from api
                            var inputStar = $('#gvEmployeeInfo_txtStar_' + i).val();
                            var returnedStar = tb.value;
                            if (inputStar == returnedStar) {
                                //populate name field with name returned from api
                                var lastName = val.last_name;
                                var firstName = val.first_name;
                                var middleInitial = val.middle_initial;
                                var userId = val.user_id;
                                var rank = val.user_rank;
                                var shiftWorked = val.regular_shift;
                                var assignment = val.assignment;

                                $('#gvEmployeeInfo_txtName_' + i).val(lastName.toString() + ", " + firstName.toString() + " " + middleInitial.toString() + ".");
                                $('#gvEmployeeInfo_txtRank_' + i).val(rank.toString());
                                $('#gvEmployeeInfo_txtAssignment_' + i).val(assignment.toString());
                                $('#gvEmployeeInfo_txtUserCredited_' + i).val(userId.toString());

                                $('#gvEmployeeInfo_ddlShiftWorked_' + rowIndex).focus();
                            }
                        }
                    });
                });
            };
    </script>
    <script type="text/javascript">
        function FocusToStar() {
            var table = document.getElementById("gvEmployeeInfo");

            for (var i = 0, row; row = table.rows[i]; i++) {
                if ($('#gvEmployeeInfo_txtName_' + i).is(':focus') || $('#gvEmployeeInfo_txtRank_' + i).is(':focus') || $('#gvEmployeeInfo_txtAssignment_' + i).is(':focus')) {
                    $('#gvEmployeeInfo_txtStar_' + i).focus();
                }
            };
        };
    </script>
    <script type="text/javascript">
        $(function () {
            $('#rblRequestType input').change(function showSubTypes() {
                var $input = $(this),
                    $coSelections = $('#coSelections'),
                    $epSelections = $('#epSelections'),
                    $otSelections = $('#otSelections'),
                    $toSelections = $('#toSelections'),
                    $trSelections = $('#trSelections'),
                    value = $input.val();

                var thCaseNumber = $("[id*=gvEmployeeInfo] th:contains('Case Number')");

                switch (value) {
                    case "co":
                        $coSelections.show();
                        $epSelections.hide();
                        $otSelections.hide();
                        $toSelections.hide();
                        $trSelections.hide();

                        thCaseNumber.css("display", "")

                        break;
                    case "ep":
                        $coSelections.hide();
                        $epSelections.show();
                        $otSelections.hide();
                        $toSelections.hide();
                        $trSelections.hide();
                        break;
                    case "ot":
                        $coSelections.hide();
                        $epSelections.hide();
                        $otSelections.show();
                        $toSelections.hide();
                        $trSelections.hide();
                        break;
                    case "to":
                        $coSelections.hide();
                        $epSelections.hide();
                        $otSelections.hide();
                        $toSelections.show();
                        $trSelections.hide();
                        break;
                    case "tr":
                        $coSelections.hide();
                        $epSelections.hide();
                        $otSelections.hide();
                        $toSelections.hide();
                        $trSelections.show();
                        break;
                }
            })
        });
    </script>
</head>
<body>
    <form id="supervisorHome" runat="server">
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
                    <asp:Label runat="server" ID="lblUserLoggedInStar"></asp:Label>
                    <asp:Label runat="server" ID="lblUserLoggedInRank"></asp:Label>
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
                    <h1 class="page-header">Supervisor Entry</h1>
                    <div>
                        <label id="lblcblRequestType">Select Request Type</label>
                        <asp:RadioButtonList runat="server" ID="rblRequestType" RepeatDirection="Horizontal"></asp:RadioButtonList>
                    </div>
                    <div>
                        <div>
                            <label id="lblBeginningDate">Beginning Date</label>
                            <asp:TextBox runat="server" ID="tbBeginningDate" type="date"></asp:TextBox>
                            <label id="lblBeginningTime">Beginning Time</label>
                            <asp:TextBox runat="server" ID="tbBeginningTime" type="number" AllowNegatives="false"></asp:TextBox>
                            <label id="lblEndingDate">Ending Date</label>
                            <asp:TextBox runat="server" ID="tbEndingDate" type="date"></asp:TextBox>
                            <label id="lblEndingTime">Ending Time</label>
                            <asp:TextBox runat="server" ID="tbEndingTime" type="number" AllowNegatives="false"></asp:TextBox>
                            <label id="lblTotalTime">Total Time</label>
                            <asp:TextBox runat="server" ID="tbTotalTime"></asp:TextBox>
                        </div>
                        <div>
                            <label id="lblSubmittedBy">Submitted By</label>
                            <asp:TextBox runat="server" ID="tbSubmittedBy" Enabled="false"></asp:TextBox>
                            <%--<label id="lblSupervisorComments"></label>
                            <asp:TextBox runat="server" ID="tbSupervisorComments"></asp:TextBox>--%>
                            <label id="lblDateSubmitted">Date Submitted</label>
                            <asp:TextBox runat="server" ID="tbDateSubmitted" type="date" Enabled="false"></asp:TextBox>
                            <label id="lblApprovedBy">ApprovedBy</label>
                            <asp:TextBox runat="server" ID="tbApprovedBy" Enabled="false"></asp:TextBox>
                            <label id="lblApprovingRank">ApprovingRank</label>
                            <asp:TextBox runat="server" ID="tbApprovingRank" Enabled="false"></asp:TextBox>
                            <label id="lblApprovingStar">Approving Star</label>
                            <asp:TextBox runat="server" ID="tbApprovingStar" Enabled="false"></asp:TextBox>
                            <label id="lblDateApproved>Date Approved">Date Approved</label>
                            <asp:TextBox runat="server" ID="tbDateApproved" type="date" Enabled="false"></asp:TextBox>
                            <div>
                                <label id="lblCertifiedBy">CertifiedBy</label>
                                <asp:TextBox runat="server" ID="tbCertifiedBy" Enabled="false"></asp:TextBox>
                            </div>
                            <div>
                                <label id="lblInputBy">Input By</label>
                                <asp:TextBox runat="server" ID="tbInputBy"></asp:TextBox>
                            </div>
                        </div>
                        <div>
                            <div>
                                <label id="lblCaseNumber">Case Number</label>
                                <asp:TextBox runat="server" ID="tbCaseNumber"></asp:TextBox>
                            </div>
                            <div>
                                <label id="lblEventNumber">Event Number</label>
                                <asp:TextBox runat="server" ID="tbEventNumber"></asp:TextBox>
                            </div>
                            <%--<div>
                                <label id="lblComment"></label>
                                <asp:TextBox runat="server" ID="tbComment"></asp:TextBox>
                            </div>--%>
                            <div runat="server" id="otSelections" style="display: none">
                                <label id="lblILHoliday">In-Leiu Holiday</label>
                                <asp:TextBox runat="server" ID="tbILHoliday"></asp:TextBox>
                                <label id="lblOvertimeCode">Overtime Code</label>
                                <asp:DropDownList runat="server" ID="ddlOvertimeCode"></asp:DropDownList>
                                <label id="lblTimePay"></label>
                                <asp:RadioButtonList runat="server" ID="rblTimePay"></asp:RadioButtonList>
                                <label for="tbAccountNumber">event/account number</label>
                                <asp:TextBox runat="server" ID="tbAccountNumber"></asp:TextBox>
                            </div>
                            <div runat="server" id="toSelections" style="display: none">
                                <label id="lblTimeUsed">Time Used</label>
                                <asp:RadioButtonList runat="server" ID="rblTimeUsed" RepeatDirection="Horizontal"></asp:RadioButtonList>
                            </div>
                            <div runat="server" id="trSelections" style="display: none">
                                <label for="ddTrainingCode">Training Code</label>
                                <asp:DropDownList runat="server" ID="ddlTrainingCode"></asp:DropDownList>
                            </div>
                            <div runat="server" id="epSelections" style="display: none">
                                <label id="lblInPlaceName">Name of Person Worked In Place of</label>
                                <asp:TextBox runat="server" ID="tbInPlaceName"></asp:TextBox>
                                <label id="lblInPlaceRank"></label>
                                <asp:TextBox runat="server" ID="tbInPlaceRank"></asp:TextBox>
                            </div>
                            <div runat="server" id="coSelections" style="display: none">
                                <label id="lblCourtSession">CourtSession</label>
                                <asp:RadioButtonList runat="server" ID="rblCourtSession" RepeatDirection="Horizontal"></asp:RadioButtonList>
                                <label id="lblAppearanceType">Appearance Type</label>
                                <asp:RadioButtonList runat="server" ID="rblAppearanceType" RepeatDirection="Horizontal"></asp:RadioButtonList>
                                <label id="lblCourtDepartment">Department</label>
                                <asp:TextBox runat="server" ID="tbCourtDepartment"></asp:TextBox>
                                <label id="lblCourtType">Court Type</label>
                                <asp:RadioButtonList runat="server" ID="rblCourtType" RepeatDirection="Horizontal"></asp:RadioButtonList>
                                <label id="lblDefendant">Defendant</label>
                                <asp:TextBox runat="server" ID="tbDefendant"></asp:TextBox>
                                <label id="lblCourtNumber">Court Number</label>
                                <asp:TextBox runat="server" ID="tbCourtNumber" type="number"></asp:TextBox>
                                <label id="lblCharges">Charges</label>
                                <asp:TextBox runat="server" ID="tbCharges"></asp:TextBox>
                                <label id="lblApprovingDA">Approving DA</label>
                                <asp:TextBox runat="server" ID="tbApprovingDA" Enabled="false"></asp:TextBox>
                                <label id="lblDateDAApproved"></label>
                                <asp:TextBox runat="server" ID="tbDateDAApproved" type="date" Enabled="false"></asp:TextBox>
                                <label id="lblTimeDAApproved"></label>
                                <asp:TextBox runat="server" ID="tbTimeDAApproved" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                        <%--<div>
                            <label id="lblUserCredited">User Credited</label>
                            <label id="lblLastName">Last Name</label>
                            <asp:TextBox runat="server" ID="tbLastName" Enabled="false"></asp:TextBox>
                            <label id="lblFirstName">Last Name</label>
                            <asp:TextBox runat="server" ID="tbFirstName" Enabled="false"></asp:TextBox>
                            <label id="lblMiddleInitial">Middle Initial</label>
                            <asp:TextBox runat="server" ID="tbMiddleInitial" Enabled="false"></asp:TextBox>
                            <label id="lblRank">Rank</label>
                            <asp:TextBox runat="server" ID="tbRank" Enabled="false"></asp:TextBox>
                            <label id="lblStar">Star</label>
                            <asp:TextBox runat="server" ID="tbStar" Enabled="false"></asp:TextBox>
                            <label id="lblAssignment">Assignment</label>
                            <asp:TextBox runat="server" ID="tbAssignment" Enabled="false"></asp:TextBox>
                            <label id="lblDetail">Detail</label>
                            <asp:TextBox runat="server" ID="tbDetail" Enabled="false"></asp:TextBox>
                        </div>--%>
                    </div>
                    <div>
                        <asp:GridView ID="gvEmployeeInfo" runat="server"
                            ShowFooter="True" AutoGenerateColumns="False"
                            CellPadding="4" ForeColor="#333333"
                            GridLines="None" OnRowDeleting="gvEmployeeInfo_RowDeleting"
                            class="table-responsive">
                            <Columns>

                                <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Star">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtStar" runat="server" Columns="8" MaxLength="6"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtName" runat="server" ></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rank">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRank" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Assignment">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAssignment" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Shift Worked">
                                    <ItemTemplate>
                                         <asp:DropDownList runat="server" ID="ddlShiftWorked"></asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comment">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSupervisorComment" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Left" />
                                    <FooterTemplate>
                                        <asp:Button ID="ButtonAdd" runat="server" Text="Add" OnClick="ButtonAddNewRowClick" />
                                        <asp:TextBox runat="server" ID="txtAddRowCount" text="1" Columns="1"></asp:TextBox>
                                        <asp:label runat="server" ID="lblAddRowCount" Text="rows"></asp:label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Request ID">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hlRequestID" runat="server" NavigateUrl="" Text=""></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <asp:Button ID="btnAdd" runat="server" Text="Commit Entries" OnClick="CommitEntries" CommandName="Footer" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtUserCredited" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowDeleteButton="True"  DeleteText ="Delete Row"/>
                            </Columns>
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <EditRowStyle BackColor="#2461BF" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
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
    <!-- script references -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>

</body>
</html>
