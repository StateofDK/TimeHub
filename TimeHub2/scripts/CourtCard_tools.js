//dimension for user inputs
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
var date_approved;

var court_session;
var appearance_type;
var department;
var court_type;
var defendant;
var charges;
var court_number;

var da_approved;
var da_approved_date;
var da_approved_time;

var case_number;
var certified_by;
var input_by;
var comment;

//dimension for submit button
var obj_submit;
var obj_approve;

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

        obj_court_session = $('#court_session');
        obj_appearance_type = $('#appearance_type');
        obj_department = $('#department');
        obj_court_type = $('#court_type');
        obj_defendant = $('#defendant');
        obj_charges = $('#charges');
        obj_court_number = $('#court_number');

        obj_da_approved = $('#da_approved');
        obj_da_approved_date = $('#da_approved_date');
        obj_da_approved_time = $('#da_approved_time');

        obj_case_number = $('#case_number');
        obj_certified_by = $('#certified_by');
        obj_input_by = $('#input_by');
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
        if (obj_court_session.val() == '' || obj_court_session.val() == null) {
            obj_error_string += 'Court session required\n';
        }
        if (obj_appearance_type.val() == '' || obj_appearance_type.val() == null) {
            obj_error_string += 'Appearance type required\n';
        }
        if (obj_court_number.val() == '' || obj_court_number.val() == null)
        {
            obj_error_string += 'Court number required\n';
        }
        if (obj_case_number.val() == '' || obj_case_number.val() == null) {
            obj_error_string += "Case number required\n";
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