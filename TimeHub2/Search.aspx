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
    <link href="stylesheets/search.css" rel="stylesheet" />
    <!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
    <link href="stylesheets/styles.css" rel="stylesheet">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#ddlRequestType').change(function () { //adds change event to ddlReports
                $('.subtypes').slideUp(); //slides up all report divs
                $('.' + $('#ddlRequestType').val()).slideDown(); //slides dow n div selected by ddl
            });
        });
    </script>
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
                        <Label ID="lblAssignment" for="ddlAssignment">Assignment</Label>
                        <asp:DropDownList runat="server" CssClass="textbox" ID="ddlAssignment">
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
                        <Label ID="lblRequestType" for="ddlRequestType">Request Type</Label>
                        <asp:DropDownList runat="server" ID="ddlRequestType">
                            <asp:ListItem Value="NULL" Text="select" />
                            <asp:ListItem Value="All" Text="All" />
                            <asp:ListItem Value="OT" Text="OT" />
                            <asp:ListItem Value="CO" Text="CO" />
                            <asp:ListItem Value="TR" Text="TR" />
                            <asp:ListItem Value="EP" Text="EP" />
                            <asp:ListItem Value="TO" Text="TO" />
                        </asp:DropDownList>
                        <div runat="server" id="OTSubTypes" class="subtypes OT">
                            <label for="ddlOTCode">ot code no.</label>
                            <asp:DropDownList runat="server" CssClass="textbox" ID="ddlOTCode">
                                    <asp:ListItem Value='0' Text='Select' />
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="2">2</asp:ListItem>
                                    <asp:ListItem Value="3">3</asp:ListItem>
                                    <asp:ListItem Value="4">4</asp:ListItem>
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="6">6</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div id="COSubTypes" class="subtypes CO">
                            <label for="rblCourtSession">Court Session</label>
                            <asp:RadioButtonList runat="server" ID="rblCourtSession">
                                <asp:ListItem>morning</asp:ListItem>
                                <asp:ListItem>afternoon</asp:ListItem>
                                <asp:ListItem>standby</asp:ListItem>
                            </asp:RadioButtonList>
                            <label for="rblCourtType">Court Type</label>
                            <asp:RadioButtonList runat="server" ID="rblCourtType">
                                <asp:ListItem>superior</asp:ListItem>
                                <asp:ListItem>ygc</asp:ListItem>
                                <asp:ListItem>traffic</asp:ListItem>
                            </asp:RadioButtonList>
                            <label for="rblAppearanceType">Appearance Type</label>
                            <asp:RadioButtonList runat="server" ID="rblAppearanceType">
                                <asp:ListItem>trailing</asp:ListItem>
                                <asp:ListItem>da Conference</asp:ListItem>
                                <asp:ListItem>administrative hearing</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div id="TRSubTypes" class="subtypes TR">
                            <label for="ddlTrainingCode">Training Code</label>
                            <asp:DropDownList runat="server" CssClass="textbox" ID="ddlTrainingCode">
                                    <asp:ListItem Value='0' Text='Select' />
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                    <asp:ListItem>6</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <Label ID="lblBeginningDate" for="tbBeginningDate">Beginning Date</Label>
                        <asp:TextBox runat="server" ID="tbBeginningDate"></asp:TextBox>
                        <Label ID="lblAccountNumber" for="tbAccountNumber">Account Number</Label>
                        <asp:TextBox runat="server" ID="tbAccountNumber"></asp:TextBox>
                        <div>
                            <asp:Button runat="server" ID="btnSearch" Text="search" OnClick="btnSearchClick" />
                            <asp:Button runat="server" ID="btnClearFields" Text="clear fields"/>
                        </div>
                        <div class="table-responsive">
                            <asp:GridView runat="server" class="table table-striped table-hover" ID="gvSearchResults" GridLines="None" AutoGenerateColumns="false">
                                <Columns>
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
