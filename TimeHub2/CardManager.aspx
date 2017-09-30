<%@ Page Title="" Language="C#" MasterPageFile="~/TimeHub.Master" AutoEventWireup="true" CodeBehind="CardManager.aspx.cs" Inherits="TimeHub2.CardManager" %>

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
    <div class="" role="main" style="min-height: 939px;">
        <div class="">

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Card Manager</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="#">Settings 1</a>
                                        </li>
                                        <li><a href="#">Settings 2</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a class="close-link"><i class="fa fa-close"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="" role="tabpanel" data-example-id="togglable-tabs">
                                <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                                    <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">Overtime</a>
                                    </li>
                                    <li role="presentation" class=""><a href="#tab_content2" role="tab" id="tab2" data-toggle="tab" aria-expanded="false">Court</a>
                                    </li>
                                    <li role="presentation" class=""><a href="#tab_content3" role="tab" id="tab3" data-toggle="tab" aria-expanded="false">Time-Off</a>
                                    </li>
                                    <li role="presentation" class=""><a href="#tab_content4" role="tab" id="tab4" data-toggle="tab" aria-expanded="false">Training</a>
                                    </li>
                                    <li role="presentation" class=""><a href="#tab_content5" role="tab" id="tab5" data-toggle="tab" aria-expanded="false">Equal-Pay</a>
                                    </li>
                                </ul>
                                <div id="myTabContent" class="tab-content">
                                    <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">

                                        <!-- start Overtime -->
                                        <div style="height: 600px; overflow: auto;">
                                            <asp:GridView runat="server" class="table table-striped table-hover" ID="gvRecentRequestsOT" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                                <Columns>
                                                    <asp:BoundField DataField="id" HeaderText="Card Number" />
                                                    <asp:BoundField DataField="beginning_date" HeaderText="Date" DataFormatString="{0:MM-dd-yyyy}" />
                                                    <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                                    <asp:BoundField DataField="total_time" HeaderText="hours" />
                                                    <asp:BoundField DataField="comp_type" HeaderText="Time/ Pay" />
                                                    <asp:BoundField DataField="overtime_code" HeaderText="OT Type" />
                                                    <asp:BoundField DataField="status_id" HeaderText="Status" />
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            edit
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <a href="OvertimeRequest.aspx?id=<%#Eval("id") %>"><i class="fa fa-edit"></i></a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <a href="OvertimeRequest.aspx" class="btn btn-default btn-lg submit">New Overtime Request</a>

                                        <!-- end Overtime -->

                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="tab2">

                                        <!-- start Court -->
                                        <div style="height: 600px; overflow: auto;">
                                            <asp:GridView runat="server" class="table table-striped table-hover" ID="gvRecentRequestsCO" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                                <Columns>
                                                    <asp:BoundField DataField="id" HeaderText="Card Number" />
                                                    <asp:BoundField DataField="beginning_date" HeaderText="Date" DataFormatString="{0:MM-dd-yyyy}" />
                                                    <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                                    <asp:BoundField DataField="total_time" HeaderText="hours" />
                                                    <asp:BoundField DataField="status_id" HeaderText="Status" />
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            edit
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <a href="CourtRequest.aspx?id=<%#Eval("id") %>"><i class="fa fa-edit"></i></a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <a href="CourtRequest.aspx" class="btn btn-default btn-lg submit">New Court Request</a>
                                        
                                        <!-- end Court -->

                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="tab3">
                                        <!-- start Time-Off -->
                                        <div style="height: 600px; overflow: auto;">
                                            <asp:GridView runat="server" class="table table-striped table-hover" ID="gvRecentRequestsTO" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                                <Columns>
                                                    <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                                    <asp:BoundField DataField="beginning_date" HeaderText="Date" DataFormatString="{0:MM-dd-yyyy}" />
                                                    <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                                    <asp:BoundField DataField="total_time" HeaderText="hours" />
                                                    <asp:BoundField DataField="time_used" HeaderText="Time Used" />
                                                    <asp:BoundField DataField="status_id" HeaderText="Status" />
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            edit
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <a href="Time-offRequest.aspx?id=<%#Eval("card_number") %>"><i class="fa fa-edit"></i></a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <a href="Time-OffRequest.aspx" class="btn btn-default btn-lg submit">New Time-Off Request</a>
                                        
                                        <!-- end Time-Off -->
                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="tab_content4" aria-labelledby="tab4">
                                        <!-- start Training -->
                                        <div style="height: 600px; overflow: auto;">
                                            <asp:GridView runat="server" class="table table-striped table-hover" ID="gvRecentRequestsTR" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                                <Columns>
                                                    <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                                    <asp:BoundField DataField="beginning_date" HeaderText="Date" DataFormatString="{0:MM-dd-yyyy}" />
                                                    <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                                    <asp:BoundField DataField="total_time" HeaderText="hours" />
                                                    <asp:BoundField DataField="timepay" HeaderText="Time/ Pay" />
                                                    <asp:BoundField DataField="ot_code" HeaderText="Training Code" />
                                                    <asp:BoundField DataField="status_id" HeaderText="Status" />
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            edit
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <a href="TrainingRequest.aspx?id=<%#Eval("card_number") %>"><i class="fa fa-edit"></i></a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <a href="TrainingRequest.aspx" class="btn btn-default btn-lg submit">New Training Request</a>
                                        
                                        <!-- end Training -->
                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="tab_content5" aria-labelledby="tab5">
                                        <!-- start Equal-Pay -->
                                        <div style="height: 600px; overflow: auto;">
                                            <asp:GridView runat="server" class="table table-striped table-hover" ID="gvRecentRequestsEP" GridLines="None" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found">
                                                <Columns>
                                                    <asp:BoundField DataField="card_number" HeaderText="Card Number" />
                                                    <asp:BoundField DataField="beginning_date" HeaderText="Date" DataFormatString="{0:MM-dd-yyyy}" />
                                                    <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                                    <asp:BoundField DataField="total_time" HeaderText="hours" />
                                                    <asp:BoundField DataField="in_place_rank" HeaderText="Time/ Pay" />
                                                    <asp:BoundField DataField="status_id" HeaderText="Status" />
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            edit
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <a href="Equal-PayRequest.aspx?id=<%#Eval("card_number") %>"><i class="fa fa-edit"></i></a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <a href="Equal-PayRequest.aspx" class="btn btn-default btn-lg submit">New Equal-Pay Request</a>
                                        
                                        <!-- end Equal-Pay -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
</asp:Content>
