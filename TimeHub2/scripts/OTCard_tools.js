var obj_last_name;
var obj_first_name;
var obj_middle_initial;
var obj_assignment;
var obj_detail;
var obj_beginning_date;
var obj_ending_date;
var obj_il_Holiday;
var obj_timepay;
var obj_ot_code;
var obj_watch_begin;
var obj_watch_end;
var obj_beginning_time;
var obj_ending_time;
var obj_total_time;
var obj_submitted_by;
var obj_date_submitted;
var obj_submitted_by;
var obj_rank;
var obj_star;
var obj_approved_by;
var obj_approved_rank;
var obj_approved_star;
var obj_date_approved;
var obj_case_number;
var obj_certified_by;
var obj_input_by;
var obj_event_number;
var obj_comment;

var obj_submit;

var obj_error_string;

function init() {
    obj_submit = $('#submit');
    
    obj_submit.click(function ValidateCard (e) {
        obj_last_name = $('#last_name');
        obj_first_name = $('#first_name');
        obj_middle_initial = $('#middle_initial');
        obj_assignment = $('#assignment');
        obj_detail = $('#detail');
        obj_beginning_date = $('#beginning_date');
        obj_ending_date = $('#ending_date');
        obj_il_Holiday = $('#il_holiday');
        obj_timepay = $('#timepay');
        obj_ot_code = $('#ot_code');
        obj_watch_begin = $('#watch_begin');
        obj_watch_end = $('#watch_end');
        obj_beginning_time = $('#beginning_time');
        obj_ending_time = $('#ending_time');
        obj_total_time = $('#total_time');
        obj_submitted_by = $('#submitted_by');
        obj_date_submitted = $('#date_submitted');
        obj_rank = $('#rank');
        obj_star = $('#star');
        obj_approved_by = $('#approved_by');
        obj_approved_rank = $('#approved_rank');
        obj_approved_star = $('#approved_by');
        obj_date_approved = $('#date_approved');
        obj_case_number = $('#case_number');
        obj_certified_by = $('#certified_by');
        obj_input_by = $('#input_by');
        obj_event_number = $('#event_number');
        obj_comment = $('#comment');

        obj_error_string = '';
        

        if (obj_last_name.val() == '' || obj_last_name.val() == null) {
            obj_error_string += 'Last name required\n';
        }
        if (obj_first_name.val() == '' || obj_first_name.val() == null) {
            obj_error_string += 'First name required\n';
        }
        if (obj_middle_initial.val() == '' || obj_middle_initial.val() == null) {
            obj_error_string += 'Middle initial required\n';
        }
        if (obj_assignment.val() == 0) {
            obj_error_string += 'Assignment required\n';
        }
        if (obj_beginning_date.val() == '' || obj_beginning_date.val() == null) {
            obj_error_string += 'Beginning date required\n';
        }
        if (obj_ending_date.val() == '' || obj_ending_date.val() == null) {
            obj_error_string += 'Ending date required\n';
        }
        if ($('#timepay :radio:checked').length == 0) {
            obj_error_string += 'Must select time or pay\n';
        }
        if (obj_ot_code.val() == 0) {
            obj_error_string += 'OT code required\n';
        }
        if (obj_watch_begin.val() == '' || obj_watch_begin.val() == null) {
            obj_error_string += 'Watch worked required\n';
        }
        if (obj_watch_end.val() == '' || obj_watch_end.val() == null) {
            obj_error_string += 'Watch worked required\n';
        }
        if (obj_beginning_time.val() == '' || obj_beginning_time.val() == null) {
            obj_error_string += 'Beginning time for OT required\n';
        }
        if (obj_ending_time.val() == '' || obj_ending_time.val() == null) {
            obj_error_string += 'Ending time for OT required\n';
        }
        if (obj_total_time.val() == '' || obj_total_time.val() == null) {
            obj_error_string += 'Total time required\n';
        }
        if (obj_submitted_by.val() == '' || obj_submitted_by.val() == null) {
            obj_error_string += 'This card must be signed to continue\n';
        }
        if (obj_rank.val() == '' || obj_rank.val() == null) {
            obj_error_string += 'Rank required\n';
        }
        if (obj_star.val() == '' || obj_star.val() == null) {
            obj_error_string += 'Star required\n';
        }
        if (obj_date_submitted.val() == '' || obj_date_submitted.val() == null) {
            obj_error_string += 'Submit date required\n';
        }
        if ((obj_case_number.val() == '' || obj_case_number.val() == null) && (obj_event_number.val() == '' || obj_event_number.val() == null)) {
            obj_error_string += 'Case number or Event code required\n';
        }

        if (obj_error_string) {
            alert(obj_error_string);
            e.preventDefault();
        }
        else {
            return true;
        }
    });
};