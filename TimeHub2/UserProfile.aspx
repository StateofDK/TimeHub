<%@ Page Title="" Language="C#" MasterPageFile="~/TimeHub.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="TimeHub2.UserProfile" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="Vendors/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" />

    <!-- Custom Theme Style -->
    <link href="Vendors/custom.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <!-- page content -->
    <div class="">
        <div class="clearfix"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_content">

                        <div class="col-md-3 col-sm-3 col-xs-12 profile_left">

                            <div class="profile_img">

                                <!-- end of image cropping -->
                                <div id="crop-avatar">
                                    <!-- Current avatar -->
                                    <img class="img-responsive avatar-view" alt="Avatar" title="Change the avatar" src="data:image/png;base64,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" />

                                    <!-- Cropping modal -->
                                    <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button class="close" data-dismiss="modal" type="button">&times;</button>
                                                    <h4 class="modal-title" id="avatar-modal-label">Change Avatar</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="avatar-body">

                                                        <!-- Upload image and data -->
                                                        <div class="avatar-upload">
                                                            <input class="avatar-src" name="avatar_src" type="hidden" />
                                                            <input class="avatar-data" name="avatar_data" type="hidden" />
                                                            <label for="avatarInput">Local upload</label>
                                                            <input class="avatar-input" id="avatarInput" name="avatar_file" type="file" />
                                                        </div>

                                                        <!-- Crop and preview -->
                                                        <div class="row">
                                                            <div class="col-md-9">
                                                                <div class="avatar-wrapper"></div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="avatar-preview preview-lg"></div>
                                                                <div class="avatar-preview preview-md"></div>
                                                                <div class="avatar-preview preview-sm"></div>
                                                            </div>
                                                        </div>

                                                        <div class="row avatar-btns">
                                                            <div class="col-md-9">
                                                                <div class="btn-group">
                                                                    <button class="btn btn-primary" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees">Rotate Left</button>
                                                                    <button class="btn btn-primary" data-method="rotate" data-option="-15" type="button">-15deg</button>
                                                                    <button class="btn btn-primary" data-method="rotate" data-option="-30" type="button">-30deg</button>
                                                                    <button class="btn btn-primary" data-method="rotate" data-option="-45" type="button">-45deg</button>
                                                                </div>
                                                                <div class="btn-group">
                                                                    <button class="btn btn-primary" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees">Rotate Right</button>
                                                                    <button class="btn btn-primary" data-method="rotate" data-option="15" type="button">15deg</button>
                                                                    <button class="btn btn-primary" data-method="rotate" data-option="30" type="button">30deg</button>
                                                                    <button class="btn btn-primary" data-method="rotate" data-option="45" type="button">45deg</button>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <button class="btn btn-primary btn-block avatar-save" type="submit">Done</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- <div class="modal-footer">
                                                    <button class="btn btn-default" data-dismiss="modal" type="button">Close</button>
                                                  </div> -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.modal -->

                                    <!-- Loading state -->
                                    <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
                                </div>
                                <!-- end of image cropping -->

                            </div>

                            <h3>
                                <asp:Label runat="server" ID="lblFullName" ClientIDMode="Static"></asp:Label></h3>
                            <div id="divName" <%--style="display: none"--%>>
                                <asp:TextBox runat="server" ID="tbFirstName" placeholder="First Name" ClientIDMode="Static"></asp:TextBox>
                                <asp:TextBox runat="server" ID="tbMiddleInitial" placeholder="Middle Initial" ClientIDMode="Static"></asp:TextBox>
                                <asp:TextBox runat="server" ID="tbLastName" placeholder="Last Name" ClientIDMode="Static"></asp:TextBox>
                                <asp:TextBox runat="server" ID="tbStar" placeholder="Star" ClientIDMode="Static"></asp:TextBox>
                            </div>
                            <ul class="list-unstyled user_data">
                                <li><i class="fa fa-map-marker user-profile-icon"></i>
                                    <h4 style="display: inline">
                                        <asp:Label runat="server" ID="lblAssignment" ClientIDMode="Static"></asp:Label></h4>
                                    <asp:DropDownList runat="server" ID="ddlAssignment" ClientIDMode="Static" Style="display: inline"></asp:DropDownList>
                                </li>

                                <li>
                                    <i class="fa fa-clock-o user-profile-icon"></i>
                                    <h4 style="display: inline">
                                        <asp:Label runat="server" ID="lblShift" ClientIDMode="Static"></asp:Label></h4>
                                    <%--<h4 style="display:inline"><asp:Label runat="server" ID="lblShift" ClientIDMode="Static" style="display:inline"></asp:Label></h4>--%>
                                    <asp:DropDownList runat="server" ID="ddlShift" ClientIDMode="Static"></asp:DropDownList>
                                </li>

                                <li>
                                    <i class="fa fa-briefcase user-profile-icon"></i>
                                    <h4 style="display: inline">
                                        <asp:Label runat="server" ID="lblRank" ClientIDMode="Static"></asp:Label></h4>
                                    <asp:DropDownList runat="server" ID="ddlRank" ClientIDMode="Static" Style="display: inline"></asp:DropDownList>
                                </li>

                                <li class="m-top-xs">
                                    <i class="fa fa-phone"></i>
                                    <h4 style="display: inline">
                                        <asp:Label runat="server" ID="lblPhone" Style="display: inline" ClientIDMode="Static"></asp:Label></h4>
                                    <asp:TextBox runat="server" ID="tbPhone" placeholder="Primary Phone" ClientIDMode="Static"></asp:TextBox>
                                    <asp:Label runat="server" ID="lblPhoneType" ClientIDMode="Static"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlPhoneType" placeholder="Phone Type" ClientIDMode="Static"></asp:DropDownList>
                                </li>

                                <li class="m-top-xs">
                                    <i class="fa fa-envelope"></i>
                                    <a>
                                        <asp:Label runat="server" ID="lblEmail" Style="display: inline" ClientIDMode="Static"></asp:Label></a>
                                    <asp:TextBox runat="server" ID="tbEmailAddress" placeholder="Email Address" ClientIDMode="Static"></asp:TextBox>
                                </li>
                            </ul>

                            <a class="btn btn-success" id="btnEditProfile" data-toggle="modal" data-target="#modalEditProfile"><i class="fa fa-edit m-right-xs"></i>Edit Profile</a>
                            <asp:Button ID="btnSaveProfileChanges" runat="server" class="btn btn-success" Text="Save Changes" ClientIDMode="Static" OnClick="UpdateProfile" />
                            <a class="btn btn-success" id="btnCancel"><i class="fa fa-times m-right-xs"></i>Cancel</a>


                            <br />

                            <!-- Modal -->
                            <div id="myModal" class="modal fade" role="dialog">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2>Edit Profile</h2>
                                        </div>
                                    </div>
                                    <!-- End Modal content-->
                                </div>
                            </div>
                            <!-- End Modal -->

                        </div>
                        <div class="col-md-9 col-sm-9 col-xs-12">

                            <div class="profile_title">
                                <div class="col-md-6">
                                    <h2>Total Hours by Month</h2>
                                </div>
                            </div>
                            <!-- start of user-activity-graph -->
                            <div id="graph_bar" style="width: 100%; height: 280px;"></div>
                            <!-- end of user-activity-graph -->

                            <div class="" role="tabpanel" data-example-id="togglable-tabs">
                                <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                                    <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">Recent Activity</a>
                                    </li>
                                    <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">Top Jobs</a>
                                    </li>
                                </ul>
                                <div id="myTabContent" class="tab-content">
                                    <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">

                                        <!-- start recent activity -->
                                        <ul class="messages" id="ulRecentActivity">
                                            <asp:Repeater runat="server" ID="rptrRecentActivity">
                                                <ItemTemplate>
                                                    <li>
                                                        <div class="message_date">
                                                            <p class="month"><%# Eval("activity_month")%> <%# Eval("activity_day")%>, <%# Eval("activity_year")%></p>

                                                            <p class="time"><%# Eval("activity_time")%> hrs</p>
                                                        </div>
                                                        <div class="message_wrapper">
                                                            <h4 class="heading"><%# Eval("long_request_type")%> request <%# Eval("activity_type")%></h4>
                                                            <blockquote class="message"><%# Eval("long_request_type")%> request number <%# Eval("id")%> for <%# Eval("total_time") %> hours was <%# Eval("activity_type")%></blockquote>
                                                            <br />
                                                            <p class="url">
                                                                <span class="fs1 text-info" aria-hidden="true" data-icon=""></span>
                                                                <a href="#"><i class="fa fa-paperclip"></i>View request</a>
                                                            </p>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                        <!-- end recent activity -->

                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">

                                        <!-- begin top jobs -->
                                        <table class="data table table-striped no-margin">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Event Number</th>
                                                    <th>Client</th>
                                                    <th>Hours Worked</th>
                                                    <th>Percent of Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptrTopJobs">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>#</td>
                                                            <td><%# Eval("event_number")%></td>
                                                            <td><%# Eval("client")%></td>
                                                            <td><%# Eval("total_hours")%></td>
                                                            <td class="vertical-align-mid">
                                                                <div class="progress">
                                                                    <div class="progress-bar progress-bar-success" data-transitiongoal="<%# Eval("percent_of_total")%>"></div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>

                                        <!-- end top jobs -->

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /page content -->
</asp:Content>

