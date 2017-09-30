<%@ Page Title="" Language="C#" MasterPageFile="~/TimeHub.Master" AutoEventWireup="true" CodeBehind="Equal-PayRequestTest.aspx.cs" Inherits="TimeHub2.Equal_PayRequestTest" %>

<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, min-height=device-height, initial-scale=1" />

    <title>TimeHub | SFPD</title>

    <!-- Bootstrap -->
    <link href="Vendors/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" />
    <!-- iCheck -->
    <link href="Vendors/green.css" rel="stylesheet" />
    <!-- bootstrap-wysiwyg -->
    <link href="Vendors/prettify.min.css" rel="stylesheet" />
    <!-- Select2 -->
    <link href="Vendors/select2.min.css" rel="stylesheet" />
    <!-- Switchery -->
    <link href="Vendors/switchery.min.css" rel="stylesheet" />
    <!-- starrr -->
    <link href="Vendors/starrr.css" rel="stylesheet" />
    <!-- Custom Theme Style -->
    <link href="Vendors/custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <div class="page-title">
        <div class="title_left">
            <h3>Equal-Pay Compensation Request</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-9 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <div class="row">
                        <div class="col-md-4 col-sm-12 col-xs-12 form-group">
                            <label>Last Name</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>

                        <div class="col-md-4 col-sm-12 col-xs-12 form-group">
                            <label>First Name</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>

                        <div class="col-md-4 col-sm-12 col-xs-12 form-group">
                            <label>Middle Initial</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                            <label>Assignment</label>
                            <asp:DropDownList runat="server" ID="ddlAssignment" class="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                            <label>Detailed To</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                            <label>Beginning Date of Overtime</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                            <label>Ending Date of Overtime</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                            <label>Name of person worked in place of</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group form-horizontal">
                            <label>Rank</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-xs-12" style="height:100%;">
            <div class="x_panel">
                <div class="x_content">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                            <label>Date Submitted</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                            <label>Beginning Time</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                            <label>Ending Time</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                            <label>Total Time Worked</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">

                    <div class="row">
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                            <label>Signature</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                        <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                            <label>Approved by Commanding Officer</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 col-sm-12 col-xs-12 form-group">
                            <label>Rank</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12 form-group">
                            <label>Star</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12 form-group">
                            <label>Rank</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12 form-group">
                            <label>Star</label>
                            <input type="text" placeholder=".col-md-3" class="form-control">
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <div class="row">
                        <div class="form-group text-center">
                            <asp:Button runat="server" ID="Button1" class="btn btn-success" Text="Save" />
                            <asp:Button runat="server" ID="Button2" class="btn btn-primary" Text="Cancel" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Foot" ContentPlaceHolderID="foot" runat="server">
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
    <!-- bootstrap-wysiwyg -->
    <script src="Vendors/bootstrap-wysiwyg.min.js"></script>
    <script src="Vendors/jquery.hotkeys.js"></script>
    <script src="Vendors/prettify.js"></script>

    <!-- jQuery Tags Input -->
    <script src="Vendors/jquery.tagsinput.js"></script>
    <!-- Switchery -->
    <script src="Vendors/switchery.min.js"></script>
    <!-- Select2 -->
    <script src="Vendors/select2.full.min.js"></script>
    <!-- Parsley -->
    <script src="Vendors/parsley.min.js"></script>
    <!-- Autosize -->
    <script src="Vendors/autosize.min.js"></script>
    <!-- jQuery autocomplete -->
    <script src="Vendors/jquery.autocomplete.min.js"></script>
    <!-- starrr -->
    <script src="Vendors/starrr.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="Vendors/custom.js"></script>

    <!-- Begin TimeCalc -->
    <script type="text/javascript">
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
    <!-- End TimeCalc -->

    <!-- bootstrap-daterangepicker -->
    <script>
        $(document).ready(function () {
            $('#birthday').daterangepicker({
                singleDatePicker: true,
                calender_style: "picker_4"
            }, function (start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
            });
        });
    </script>
    <!-- /bootstrap-daterangepicker -->

    <!-- bootstrap-wysiwyg -->
    <script>
        $(document).ready(function () {
            function initToolbarBootstrapBindings() {
                var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
                    'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
                    'Times New Roman', 'Verdana'
                ],
                  fontTarget = $('[title=Font]').siblings('.dropdown-menu');
                $.each(fonts, function (idx, fontName) {
                    fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
                });
                $('a[title]').tooltip({
                    container: 'body'
                });
                $('.dropdown-menu input').click(function () {
                    return false;
                })
                  .change(function () {
                      $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');
                  })
                  .keydown('esc', function () {
                      this.value = '';
                      $(this).change();
                  });

                $('[data-role=magic-overlay]').each(function () {
                    var overlay = $(this),
                      target = $(overlay.data('target'));
                    overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
                });

                if ("onwebkitspeechchange" in document.createElement("input")) {
                    var editorOffset = $('#editor').offset();

                    $('.voiceBtn').css('position', 'absolute').offset({
                        top: editorOffset.top,
                        left: editorOffset.left + $('#editor').innerWidth() - 35
                    });
                } else {
                    $('.voiceBtn').hide();
                }
            }

            function showErrorAlert(reason, detail) {
                var msg = '';
                if (reason === 'unsupported-file-type') {
                    msg = "Unsupported format " + detail;
                } else {
                    console.log("error uploading file", reason, detail);
                }
                $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
                  '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
            }

            initToolbarBootstrapBindings();

            $('#editor').wysiwyg({
                fileUploadError: showErrorAlert
            });

            window.prettyPrint;
            prettyPrint();
        });
    </script>
    <!-- /bootstrap-wysiwyg -->

    <!-- Select2 -->
    <script>
        $(document).ready(function () {
            $(".select2_single").select2({
                placeholder: "Select a state",
                allowClear: true
            });
            $(".select2_group").select2({});
            $(".select2_multiple").select2({
                maximumSelectionLength: 4,
                placeholder: "With Max Selection limit 4",
                allowClear: true
            });
        });
    </script>
    <!-- /Select2 -->

    <!-- jQuery Tags Input -->
    <script>
        function onAddTag(tag) {
            alert("Added a tag: " + tag);
        }

        function onRemoveTag(tag) {
            alert("Removed a tag: " + tag);
        }

        function onChangeTag(input, tag) {
            alert("Changed a tag: " + tag);
        }

        $(document).ready(function () {
            $('#tags_1').tagsInput({
                width: 'auto'
            });
        });
    </script>
    <!-- /jQuery Tags Input -->

    <!-- Parsley -->
    <script>
        $(document).ready(function () {
            $.listen('parsley:field:validate', function () {
                validateFront();
            });
            $('#demo-form .btn').on('click', function () {
                $('#demo-form').parsley().validate();
                validateFront();
            });
            var validateFront = function () {
                if (true === $('#demo-form').parsley().isValid()) {
                    $('.bs-callout-info').removeClass('hidden');
                    $('.bs-callout-warning').addClass('hidden');
                } else {
                    $('.bs-callout-info').addClass('hidden');
                    $('.bs-callout-warning').removeClass('hidden');
                }
            };
        });

        $(document).ready(function () {
            $.listen('parsley:field:validate', function () {
                validateFront();
            });
            $('#demo-form2 .btn').on('click', function () {
                $('#demo-form2').parsley().validate();
                validateFront();
            });
            var validateFront = function () {
                if (true === $('#demo-form2').parsley().isValid()) {
                    $('.bs-callout-info').removeClass('hidden');
                    $('.bs-callout-warning').addClass('hidden');
                } else {
                    $('.bs-callout-info').addClass('hidden');
                    $('.bs-callout-warning').removeClass('hidden');
                }
            };
        });
        try {
            hljs.initHighlightingOnLoad();
        } catch (err) { }
    </script>
    <!-- /Parsley -->

    <!-- Autosize -->
    <script>
        $(document).ready(function () {
            autosize($('.resizable_textarea'));
        });
    </script>
    <!-- /Autosize -->

    <!-- jQuery autocomplete -->
    <script>
        $(document).ready(function () {
            var countries = { AD: "Andorra", A2: "Andorra Test", AE: "United Arab Emirates", AF: "Afghanistan", AG: "Antigua and Barbuda", AI: "Anguilla", AL: "Albania", AM: "Armenia", AN: "Netherlands Antilles", AO: "Angola", AQ: "Antarctica", AR: "Argentina", AS: "American Samoa", AT: "Austria", AU: "Australia", AW: "Aruba", AX: "Åland Islands", AZ: "Azerbaijan", BA: "Bosnia and Herzegovina", BB: "Barbados", BD: "Bangladesh", BE: "Belgium", BF: "Burkina Faso", BG: "Bulgaria", BH: "Bahrain", BI: "Burundi", BJ: "Benin", BL: "Saint Barthélemy", BM: "Bermuda", BN: "Brunei", BO: "Bolivia", BQ: "British Antarctic Territory", BR: "Brazil", BS: "Bahamas", BT: "Bhutan", BV: "Bouvet Island", BW: "Botswana", BY: "Belarus", BZ: "Belize", CA: "Canada", CC: "Cocos [Keeling] Islands", CD: "Congo - Kinshasa", CF: "Central African Republic", CG: "Congo - Brazzaville", CH: "Switzerland", CI: "Côte d’Ivoire", CK: "Cook Islands", CL: "Chile", CM: "Cameroon", CN: "China", CO: "Colombia", CR: "Costa Rica", CS: "Serbia and Montenegro", CT: "Canton and Enderbury Islands", CU: "Cuba", CV: "Cape Verde", CX: "Christmas Island", CY: "Cyprus", CZ: "Czech Republic", DD: "East Germany", DE: "Germany", DJ: "Djibouti", DK: "Denmark", DM: "Dominica", DO: "Dominican Republic", DZ: "Algeria", EC: "Ecuador", EE: "Estonia", EG: "Egypt", EH: "Western Sahara", ER: "Eritrea", ES: "Spain", ET: "Ethiopia", FI: "Finland", FJ: "Fiji", FK: "Falkland Islands", FM: "Micronesia", FO: "Faroe Islands", FQ: "French Southern and Antarctic Territories", FR: "France", FX: "Metropolitan France", GA: "Gabon", GB: "United Kingdom", GD: "Grenada", GE: "Georgia", GF: "French Guiana", GG: "Guernsey", GH: "Ghana", GI: "Gibraltar", GL: "Greenland", GM: "Gambia", GN: "Guinea", GP: "Guadeloupe", GQ: "Equatorial Guinea", GR: "Greece", GS: "South Georgia and the South Sandwich Islands", GT: "Guatemala", GU: "Guam", GW: "Guinea-Bissau", GY: "Guyana", HK: "Hong Kong SAR China", HM: "Heard Island and McDonald Islands", HN: "Honduras", HR: "Croatia", HT: "Haiti", HU: "Hungary", ID: "Indonesia", IE: "Ireland", IL: "Israel", IM: "Isle of Man", IN: "India", IO: "British Indian Ocean Territory", IQ: "Iraq", IR: "Iran", IS: "Iceland", IT: "Italy", JE: "Jersey", JM: "Jamaica", JO: "Jordan", JP: "Japan", JT: "Johnston Island", KE: "Kenya", KG: "Kyrgyzstan", KH: "Cambodia", KI: "Kiribati", KM: "Comoros", KN: "Saint Kitts and Nevis", KP: "North Korea", KR: "South Korea", KW: "Kuwait", KY: "Cayman Islands", KZ: "Kazakhstan", LA: "Laos", LB: "Lebanon", LC: "Saint Lucia", LI: "Liechtenstein", LK: "Sri Lanka", LR: "Liberia", LS: "Lesotho", LT: "Lithuania", LU: "Luxembourg", LV: "Latvia", LY: "Libya", MA: "Morocco", MC: "Monaco", MD: "Moldova", ME: "Montenegro", MF: "Saint Martin", MG: "Madagascar", MH: "Marshall Islands", MI: "Midway Islands", MK: "Macedonia", ML: "Mali", MM: "Myanmar [Burma]", MN: "Mongolia", MO: "Macau SAR China", MP: "Northern Mariana Islands", MQ: "Martinique", MR: "Mauritania", MS: "Montserrat", MT: "Malta", MU: "Mauritius", MV: "Maldives", MW: "Malawi", MX: "Mexico", MY: "Malaysia", MZ: "Mozambique", NA: "Namibia", NC: "New Caledonia", NE: "Niger", NF: "Norfolk Island", NG: "Nigeria", NI: "Nicaragua", NL: "Netherlands", NO: "Norway", NP: "Nepal", NQ: "Dronning Maud Land", NR: "Nauru", NT: "Neutral Zone", NU: "Niue", NZ: "New Zealand", OM: "Oman", PA: "Panama", PC: "Pacific Islands Trust Territory", PE: "Peru", PF: "French Polynesia", PG: "Papua New Guinea", PH: "Philippines", PK: "Pakistan", PL: "Poland", PM: "Saint Pierre and Miquelon", PN: "Pitcairn Islands", PR: "Puerto Rico", PS: "Palestinian Territories", PT: "Portugal", PU: "U.S. Miscellaneous Pacific Islands", PW: "Palau", PY: "Paraguay", PZ: "Panama Canal Zone", QA: "Qatar", RE: "Réunion", RO: "Romania", RS: "Serbia", RU: "Russia", RW: "Rwanda", SA: "Saudi Arabia", SB: "Solomon Islands", SC: "Seychelles", SD: "Sudan", SE: "Sweden", SG: "Singapore", SH: "Saint Helena", SI: "Slovenia", SJ: "Svalbard and Jan Mayen", SK: "Slovakia", SL: "Sierra Leone", SM: "San Marino", SN: "Senegal", SO: "Somalia", SR: "Suriname", ST: "São Tomé and Príncipe", SU: "Union of Soviet Socialist Republics", SV: "El Salvador", SY: "Syria", SZ: "Swaziland", TC: "Turks and Caicos Islands", TD: "Chad", TF: "French Southern Territories", TG: "Togo", TH: "Thailand", TJ: "Tajikistan", TK: "Tokelau", TL: "Timor-Leste", TM: "Turkmenistan", TN: "Tunisia", TO: "Tonga", TR: "Turkey", TT: "Trinidad and Tobago", TV: "Tuvalu", TW: "Taiwan", TZ: "Tanzania", UA: "Ukraine", UG: "Uganda", UM: "U.S. Minor Outlying Islands", US: "United States", UY: "Uruguay", UZ: "Uzbekistan", VA: "Vatican City", VC: "Saint Vincent and the Grenadines", VD: "North Vietnam", VE: "Venezuela", VG: "British Virgin Islands", VI: "U.S. Virgin Islands", VN: "Vietnam", VU: "Vanuatu", WF: "Wallis and Futuna", WK: "Wake Island", WS: "Samoa", YD: "People's Democratic Republic of Yemen", YE: "Yemen", YT: "Mayotte", ZA: "South Africa", ZM: "Zambia", ZW: "Zimbabwe", ZZ: "Unknown or Invalid Region" };

            var countriesArray = $.map(countries, function (value, key) {
                return {
                    value: value,
                    data: key
                };
            });

            // initialize autocomplete with custom appendTo
            $('#autocomplete-custom-append').autocomplete({
                lookup: countriesArray,
                appendTo: '#autocomplete-container'
            });
        });
    </script>
    <!-- /jQuery autocomplete -->

    <!-- Starrr -->
    <script>
        $(document).ready(function () {
            $(".stars").starrr();

            $('.stars-existing').starrr({
                rating: 4
            });

            $('.stars').on('starrr:change', function (e, value) {
                $('.stars-count').html(value);
            });

            $('.stars-existing').on('starrr:change', function (e, value) {
                $('.stars-count-existing').html(value);
            });
        });
    </script>
    <!-- /Starrr -->
</asp:Content>