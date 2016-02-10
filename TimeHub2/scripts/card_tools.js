//var last_name;
//var first_name;
//var middle_initial;
//var assignment;
//var detail;

//var ending_date;
//var il_Holiday;
//var timepay;
//var ot_code;
//var watch_begin;
//var watch_end;
//var beginning_time;
//var ending_time;
//var total_time;
//var submitted_by;
//var date_submitted;
//var submitted_by;
//var date_submitted;
//var rank;
//var star;
//var approved_by;
//var approved_rank;
//var approved_star;
//var date_approved;
//var case_number;
//var certified_by;
//var input_by;
//var event_number;
//var comment;

//var obj_begin_date;
var obj_beginning_time;
var obj_ending_time;
var obj_total_time;

$(function () {
    obj_beginning_time = $('#beginning_time');
    obj_ending_time = $('#ending_time');
    obj_total_time = $('#total_time');

    obj_beginning_time.focusout(function () {
        timeCalc();
    });

    obj_ending_time.focusout(function () {
        timeCalc();
    });
});

 function timeCalc() {
        var obj_calculated_time;

        obj_calculated_time = (obj_ending_time.val() - obj_beginning_time.val()) / 100;

        if (obj_calculated_time < 0) {
            obj_calculated_time = (obj_ending_time.val() + 24 - obj_beginning_time.val()) / 100;

            $(obj_total_time.val(obj_calculated_time));
        }
        else {
            $(obj_total_time.val(obj_calculated_time));
        }
    };