<asp:Content ID="foot" ContentPlaceHolderID="foot" runat="server">
    <!-- jQuery -->
    <script src="Vendors/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="Vendors/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="Vendors/fastclick.js"></script>
    <!-- NProgress -->
    <script src="Vendors/nprogress.js"></script>
    <!-- morris.js -->
    <script src="Vendors/raphael.min.js"></script>
    <script src="Vendors/morris.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="Vendors/bootstrap-progressbar.min.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="Vendors/moment.min.js"></script>
    <script src="Vendors/daterangepicker.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="Vendors/custom.js"></script>

    <%--<script type="text/javascript">
        $(function () {
            Morris.Bar({
                element: 'graph_bar',
                data: $.parseJSON(TotalHours()),
                xkey: 'period',
                hideHover: 'auto',
                barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
                ykeys: ['Hours worked', 'sorned'],
                labels: ['Hours worked', 'SORN'],
                xLabelAngle: 60,
                resize: true
            })

            $MENU_TOGGLE.on('click', function () {
                $(window).resize();
            });
        });

        function TotalHours() {
            var data = "";
            $.ajax({
                type: 'POST',
                url: 'Webform1.aspx/GetPiechartData',
                dataType: 'json',
                async: false,
                contentType: "application/json; charset=utf-8",
                data: {},
                success: function (result) {
                    data = result.d;
                },
                error: function (xhr, status, error) {
                    alert(error);
                }
            });

            return data;
        }
    </script>--%>

    <script type="text/javascript">
        $(function () {
            GetTotalHours()
            $MENU_TOGGLE.on('click', function () {
                $(window).resize();
            });
        });

        function makeChart(data) {
            Morris.Bar({
                element: 'graph_bar',
                data: data,
                xkey: 'display_date',
                hideHover: 'auto',
                barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
                ykeys: ['total_hours'],
                labels: ['Hours worked'],
                xLabelAngle: 60,
                resize: true
            });

        }

        function GetTotalHours() {
            var data = "";
            var url = 'api/RemoteData?CreditedUser=' + TIMEHUB.userId;
            $.ajax({
                type: 'GET',
                url: url,
                dataType: 'json',
                async: true,
                contentType: "application/json; charset=utf-8",
                data: {},
                success: function (result) {
                    data = result.Table;
                    makeChart(data);
                },
                error: function (xhr, status, error) {
                    alert(error);
                }
            });

            return data;
        };

    </script>

    <%--<script>
        $(function () {
            Morris.Bar({
                element: 'graph_bar',
                data: [
                  { "period": "Jan", "Hours worked": 80 },
                  { "period": "Feb", "Hours worked": 125 },
                  { "period": "Mar", "Hours worked": 176 },
                  { "period": "Apr", "Hours worked": 224 },
                  { "period": "May", "Hours worked": 265 },
                  { "period": "Jun", "Hours worked": 314 },
                  { "period": "Jul", "Hours worked": 347 },
                  { "period": "Aug", "Hours worked": 287 },
                  { "period": "Sep", "Hours worked": 240 },
                  { "period": "Oct", "Hours worked": 211 }
                ],
                xkey: 'period',
                hideHover: 'auto',
                barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
                ykeys: ['Hours worked'],
                labels: ['Hours worked'],
                xLabelAngle: 60,
                resize: true
            });

            $MENU_TOGGLE.on('click', function () {
                $(window).resize();
            });
        });
    </script>--%>

    <!-- datepicker -->
    <script type="text/javascript">
        $(document).ready(function () {

            var cb = function (start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                //alert("Callback has fired: [" + start.format('MMMM D, YYYY') + " to " + end.format('MMMM D, YYYY') + ", label = " + label + "]");
            }

            var optionSet1 = {
                startDate: moment().subtract(29, 'days'),
                endDate: moment(),
                minDate: '01/01/2012',
                maxDate: '12/31/2015',
                dateLimit: {
                    days: 60
                },
                showDropdowns: true,
                showWeekNumbers: true,
                timePicker: false,
                timePickerIncrement: 1,
                timePicker12Hour: true,
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                opens: 'left',
                buttonClasses: ['btn btn-default'],
                applyClass: 'btn-small btn-primary',
                cancelClass: 'btn-small',
                format: 'MM/DD/YYYY',
                separator: ' to ',
                locale: {
                    applyLabel: 'Submit',
                    cancelLabel: 'Clear',
                    fromLabel: 'From',
                    toLabel: 'To',
                    customRangeLabel: 'Custom',
                    daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
                    monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                    firstDay: 1
                }
            };
            $('#reportrange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));
            $('#reportrange').daterangepicker(optionSet1, cb);
            $('#reportrange').on('show.daterangepicker', function () {
                console.log("show event fired");
            });
            $('#reportrange').on('hide.daterangepicker', function () {
                console.log("hide event fired");
            });
            $('#reportrange').on('apply.daterangepicker', function (ev, picker) {
                console.log("apply event fired, start/end dates are " + picker.startDate.format('MMMM D, YYYY') + " to " + picker.endDate.format('MMMM D, YYYY'));
            });
            $('#reportrange').on('cancel.daterangepicker', function (ev, picker) {
                console.log("cancel event fired");
            });
            $('#options1').click(function () {
                $('#reportrange').data('daterangepicker').setOptions(optionSet1, cb);
            });
            $('#options2').click(function () {
                $('#reportrange').data('daterangepicker').setOptions(optionSet2, cb);
            });
            $('#destroy').click(function () {
                $('#reportrange').data('daterangepicker').remove();
            });
        });
    </script>
    <!-- /datepicker -->
    <!-- profile edit fields -->
    <script type="text/javascript">
        function HideEditFields() {
            $('#lblFullName').show();
            $('#tbFirstName').hide();
            $('#tbLastName').hide();
            $('#tbMiddleInitial').hide();
            $('#tbStar').hide();

            $('#lblAssignment').show();
            $('#ddlAssignment').hide();

            $('#lblRank').show();
            $('#ddlRank').hide();


            $('#lblShift').show();
            $('#ddlShift').hide();

            $('#lblPhone').show();
            $('#lblPhoneType').show();
            $('#tbPhone').hide();
            $('#ddlPhoneType').hide();

            $('#lblEmail').show();
            $('#tbEmailAddress').hide();

            $('#btnEditProfile').show();
            $('#btnSaveProfileChanges').hide()
            $('#btnCancel').hide();
        };

        function ShowEditFields() {
            $('#lblFullName').hide();
            $('#tbFirstName').show();
            $('#tbLastName').show();
            $('#tbMiddleInitial').show()
            $('#tbStar').show();

            $('#lblAssignment').hide();
            $('#ddlAssignment').show();

            $('#lblRank').hide();
            $('#ddlRank').show();

            $('#lblShift').hide();
            $('#ddlShift').show();

            $('#lblPhone').hide();
            $('#lblPhoneType').hide();
            $('#tbPhone').show();
            $('#ddlPhoneType').show();

            $('#lblEmail').hide();
            $('#tbEmailAddress').show();

            $('#btnEditProfile').hide();
            $('#btnSaveProfileChanges').show()
            $('#btnCancel').show();
        };

        $(document).ready(function () {
            HideEditFields();
        });

        $(function () {
            $('#btnEditProfile').click(function () {
                ShowEditFields();
            })
        });

        $(function () {
            $('#btnCancel').click(function () {
                HideEditFields();
            })
        });
    </script>
    <!-- /profile edit fields -->
</asp:Content>
