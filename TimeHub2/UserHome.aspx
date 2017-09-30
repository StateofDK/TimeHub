<%@ Page Title="" Language="C#" MasterPageFile="~/TimeHub.Master" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="TimeHub2.UserHome" %>

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
    <!-- iCheck -->
    <link href="Vendors/green.css" rel="stylesheet" />
    <!-- bootstrap-progressbar -->
    <link href="Vendors/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet" />
    <!-- jVectorMap -->
    <link href="Vendors/jquery-jvectormap-2.0.3.css" rel="stylesheet" />

    <!-- Datatables -->
    <link href="Vendors/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="Vendors/buttons.bootstrap.min.css" rel="stylesheet" />
    <link href="Vendors/fixedHeader.bootstrap.min.css" rel="stylesheet" />
    <link href="Vendors/responsive.bootstrap.min.css" rel="stylesheet" />
    <link href="Vendors/scroller.bootstrap.min.css" rel="stylesheet" />

    <!-- Custom Theme Style -->
    <link href="Vendors/custom.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainContentPlaceHolder" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <!-- top tiles -->
    <div class="row top_tiles">
        <div class="animated flipInY col-md-4">
            <a href="OvertimeRequestTest.aspx">
                <div class="tile-stats">
                    <div class="icon">
                        <i class="fa fa-edit"></i>
                    </div>
                    <br />
                    <h3>New Overtime Card</h3>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <p>Create new overtime pay request</p>
                    <br />
                </div>
            </a>
        </div>
        <div class="col-md-8">
            <div class="row">
                <div class="animated flipInY col-md-6">
                    <a href="CourtRequestTest.aspx">
                        <div class="tile-stats">
                            <div class="icon">
                                <i class="fa fa-edit"></i>
                            </div>
                            <br />
                            <h3>New Court Card</h3>
                            <br />
                            <br />
                            <p>Create new court pay request</p>
                            <br />
                        </div>
                    </a>
                </div>
                <div class="animated flipInY col-md-6">
                    <a href="TrainingRequest.aspx">
                        <div class="tile-stats">
                            <div class="icon">
                                <i class="fa fa-edit"></i>
                            </div>
                            <br />
                            <h3>New Training Card</h3>
                            <br />
                            <br />
                            <p>Create new training pay request</p>
                            <br />
                        </div>
                    </a>
                </div>
            </div>
            <div class="row">
                <div class="animated flipInY col-md-6">
                    <a href="Time-OffRequest.aspx">
                        <div class="tile-stats">
                            <div class="icon">
                                <i class="fa fa-edit"></i>
                            </div>
                            <br />
                            <h3>New Time-Off Card</h3>
                            <br />
                            <br />
                            <p>Create new time-off request</p>
                            <br />
                        </div>
                    </a>
                </div>
                <div class="animated flipInY col-md-6">
                    <a href="Equal-PayRequest.aspx">
                        <div class="tile-stats">
                            <div class="icon">
                                <i class="fa fa-edit"></i>
                            </div>
                            <br />
                            <h3>New Equal Pay Card</h3>
                            <br />
                            <br />
                            <p>Create new equal pay request</p>
                            <br />
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Recent Requests <small>Users</small></h2>
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
                    <div id="datatable-fixed-header_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="table-responsive">
                                    <asp:GridView runat="server" class="table table-striped table-hover table-bordered dataTable no-footer" ID="gvRecentRequests" GridLines="None" AutoGenerateColumns="false" role="grid">
                                        <Columns>
                                            <asp:BoundField DataField="card_id" HeaderText="Card ID" />
                                            <asp:BoundField DataField="RequestType" HeaderText="Card Type" />
                                            <asp:BoundField DataField="beginning_date" HeaderText="Date" DataFormatString="{0:MM-dd-yyyy}" />
                                            <asp:BoundField DataField="beginning_time" HeaderText="time" />
                                            <asp:BoundField DataField="total_time" HeaderText="hours" />
                                            <asp:BoundField DataField="status_id" HeaderText="Status" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    edit
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <a href="<%#Eval("RequestType") %>Request.aspx?id=<%#Eval("card_number") %>">edit/view</a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle CssClass="cursor-pointer" />
                                    </asp:GridView>
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
    <!-- Chart.js -->
    <script src="Vendors/Chart.min.js"></script>
    <!-- gauge.js -->
    <script src="Vendors/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="Vendors/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="Vendors/icheck.min.js"></script>
    <!-- Skycons -->
    <script src="Vendors/skycons.js"></script>
    <!-- Flot -->
    <script src="Vendors/jquery.flot.js"></script>
    <script src="Vendors/jquery.flot.pie.js"></script>
    <script src="Vendors/jquery.flot.time.js"></script>
    <script src="Vendors/jquery.flot.stack.js"></script>
    <script src="Vendors/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="Vendors/jquery.flot.orderBars.js"></script>
    <script src="Vendors/date.js"></script>
    <script src="Vendors/jquery.flot.spline.js"></script>
    <script src="Vendors/curvedLines.js"></script>
    <!-- jVectorMap -->
    <script src="Vendors/jquery-jvectormap-2.0.3.min.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="Vendors/moment.min.js"></script>
    <script src="Vendors/daterangepicker.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="Vendors/custom.js"></script>

    <!-- Datatables -->
    <script src="Vendors/jquery.dataTables.min.js"></script>
    <link href="Vendors/dataTables.bootstrap.min.css" rel="stylesheet" />
    <script src="Vendors/dataTables.buttons.min.js"></script>
    <script src="Vendors/buttons.bootstrap.min.js"></script>
    <script src="Vendors/buttons.flash.min.js"></script>
    <script src="Vendors/buttons.html5.min.js"></script>
    <script src="Vendors/buttons.print.min.js"></script>
    <script src="Vendors/dataTables.fixedHeader.min.js"></script>
    <script src="Vendors/dataTables.keyTable.min.js"></script>
    <script src="Vendors/dataTables.responsive.min.js"></script>
    <script src="Vendors/responsive.bootstrap.js"></script>
    <script src="Vendors/dataTables.scroller.min.js"></script>
    <script src="Vendors/jszip.min.js"></script>
    <script src="Vendors/pdfmake.min.js"></script>
    <script src="Vendors/vfs_fonts.js"></script>

    <!-- Flot -->
    <script>
        $(document).ready(function () {
            var data1 = [
              [gd(2012, 1, 1), 17],
              [gd(2012, 1, 2), 74],
              [gd(2012, 1, 3), 6],
              [gd(2012, 1, 4), 39],
              [gd(2012, 1, 5), 20],
              [gd(2012, 1, 6), 85],
              [gd(2012, 1, 7), 7]
            ];

            var data2 = [
              [gd(2012, 1, 1), 82],
              [gd(2012, 1, 2), 23],
              [gd(2012, 1, 3), 66],
              [gd(2012, 1, 4), 9],
              [gd(2012, 1, 5), 119],
              [gd(2012, 1, 6), 6],
              [gd(2012, 1, 7), 9]
            ];
            $("#canvas_dahs").length && $.plot($("#canvas_dahs"), [
              data1, data2
            ], {
                series: {
                    lines: {
                        show: false,
                        fill: true
                    },
                    splines: {
                        show: true,
                        tension: 0.4,
                        lineWidth: 1,
                        fill: 0.4
                    },
                    points: {
                        radius: 0,
                        show: true
                    },
                    shadowSize: 2
                },
                grid: {
                    verticalLines: true,
                    hoverable: true,
                    clickable: true,
                    tickColor: "#d5d5d5",
                    borderWidth: 1,
                    color: '#fff'
                },
                colors: ["rgba(38, 185, 154, 0.38)", "rgba(3, 88, 106, 0.38)"],
                xaxis: {
                    tickColor: "rgba(51, 51, 51, 0.06)",
                    mode: "time",
                    tickSize: [1, "day"],
                    //tickLength: 10,
                    axisLabel: "Date",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 10
                },
                yaxis: {
                    ticks: 8,
                    tickColor: "rgba(51, 51, 51, 0.06)",
                },
                tooltip: false
            });

            function gd(year, month, day) {
                return new Date(year, month - 1, day).getTime();
            }
        });
    </script>
    <!-- /Flot -->

    <!-- jVectorMap -->
    <script src="Vendors/jquery-jvectormap-world-mill-en.js"></script>
    <script src="Vendors/jquery-jvectormap-us-aea-en.js"></script>
    <script src="Vendors/gdp-data.js"></script>
    <script>
        $(document).ready(function () {
            $('#world-map-gdp').vectorMap({
                map: 'world_mill_en',
                backgroundColor: 'transparent',
                zoomOnScroll: false,
                series: {
                    regions: [{
                        values: gdpData,
                        scale: ['#E6F2F0', '#149B7E'],
                        normalizeFunction: 'polynomial'
                    }]
                },
                onRegionTipShow: function (e, el, code) {
                    el.html(el.html() + ' (GDP - ' + gdpData[code] + ')');
                }
            });
        });
    </script>
    <!-- /jVectorMap -->

    <!-- Skycons -->
    <script>
        $(document).ready(function () {
            var icons = new Skycons({
                "color": "#73879C"
            }),
              list = [
                "clear-day", "clear-night", "partly-cloudy-day",
                "partly-cloudy-night", "cloudy", "rain", "sleet", "snow", "wind",
                "fog"
              ],
              i;

            for (i = list.length; i--;)
                icons.set(list[i], list[i]);

            icons.play();
        });
    </script>
    <!-- /Skycons -->

    <!-- Doughnut Chart -->
    <script>
        $(document).ready(function () {
            var options = {
                legend: false,
                responsive: false
            };

            new Chart(document.getElementById("canvas1"), {
                type: 'doughnut',
                tooltipFillColor: "rgba(51, 51, 51, 0.55)",
                data: {
                    labels: [
                      "Symbian",
                      "Blackberry",
                      "Other",
                      "Android",
                      "IOS"
                    ],
                    datasets: [{
                        data: [15, 20, 30, 10, 30],
                        backgroundColor: [
                          "#BDC3C7",
                          "#9B59B6",
                          "#E74C3C",
                          "#26B99A",
                          "#3498DB"
                        ],
                        hoverBackgroundColor: [
                          "#CFD4D8",
                          "#B370CF",
                          "#E95E4F",
                          "#36CAAB",
                          "#49A9EA"
                        ]
                    }]
                },
                options: options
            });
        });
    </script>
    <!-- /Doughnut Chart -->

    <!-- bootstrap-daterangepicker -->
    <script>
        $(document).ready(function () {

            var cb = function (start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
            };

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
    <!-- /bootstrap-daterangepicker -->

    <!-- gauge.js -->
    <script>
        var opts = {
            lines: 12,
            angle: 0,
            lineWidth: 0.4,
            pointer: {
                length: 0.75,
                strokeWidth: 0.042,
                color: '#1D212A'
            },
            limitMax: 'false',
            colorStart: '#1ABC9C',
            colorStop: '#1ABC9C',
            strokeColor: '#F0F3F3',
            generateGradient: true
        };
        var target = document.getElementById('foo'),
            gauge = new Gauge(target).setOptions(opts);

        gauge.maxValue = 6000;
        gauge.animationSpeed = 32;
        gauge.set(3200);
        gauge.setTextField(document.getElementById("gauge-text"));
    </script>
    <!-- /gauge.js -->

    <!-- Datatables -->
    <script>
        $(document).ready(function () {
            var handleDataTableButtons = function () {
                if ($("#datatable-buttons").length) {
                    $("#datatable-buttons").DataTable({
                        dom: "Bfrtip",
                        buttons: [
                          {
                              extend: "copy",
                              className: "btn-sm"
                          },
                          {
                              extend: "csv",
                              className: "btn-sm"
                          },
                          {
                              extend: "excel",
                              className: "btn-sm"
                          },
                          {
                              extend: "pdfHtml5",
                              className: "btn-sm"
                          },
                          {
                              extend: "print",
                              className: "btn-sm"
                          },
                        ],
                        responsive: true
                    });
                }
            };

            TableManageButtons = function () {
                "use strict";
                return {
                    init: function () {
                        handleDataTableButtons();
                    }
                };
            }();

            $('#datatable').dataTable();
            $('#datatable-keytable').DataTable({
                keys: true
            });

            $('#datatable-responsive').DataTable({
                responsive: true
            });

            $('#datatable-scroller').DataTable({
                ajax: "js/datatables/json/scroller-demo.json",
                deferRender: true,
                scrollY: 380,
                scrollCollapse: true,
                scroller: true
            });

            var table = $('#gvRecentRequests').DataTable({
                fixedHeader: true
            });

            TableManageButtons.init();
        });
    </script>
    <!-- /Datatables -->
</asp:Content>
