var last_name;
var first_name;
var middle_initial;
var assignment;
var detail;
var beginning_date;
var ending_date;
var watch_begin;
var watch_end;
var beginning_time;
var ending_time;
var total_time;
var submitted_by;
var date_submitted;
var rank;
var star;
var approved_by;
var approved_rank;
var approved_star;

var in_place_name;
var in_place_rank;

var obj_submit

var obj_error_string

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
        obj_approved_star = $('#approved_star');
        obj_in_place_name = $('#in_place_name');
        obj_in_place_rank = $('#in_place_rank');

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
        if (obj_watch_begin.val() == '' || obj_watch_begin.val() == null) {
            obj_error_string += "Watch worked required\n";
        }
        if (obj_watch_end.val() == '' || obj_watch_end.val() == null) {
            obj_error_string += "Watch worked required\n";
        }
        if (obj_beginning_time.val() == '' || obj_beginning_time.val() == null) {
            obj_error_string += "Beginning time for OT required\n";
        }
        if (obj_ending_time.val() == '' || obj_ending_time.val() == null) {
            obj_error_string += "Ending time for OT required\n";
        }
        if (obj_total_time.val() == '' || obj_total_time.val() == null) {
            obj_error_string += "Total time required\n";
        }
        if (obj_submitted_by.val() == '' || obj_submitted_by.val() == null) {
            obj_error_string += "This card must be signed to continue\n";
        }
        if (obj_rank.val() == '' || obj_rank.val() == null) {
            obj_error_string += "Rank required\n";
        }
        if (obj_star.val() == '' || obj_star.val() == null) {
            obj_error_string += "Star required\n";
        }
        if (obj_date_submitted.val() == '' || obj_date_submitted.val() == null) {
            obj_error_string += "Submit date required\n";
        }
        if (obj_in_place_name.val() == '' || obj_in_place_name.val() == null) {
            obj_error_string += 'Name of member worked in-place of required\n';
        }
        if (obj_in_place_rank.val() == '' || obj_in_place_rank.val() == null) {
            obj_in_place_rank += 'Rank of member worked in-place of required\n';
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