using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace TimeHub2
{
    public partial class CORequestNew : System.Web.UI.Page
    {
        public string PopupTitle
        {
            get;
            set;
        }

        public string SuccessMessage
        {
            get;
            set;
        }

        public string ErrorMessage
        {
            get;
            set;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //show user logged in else redirect to login
            if (Session["New"] != null)
            {
                string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    //retreive UserID from Session table. Populate lblUserLoggedIn
                    try
                    {
                        SqlCommand cmd = new SqlCommand("spSelectUserId", conn);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@SessionId", SqlDbType.VarChar).Value = Session["New"].ToString();

                        SqlParameter UserId = new SqlParameter();
                        UserId.ParameterName = "@UserId";
                        UserId.SqlDbType = System.Data.SqlDbType.VarChar;
                        UserId.Size = 200;
                        UserId.Direction = System.Data.ParameterDirection.Output;
                        cmd.Parameters.Add(UserId);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        string UserIdOut = UserId.Value.ToString();

                        lblUserLoggedIn.Text = UserIdOut;

                        conn.Close();
                    }
                    catch (Exception ex)
                    {
                        PopupTitle = "error retreiving session username: ";
                        ErrorMessage = ex.Message;
                        DisplayErrorDialog(null, null);
                    }
                }
            }
            //else
            {
                Response.Redirect("Login.aspx");
            }

            //populate tbCardnumber
            try
            {
                var CardNumber = Request["id"];

                if (CardNumber != null)
                {
                    tbCardNumber.Text = CardNumber;
                }
            }
            catch (Exception ex)
            {
                //do nothing. A CardNumber does not have to be passed through the URL since this may be a new request without a card number assigned
            }

            //populate card fields based on CardNumber and StatusId
            if (!Page.IsPostBack)
            {
                if (string.IsNullOrWhiteSpace(tbCardNumber.Text))
                {
                    //Configure as if new request
                    ConfigurePageNew(null, null);
                }
                else
                {
                    //card number is present. User is viewing existing request. configure existing card populated with table data
                    ConfigurePageExisting(null, null);

                    ConfigureButtons(null, null);
                }
            }
        }

        protected void ConfigurePageNew(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                //populate request based on data from the user profile table
                try
                {
                    SqlCommand cmd = new SqlCommand("spSelectNewRequestUserData", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;

                    SqlParameter firstName = new SqlParameter();
                    SqlParameter lastName = new SqlParameter();
                    SqlParameter middleInitial = new SqlParameter();
                    SqlParameter assign = new SqlParameter();

                    firstName.ParameterName = "@FirstName";
                    lastName.ParameterName = "@LastName";
                    middleInitial.ParameterName = "@MiddleInitial";
                    assign.ParameterName = "@Assignment";

                    firstName.SqlDbType = System.Data.SqlDbType.VarChar;
                    lastName.SqlDbType = System.Data.SqlDbType.VarChar;
                    middleInitial.SqlDbType = System.Data.SqlDbType.VarChar;
                    assign.SqlDbType = System.Data.SqlDbType.Int;

                    firstName.Size = 200;
                    lastName.Size = 200;
                    middleInitial.Size = 200;
                    assign.Size = 200;

                    firstName.Direction = System.Data.ParameterDirection.Output;
                    lastName.Direction = System.Data.ParameterDirection.Output;
                    middleInitial.Direction = System.Data.ParameterDirection.Output;
                    assign.Direction = System.Data.ParameterDirection.Output;

                    cmd.Parameters.Add(firstName);
                    cmd.Parameters.Add(lastName);
                    cmd.Parameters.Add(middleInitial);
                    cmd.Parameters.Add(assign);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string firstNameOut = firstName.Value.ToString();
                    string lastNameOut = lastName.Value.ToString();
                    string middleInitialOut = middleInitial.Value.ToString();
                    string assignmentOut = assign.Value.ToString();

                    tbFirstName.Text = firstNameOut;
                    tbLastName.Text = lastNameOut;
                    tbMiddleInitial.Text = middleInitialOut;
                    ddlAssignment.Text = assignmentOut;

                    tbBeginningDate.Text = DateTime.Now.ToShortDateString();

                    conn.Close();
                }
                catch (Exception ex)
                {
                    PopupTitle = "new request population error: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
                try
                {
                    lblCardNumber.Visible = false;
                    tbCardNumber.Visible = false;

                    btnSign.Visible = true;
                    btnUnsign.Visible = false;
                    btnSave.Visible = true;
                    btnWithdraw.Visible = false;
                    btnSubmit.Visible = true;
                    btnDelete.Visible = false;
                    btnCancel.Visible = true;
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;
                }
                catch (Exception ex)
                {
                    PopupTitle = "new page configuration error: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
            }
        }

        protected void ConfigurePageExisting(object sender, EventArgs e)
        {
            lblCardNumber.Visible = true;
            tbCardNumber.Visible = true;

            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                //populate existing request data from apropriate request table
                try
                {
                    SqlCommand cmd = new SqlCommand("spSelectExistingRequestDataCO", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@CardNumber", SqlDbType.VarChar).Value = tbCardNumber.Text;

                    SqlParameter firstName = new SqlParameter();
                    SqlParameter lastName = new SqlParameter();
                    SqlParameter middleInitial = new SqlParameter();
                    SqlParameter assign = new SqlParameter();
                    SqlParameter detail = new SqlParameter();
                    SqlParameter beginningDate = new SqlParameter();
                    SqlParameter endingDate = new SqlParameter();
                    SqlParameter shift = new SqlParameter();
                    SqlParameter beginningTime = new SqlParameter();
                    SqlParameter endingTime = new SqlParameter();
                    SqlParameter totalTime = new SqlParameter();
                    SqlParameter submittedBy = new SqlParameter();
                    SqlParameter dateSubmitted = new SqlParameter();
                    SqlParameter userStar = new SqlParameter();
                    SqlParameter userRank = new SqlParameter();
                    SqlParameter comment = new SqlParameter();
                    SqlParameter certifiedBy = new SqlParameter();
                    SqlParameter inputBy = new SqlParameter();
                    SqlParameter approvedBy = new SqlParameter();
                    SqlParameter dateApproved = new SqlParameter();
                    SqlParameter approvedRank = new SqlParameter();
                    SqlParameter approvedStar = new SqlParameter();
                    SqlParameter caseNumber = new SqlParameter();
                    SqlParameter courtSession = new SqlParameter();
                    SqlParameter appearanceType = new SqlParameter();
                    SqlParameter department = new SqlParameter();
                    SqlParameter courtType = new SqlParameter();
                    SqlParameter defendant = new SqlParameter();
                    SqlParameter charges = new SqlParameter();
                    SqlParameter courtNumber = new SqlParameter();
                    SqlParameter daApproved = new SqlParameter();
                    SqlParameter daApprovedDate = new SqlParameter();
                    SqlParameter daApprovedTime = new SqlParameter();
                    SqlParameter statusId = new SqlParameter();
                    SqlParameter userCredited = new SqlParameter();
                    SqlParameter supervisorComments = new SqlParameter();

                    firstName.ParameterName = "@FirstName";
                    lastName.ParameterName = "@LastName";
                    middleInitial.ParameterName = "@MiddleInitial";
                    assign.ParameterName = "@Assignment";
                    detail.ParameterName = "@Detail";
                    beginningDate.ParameterName = "@BeginningDate";
                    endingDate.ParameterName = "@EndingDate";
                    shift.ParameterName = "@Shift";
                    beginningTime.ParameterName = "@BeginningTime";
                    endingTime.ParameterName = "@EndingTime";
                    totalTime.ParameterName = "@TotalTime";
                    submittedBy.ParameterName = "@SubmittedBy";
                    dateSubmitted.ParameterName = "@DateSubmitted";
                    userStar.ParameterName = "@UserStar";
                    userRank.ParameterName = "@UserRank";
                    comment.ParameterName = "@Comment";
                    certifiedBy.ParameterName = "@CertifiedBy";
                    inputBy.ParameterName = "@InputBy";
                    approvedBy.ParameterName = "@ApprovedBy";
                    dateApproved.ParameterName = "@DateApproved";
                    approvedRank.ParameterName = "@ApprovedRank";
                    approvedStar.ParameterName = "@ApprovedStar";
                    caseNumber.ParameterName = "@CaseNumber";
                    courtSession.ParameterName = "@CourtSession";
                    appearanceType.ParameterName = "@AppearanceType";
                    department.ParameterName = "@Department";
                    courtType.ParameterName = "@CourtType";
                    defendant.ParameterName = "@Defendant";
                    charges.ParameterName = "@Charges";
                    courtNumber.ParameterName = "@CourtNumber";
                    daApproved.ParameterName = "@DAApproved";
                    daApprovedDate.ParameterName = "@DAApprovedDate";
                    daApprovedTime.ParameterName = "@DAApprovedTime";
                    statusId.ParameterName = "@StatusId";
                    userCredited.ParameterName = "@UserCredited";
                    supervisorComments.ParameterName = "@SupervisorComments";

                    firstName.SqlDbType = System.Data.SqlDbType.VarChar;
                    lastName.SqlDbType = System.Data.SqlDbType.VarChar;
                    middleInitial.SqlDbType = System.Data.SqlDbType.VarChar;
                    assign.SqlDbType = System.Data.SqlDbType.Int;
                    detail.SqlDbType = System.Data.SqlDbType.VarChar;
                    beginningDate.SqlDbType = System.Data.SqlDbType.Date;
                    endingDate.SqlDbType = System.Data.SqlDbType.Date;
                    shift.SqlDbType = System.Data.SqlDbType.Int;
                    beginningTime.SqlDbType = System.Data.SqlDbType.Time;
                    endingTime.SqlDbType = System.Data.SqlDbType.Time;
                    totalTime.SqlDbType = System.Data.SqlDbType.Int;
                    submittedBy.SqlDbType = System.Data.SqlDbType.VarChar;
                    dateSubmitted.SqlDbType = System.Data.SqlDbType.Date;
                    userStar.SqlDbType = System.Data.SqlDbType.Int;
                    userRank.SqlDbType = System.Data.SqlDbType.VarChar;
                    comment.SqlDbType = System.Data.SqlDbType.VarChar;
                    certifiedBy.SqlDbType = System.Data.SqlDbType.VarChar;
                    inputBy.SqlDbType = System.Data.SqlDbType.VarChar;
                    approvedBy.SqlDbType = System.Data.SqlDbType.VarChar;
                    dateApproved.SqlDbType = System.Data.SqlDbType.Date;
                    approvedRank.SqlDbType = System.Data.SqlDbType.VarChar;
                    approvedStar.SqlDbType = System.Data.SqlDbType.Int;
                    caseNumber.SqlDbType = System.Data.SqlDbType.VarChar;
                    courtSession.SqlDbType = System.Data.SqlDbType.VarChar;
                    appearanceType.SqlDbType = System.Data.SqlDbType.VarChar;
                    department.SqlDbType = System.Data.SqlDbType.VarChar;
                    courtType.SqlDbType = System.Data.SqlDbType.VarChar;
                    defendant.SqlDbType = System.Data.SqlDbType.VarChar;
                    charges.SqlDbType = System.Data.SqlDbType.VarChar;
                    courtNumber.SqlDbType = System.Data.SqlDbType.Int;
                    daApproved.SqlDbType = System.Data.SqlDbType.VarChar;
                    daApprovedDate.SqlDbType = System.Data.SqlDbType.Date;
                    daApprovedTime.SqlDbType = System.Data.SqlDbType.Time;
                    statusId.SqlDbType = System.Data.SqlDbType.VarChar;
                    userCredited.SqlDbType = System.Data.SqlDbType.Int;
                    supervisorComments.SqlDbType = System.Data.SqlDbType.VarChar;

                    firstName.Size = 200;
                    lastName.Size = 200;
                    middleInitial.Size = 200;
                    assign.Size = 200;
                    detail.Size = 200;
                    beginningDate.Size = 200;
                    endingDate.Size = 200;
                    shift.Size = 200;
                    beginningTime.Size = 200;
                    endingTime.Size = 200;
                    totalTime.Size = 200;
                    submittedBy.Size = 200;
                    dateSubmitted.Size = 200;
                    userStar.Size = 200;
                    userRank.Size = 200;
                    comment.Size = 200;
                    certifiedBy.Size = 200;
                    inputBy.Size = 200;
                    approvedBy.Size = 200;
                    dateApproved.Size = 200;
                    approvedRank.Size = 200;
                    approvedStar.Size = 200;
                    caseNumber.Size = 200;
                    courtSession.Size = 200;
                    appearanceType.Size = 200;
                    department.Size = 200;
                    courtType.Size = 200;
                    defendant.Size = 200;
                    charges.Size = 200;
                    courtNumber.Size = 200;
                    daApproved.Size = 200;
                    daApprovedDate.Size = 200;
                    daApprovedTime.Size = 200;
                    statusId.Size = 200;
                    userCredited.Size = 200;
                    supervisorComments.Size = 200;

                    firstName.Direction = System.Data.ParameterDirection.Output;
                    lastName.Direction = System.Data.ParameterDirection.Output;
                    middleInitial.Direction = System.Data.ParameterDirection.Output;
                    assign.Direction = System.Data.ParameterDirection.Output;
                    detail.Direction = System.Data.ParameterDirection.Output;
                    beginningDate.Direction = System.Data.ParameterDirection.Output;
                    endingDate.Direction = System.Data.ParameterDirection.Output;
                    shift.Direction = System.Data.ParameterDirection.Output;
                    beginningTime.Direction = System.Data.ParameterDirection.Output;
                    endingTime.Direction = System.Data.ParameterDirection.Output;
                    totalTime.Direction = System.Data.ParameterDirection.Output;
                    submittedBy.Direction = System.Data.ParameterDirection.Output;
                    dateSubmitted.Direction = System.Data.ParameterDirection.Output;
                    userStar.Direction = System.Data.ParameterDirection.Output;
                    userRank.Direction = System.Data.ParameterDirection.Output;
                    comment.Direction = System.Data.ParameterDirection.Output;
                    certifiedBy.Direction = System.Data.ParameterDirection.Output;
                    inputBy.Direction = System.Data.ParameterDirection.Output;
                    approvedBy.Direction = System.Data.ParameterDirection.Output;
                    dateApproved.Direction = System.Data.ParameterDirection.Output;
                    approvedRank.Direction = System.Data.ParameterDirection.Output;
                    approvedStar.Direction = System.Data.ParameterDirection.Output;
                    caseNumber.Direction = System.Data.ParameterDirection.Output;
                    courtSession.Direction = System.Data.ParameterDirection.Output;
                    appearanceType.Direction = System.Data.ParameterDirection.Output;
                    department.Direction = System.Data.ParameterDirection.Output;
                    courtType.Direction = System.Data.ParameterDirection.Output;
                    defendant.Direction = System.Data.ParameterDirection.Output;
                    charges.Direction = System.Data.ParameterDirection.Output;
                    courtNumber.Direction = System.Data.ParameterDirection.Output;
                    daApproved.Direction = System.Data.ParameterDirection.Output;
                    daApprovedDate.Direction = System.Data.ParameterDirection.Output;
                    daApprovedTime.Direction = System.Data.ParameterDirection.Output;
                    statusId.Direction = System.Data.ParameterDirection.Output;
                    userCredited.Direction = System.Data.ParameterDirection.Output;
                    supervisorComments.Direction = System.Data.ParameterDirection.Output;

                    cmd.Parameters.Add(firstName);
                    cmd.Parameters.Add(lastName);
                    cmd.Parameters.Add(middleInitial);
                    cmd.Parameters.Add(assign);
                    cmd.Parameters.Add(detail);
                    cmd.Parameters.Add(beginningDate);
                    cmd.Parameters.Add(endingDate);
                    cmd.Parameters.Add(shift);
                    cmd.Parameters.Add(beginningTime);
                    cmd.Parameters.Add(endingTime);
                    cmd.Parameters.Add(totalTime);
                    cmd.Parameters.Add(submittedBy);
                    cmd.Parameters.Add(dateSubmitted);
                    cmd.Parameters.Add(userStar);
                    cmd.Parameters.Add(userRank);
                    cmd.Parameters.Add(comment);
                    cmd.Parameters.Add(certifiedBy);
                    cmd.Parameters.Add(inputBy);
                    cmd.Parameters.Add(approvedBy);
                    cmd.Parameters.Add(dateApproved);
                    cmd.Parameters.Add(approvedRank);
                    cmd.Parameters.Add(approvedStar);
                    cmd.Parameters.Add(caseNumber);
                    cmd.Parameters.Add(courtSession);
                    cmd.Parameters.Add(appearanceType);
                    cmd.Parameters.Add(department);
                    cmd.Parameters.Add(courtType);
                    cmd.Parameters.Add(defendant);
                    cmd.Parameters.Add(charges);
                    cmd.Parameters.Add(courtNumber);
                    cmd.Parameters.Add(daApproved);
                    cmd.Parameters.Add(daApprovedDate);
                    cmd.Parameters.Add(daApprovedTime);
                    cmd.Parameters.Add(statusId);
                    cmd.Parameters.Add(userCredited);
                    cmd.Parameters.Add(supervisorComments);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string firstNameOut = firstName.Value.ToString();
                    string lastNameOut = lastName.Value.ToString();
                    string middleInitialOut = middleInitial.Value.ToString();
                    string assignmentOut = assign.Value.ToString();
                    string detailOut = detail.Value.ToString();
                    string beginningDateOut = beginningDate.Value.ToString();
                    string endingDateOut = endingDate.Value.ToString();
                    String shiftOut = shift.Value.ToString();
                    string beginningTimeOut = beginningTime.Value.ToString();
                    string endingTimeOut = endingTime.Value.ToString();
                    string totalTimeOut = totalTime.Value.ToString();
                    string submittedByOut = submittedBy.Value.ToString();
                    string dateSubmittedOut = dateSubmitted.Value.ToString();
                    string userStarOut = userStar.Value.ToString();
                    string userRankOut = userRank.Value.ToString();
                    string commentOut = comment.Value.ToString();
                    string certifiedByOut = certifiedBy.Value.ToString();
                    string inputByOut = inputBy.Value.ToString();
                    string approvedByOut = approvedBy.Value.ToString();
                    string dateApprovedOut = dateApproved.Value.ToString();
                    string approvedRankOut = approvedRank.Value.ToString();
                    string approvedStarOut = approvedStar.Value.ToString();
                    string caseNumberOut = caseNumber.Value.ToString();
                    string courtSessionOut = courtSession.Value.ToString();
                    string appearanceTypeOut = appearanceType.Value.ToString();
                    string departmentOut = department.Value.ToString();
                    string courtTypeOut = courtType.Value.ToString();
                    string defendantOut = defendant.Value.ToString();
                    string chargesOut = charges.Value.ToString();
                    string courtNumberOut = courtNumber.Value.ToString();
                    string daApprovedOut = daApproved.Value.ToString();
                    string daApprovedDateOut = daApprovedDate.Value.ToString();
                    string daApprovedTimeOut = daApprovedTime.Value.ToString();
                    string statusIdOut = statusId.Value.ToString();
                    string userCreditedOut = userCredited.Value.ToString();
                    string supervisorCommentOut = supervisorComments.Value.ToString();

                    tbFirstName.Text = firstNameOut;
                    tbLastName.Text = lastNameOut;
                    tbMiddleInitial.Text = middleInitialOut;
                    ddlAssignment.SelectedValue = assignmentOut;
                    tbDetail.Text = detailOut;
                    tbBeginningDate.Text = beginningDateOut;
                    tbEndingDate.Text = endingDateOut;
                    ddlShift.SelectedValue = shiftOut;
                    tbBeginningTime.Text = beginningTimeOut;
                    tbEndingTime.Text = endingTimeOut;
                    tbTotalTime.Text = totalTimeOut;
                    tbSubmittedBy.Text = submittedByOut;
                    tbSubmittedDate.Text = dateSubmittedOut;
                    tbUserStar.Text = userStarOut;
                    tbUserRank.Text = userRankOut;
                    tbComments.Text = commentOut;
                    tbCertifiedBy.Text = certifiedByOut;
                    tbInputBy.Text = inputByOut;
                    tbApprovedBy.Text = approvedByOut;
                    tbApprovedDate.Text = dateApprovedOut;
                    tbApprovedRank.Text = approvedRankOut;
                    tbApprovedStar.Text = approvedStarOut;
                    tbCaseNumber.Text = caseNumberOut;
                    rblCourtSession.Text = courtSessionOut;
                    rblAppearanceType.Text = appearanceTypeOut;
                    tbDepartment.Text = departmentOut;
                    rblCourtType.Text = courtTypeOut;
                    tbDefendant.Text = defendantOut;
                    tbCharges.Text = chargesOut;
                    tbCourtNumber.Text = courtNumberOut;
                    tbDaSigned.Text = daApprovedOut;
                    tbDaSignedDate.Text = daApprovedDateOut;
                    tbDaSignedTime.Text = daApprovedTimeOut;
                    tbStatusId.Text = statusIdOut;
                    tbUserCredited.Text = userCreditedOut;
                    tbSupervisorComments.Text = supervisorCommentOut;

                    conn.Close();
                }
                catch (Exception ex)
                {
                    PopupTitle = "existing request population error: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
            }
        }

        protected void ConfigureButtons(object sender, EventArgs e)
        {
                //display appropriate buttons based on StatusID
                try
                {
                    lblCardNumber.Visible = true;
                    tbCardNumber.Visible = true;

                    switch (tbStatusId.Text.ToLower())
                    {
                        case "saved":
                            btnSign.Visible = true;
                            btnUnsign.Visible = false;
                            btnSave.Visible = false;
                            btnWithdraw.Visible = false;
                            btnSubmit.Visible = true;
                            btnDelete.Visible = true;
                            btnCancel.Visible = true;
                            btnApprove.Visible = false;
                            btnReturn.Visible = false;

                            if (!string.IsNullOrEmpty(tbSubmittedBy.Text))
                            {
                                btnSign.Visible = false;
                                btnUnsign.Visible = true;

                                CardReadOnly(null, null);
                            }
                            break;

                        case "submitted":
                            string userIsSupervisor = null;
                            string userCredited = tbUserCredited.Text.ToString();
                            string userLoggedIn = lblUserLoggedIn.Text.ToString();
                            if (!userLoggedIn.Equals(userCredited))
                            {
                                userIsSupervisor = "true";
                            }

                            if (string.IsNullOrEmpty(userIsSupervisor))
                            {
                                btnSign.Visible = false;
                                btnUnsign.Visible = false;
                                btnSave.Visible = false;
                                btnWithdraw.Visible = true;
                                btnSubmit.Visible = false;
                                btnDelete.Visible = false;
                                btnCancel.Visible = true;
                                btnApprove.Visible = false;
                                btnReturn.Visible = false;

                                CardReadOnly(null, null);
                            }
                            else
                            {
                                btnSign.Visible = false;
                                btnUnsign.Visible = false;
                                btnSave.Visible = false;
                                btnWithdraw.Visible = false;
                                btnSubmit.Visible = false;
                                btnDelete.Visible = false;
                                btnCancel.Visible = true;
                                btnApprove.Visible = true;
                                btnReturn.Visible = true;

                                lblSupervisorComments.Visible = true;
                                tbSupervisorComments.Visible = true;
                                tbSupervisorComments.ReadOnly = false;

                                CardReadOnly(null, null);
                            }
                            break;

                        case "approved":
                            btnSign.Visible = false;
                            btnUnsign.Visible = false;
                            btnSave.Visible = false;
                            btnWithdraw.Visible = false;
                            btnSubmit.Visible = false;
                            btnDelete.Visible = false;
                            btnCancel.Visible = true;
                            btnApprove.Visible = false;
                            btnReturn.Visible = false;

                            lblSupervisorComments.Visible = true;
                            tbSupervisorComments.Visible = true;

                            CardReadOnly(null, null);
                            break;

                        case "returned":
                            btnSign.Visible = false;
                            btnUnsign.Visible = true;
                            btnSave.Visible = true;
                            btnWithdraw.Visible = false;
                            btnSubmit.Visible = true;
                            btnDelete.Visible = true;
                            btnCancel.Visible = true;
                            btnApprove.Visible = false;
                            btnReturn.Visible = false;

                            lblSupervisorComments.Visible = true;
                            tbSupervisorComments.Visible = true;

                            CardReadOnly(null, null);
                            break;
                    }
                }
                catch (Exception ex)
                {
                    PopupTitle = "error displaying buttons: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }

                //approve and return buttons should be populated based on a user authority level add in an if/else statement here to test for appropriate level
        }

        protected void CardReadOnly(object sender, EventArgs e)
        {
            tbLastName.ReadOnly = true;
            tbFirstName.ReadOnly = true;
            tbMiddleInitial.ReadOnly = true;
            ddlAssignment.Enabled = false;
            tbDetail.ReadOnly = true;
            tbBeginningDate.ReadOnly = true;
            tbEndingDate.ReadOnly = true;
            ddlShift.Enabled = false;
            tbBeginningTime.ReadOnly = true;
            tbEndingTime.ReadOnly = true;
            tbTotalTime.ReadOnly = true;
            tbSubmittedBy.ReadOnly = true;
            tbSubmittedDate.ReadOnly = true;
            tbUserRank.ReadOnly = true;
            tbUserStar.ReadOnly = true;
            tbApprovedBy.ReadOnly = true;
            tbApprovedRank.ReadOnly = true;
            tbApprovedStar.ReadOnly = true;
            tbApprovedDate.ReadOnly = true;
            rblCourtSession.Enabled = false;
            rblAppearanceType.Enabled = false;
            tbDepartment.ReadOnly = true;
            rblCourtType.Enabled = false;
            tbDefendant.ReadOnly = true;
            tbCharges.ReadOnly = true;
            tbCourtNumber.ReadOnly = true;
            tbDaSigned.ReadOnly = true;
            tbDaSignedDate.ReadOnly = true;
            tbDaSignedTime.ReadOnly = true;
            tbCaseNumber.ReadOnly = true;
            tbCertifiedBy.ReadOnly = true;
            tbInputBy.ReadOnly = true;
            tbComments.ReadOnly = true;
        }

        protected void CardEditable(object sender, EventArgs e)
        {
            tbLastName.ReadOnly = false;
            tbFirstName.ReadOnly = false;
            tbMiddleInitial.ReadOnly = false;
            ddlAssignment.Enabled = true;
            tbDetail.ReadOnly = false;
            tbBeginningDate.ReadOnly = false;
            tbEndingDate.ReadOnly = false;
            ddlShift.Enabled = true;
            tbBeginningTime.ReadOnly = false;
            tbEndingTime.ReadOnly = false;
            tbTotalTime.ReadOnly = false;
            tbSubmittedBy.ReadOnly = false;
            tbSubmittedDate.ReadOnly = false;
            tbUserRank.ReadOnly = false;
            tbUserStar.ReadOnly = false;
            rblCourtSession.Enabled = true;
            rblAppearanceType.Enabled = true;
            tbDepartment.ReadOnly = false;
            rblCourtType.Enabled = true;
            tbDefendant.ReadOnly = false;
            tbCharges.ReadOnly = false;
            tbCourtNumber.ReadOnly = false;
            tbCaseNumber.ReadOnly = false;
            tbComments.ReadOnly = true;
        }

        protected void WriteApprovalInfoToCard(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    SqlDataReader dr_get_approval_info;

                    cmd.CommandText = "spSelectApprovalUserData";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = conn;

                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = Session["New"].ToString();

                    conn.Open();

                    dr_get_approval_info = cmd.ExecuteReader();
                    while (dr_get_approval_info.Read())
                    {
                        tbApprovedBy.Text = dr_get_approval_info["username"].ToString();
                        tbApprovedStar.Text = dr_get_approval_info["user_star"].ToString();
                        tbApprovedRank.Text = dr_get_approval_info["user_rank"].ToString();

                        tbApprovedDate.Text = DateTime.Today.ToShortDateString();
                    }

                    conn.Close();
                }
                catch (Exception ex)
                {
                    PopupTitle = "Error writing approval info to card: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
            }
        }

        protected void btnSignClick(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spSelectNewRequestUserData", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;

                    SqlParameter UserRank = new SqlParameter();
                    SqlParameter UserStar = new SqlParameter();
                    SqlParameter Username = new SqlParameter();

                    UserRank.ParameterName = "@UserRank";
                    UserStar.ParameterName = "@UserStar";
                    Username.ParameterName = "@Username";

                    UserRank.SqlDbType = System.Data.SqlDbType.VarChar;
                    UserStar.SqlDbType = System.Data.SqlDbType.VarChar;
                    Username.SqlDbType = System.Data.SqlDbType.VarChar;

                    UserRank.Size = 200;
                    UserStar.Size = 200;
                    Username.Size = 200;

                    UserRank.Direction = System.Data.ParameterDirection.Output;
                    UserStar.Direction = System.Data.ParameterDirection.Output;
                    Username.Direction = System.Data.ParameterDirection.Output;

                    cmd.Parameters.Add(UserRank);
                    cmd.Parameters.Add(UserStar);
                    cmd.Parameters.Add(Username);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string UserRankOut = UserRank.Value.ToString();
                    string UserStarOut = UserStar.Value.ToString();
                    string UsernameOut = Username.Value.ToString();

                    tbUserRank.Text = UserRankOut;
                    tbUserStar.Text = UserStarOut;
                    tbSubmittedBy.Text = UsernameOut;

                    conn.Close();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error signing request";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
            }

            tbSubmittedDate.Text = DateTime.Today.ToShortDateString();

            btnSign.Visible = false;
            btnUnsign.Visible = true;

            CardReadOnly(null, null);
        }

        protected void btnUnsignClick(object sender, EventArgs e)
        {
            CardEditable(null, null);

            tbSubmittedBy.Text = null;
            tbUserRank.Text = null;
            tbUserStar.Text = null;
            tbSubmittedDate.Text = null;


            btnSign.Visible = true;
            btnUnsign.Visible = false;
        }

        protected void btnLogOutClick(object sender, EventArgs e)
        {
            //show user logged in
            Session["New"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void btnSaveClick(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spInsertRequestCO", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;


                    cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = tbFirstName.Text;
                    cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = tbLastName.Text;
                    cmd.Parameters.Add("@MiddleInitial", SqlDbType.VarChar).Value = tbMiddleInitial.Text;
                    cmd.Parameters.Add("@Assignment", SqlDbType.Int).Value = ddlAssignment.SelectedValue;
                    cmd.Parameters.Add("@Detail", SqlDbType.VarChar).Value = tbDetail.Text;
                    cmd.Parameters.Add("@BeginningDate", SqlDbType.Date).Value = tbBeginningDate.Text;
                    cmd.Parameters.Add("@EndingDate", SqlDbType.Date).Value = tbEndingDate.Text;
                    cmd.Parameters.Add("@Shift", SqlDbType.Int).Value = ddlShift.SelectedValue;
                    cmd.Parameters.Add("@BeginningTime", SqlDbType.Time).Value = DateTime.ParseExact(tbBeginningTime.Text, "HHmm", null).TimeOfDay;
                    cmd.Parameters.Add("@EndingTime", SqlDbType.Time).Value = DateTime.ParseExact(tbEndingTime.Text, "HHmm", null).TimeOfDay;
                    cmd.Parameters.Add("@TotalTime", SqlDbType.Int).Value = int.Parse(tbTotalTime.Text);

                    //cmd.Parameters.Add("@TotalTime", SqlDbType.Int).Value = tbTotalTime.Text;
                    //cmd.Parameters.Add("@SubmittedBy", SqlDbType.VarChar).Value = tbSubmittedBy.Text;
                    //cmd.Parameters.Add("@DateSubmitted", SqlDbType.Date).Value = tbSubmittedDate.Text;
                    //cmd.Parameters.Add("@UserStar", SqlDbType.Int).Value = tbUserStar.Text;
                    //cmd.Parameters.Add("@UserRank", SqlDbType.VarChar).Value = tbUserRank.Text;
                    //cmd.Parameters.Add("@Comment", SqlDbType.VarChar).Value = tbComments.Text;
                    //cmd.Parameters.Add("@CertifiedBy", SqlDbType.VarChar).Value = tbCertifiedBy.Text;
                    //cmd.Parameters.Add("@InputBy", SqlDbType.VarChar).Value = tbInputBy.Text;
                    //cmd.Parameters.Add("@ApprovedBy", SqlDbType.VarChar).Value = tbApprovedBy.Text;
                    //cmd.Parameters.Add("@DateApproved", SqlDbType.Date).Value = tbApprovedDate.Text;
                    //cmd.Parameters.Add("@ApprovedRank", SqlDbType.VarChar).Value = tbApprovedRank.Text;
                    //cmd.Parameters.Add("@ApprovedStar", SqlDbType.Int).Value = tbApprovedStar.Text;
                    //cmd.Parameters.Add("@CaseNumber", SqlDbType.VarChar).Value = tbCaseNumber.Text;
                    //cmd.Parameters.Add("@CourtSession", SqlDbType.VarChar).Value = rblCourtSession.SelectedValue;
                    //cmd.Parameters.Add("@AppearanceType", SqlDbType.VarChar).Value = rblAppearanceType.SelectedValue;
                    //cmd.Parameters.Add("@Department", SqlDbType.VarChar).Value = tbDepartment.Text;
                    //cmd.Parameters.Add("@CourtType", SqlDbType.VarChar).Value = rblCourtType.SelectedValue;
                    //cmd.Parameters.Add("@Defendant", SqlDbType.VarChar).Value = tbDefendant.Text;
                    //cmd.Parameters.Add("@Charges", SqlDbType.VarChar).Value = tbCharges.Text;
                    //cmd.Parameters.Add("@CourtNumber", SqlDbType.Int).Value = tbCourtNumber.Text;
                    //cmd.Parameters.Add("@DAApproved", SqlDbType.VarChar).Value = tbDaSigned.Text;
                    //cmd.Parameters.Add("@DAApprovedDate", SqlDbType.Date).Value = tbDaSignedDate.Text;
                    //cmd.Parameters.Add("@DAApprovedTime", SqlDbType.Time).Value = tbDaSignedTime.Text;

                    cmd.Parameters.Add("@RequestType", SqlDbType.VarChar).Value = "CO";
                    cmd.Parameters.Add("@UserCredited", SqlDbType.Int).Value = lblUserLoggedIn.Text;

                    cmd.Parameters.Add("@CreateDate", SqlDbType.DateTime2).Value = DateTime.Now.ToString();
                    cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                    cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "saved";



                    SqlParameter outputParameter = new SqlParameter();
                    outputParameter.ParameterName = "@CardNumber";
                    outputParameter.SqlDbType = System.Data.SqlDbType.Int;
                    outputParameter.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(outputParameter);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string cardNumber = outputParameter.Value.ToString();

                    tbCardNumber.Text = cardNumber;
                    tbStatusId.Text = "saved";

                    conn.Close();

                    SuccessMessage = "Request Saved Successfully";
                    DisplaySuccessDialog(null, null);

                    ConfigureButtons(null, null);
                }
                catch (Exception ex)
                {
                    PopupTitle = "Save Error: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
            }
        }

        protected void btnSubmitClick(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(tbCardNumber.Text))
            {
                string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand("spInsertRequestCO", conn);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = tbFirstName.Text;
                        cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = tbLastName.Text;
                        cmd.Parameters.Add("@MiddleInitial", SqlDbType.VarChar).Value = tbMiddleInitial.Text;
                        cmd.Parameters.Add("@Assignment", SqlDbType.Int).Value = ddlAssignment.SelectedValue;
                        cmd.Parameters.Add("@Detail", SqlDbType.VarChar).Value = tbDetail.Text;
                        cmd.Parameters.Add("@BeginningDate", SqlDbType.Date).Value = tbBeginningDate.Text;
                        cmd.Parameters.Add("@EndingDate", SqlDbType.Date).Value = tbEndingDate.Text;
                        cmd.Parameters.Add("@BeginningTime", SqlDbType.Time).Value = tbBeginningTime.Text;
                        cmd.Parameters.Add("@EndingTime", SqlDbType.Time).Value = tbEndingTime.Text;
                        cmd.Parameters.Add("@TotalTime", SqlDbType.Int).Value = tbTotalTime.Text;
                        cmd.Parameters.Add("@SubmittedBy", SqlDbType.VarChar).Value = tbSubmittedBy.Text;
                        cmd.Parameters.Add("@UserRank", SqlDbType.VarChar).Value = tbUserRank.Text;
                        cmd.Parameters.Add("@UserStar", SqlDbType.Int).Value = tbUserStar.Text;
                        cmd.Parameters.Add("@DateSubmitted", SqlDbType.Date).Value = tbSubmittedDate.Text;
                        cmd.Parameters.Add("@CaseNumber", SqlDbType.VarChar).Value = tbCaseNumber.Text;
                        cmd.Parameters.Add("@Comment", SqlDbType.VarChar).Value = tbComments.Text;
                        cmd.Parameters.Add("@Shift", SqlDbType.VarChar).Value = ddlShift.SelectedValue;

                        cmd.Parameters.Add("@CourtSession", SqlDbType.VarChar).Value = rblCourtSession.Text;
                        cmd.Parameters.Add("@AppearanceType", SqlDbType.VarChar).Value = rblAppearanceType.Text;
                        cmd.Parameters.Add("@Department", SqlDbType.VarChar).Value = tbDepartment.Text;
                        cmd.Parameters.Add("@CourtType", SqlDbType.VarChar).Value = rblCourtType.Text;
                        cmd.Parameters.Add("@Defendant", SqlDbType.VarChar).Value = tbDefendant.Text;
                        cmd.Parameters.Add("@Charges", SqlDbType.VarChar).Value = tbCharges.Text;
                        cmd.Parameters.Add("@CourtNumber", SqlDbType.Int).Value = tbCourtNumber.Text;
                        cmd.Parameters.Add("@DaApproved", SqlDbType.VarChar).Value = tbDaSigned.Text;
                        cmd.Parameters.Add("@DaApprovedDate", SqlDbType.Date).Value = tbDaSignedDate.Text;
                        cmd.Parameters.Add("@DAApprovedTime", SqlDbType.Time).Value = tbDaSignedTime.Text;

                        cmd.Parameters.Add("@RequestType", SqlDbType.VarChar).Value = "CO";
                        cmd.Parameters.Add("@UserCredited", SqlDbType.Int).Value = lblUserLoggedIn.Text;

                        cmd.Parameters.Add("@CreateDate", SqlDbType.DateTime2).Value = DateTime.Now.ToString();
                        cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                        cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "Submitted";

                        SqlParameter outputParameter = new SqlParameter();
                        outputParameter.ParameterName = "@CardNumber";
                        outputParameter.SqlDbType = System.Data.SqlDbType.Int;
                        outputParameter.Direction = System.Data.ParameterDirection.Output;
                        cmd.Parameters.Add(outputParameter);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        string cardNumber = outputParameter.Value.ToString();

                        tbCardNumber.Text = cardNumber;
                        tbStatusId.Text = "submitted";

                        conn.Close();

                        SuccessMessage = "request submitted successfully";
                        DisplaySuccessDialog(null, null);

                        ConfigureButtons(null, null);
                    }
                    catch (Exception ex)
                    {
                        PopupTitle = "Submit Error: ";
                        ErrorMessage = ex.Message;
                        DisplayErrorDialog(null, null);
                    }
                }
            }
            else
            {
                string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand("spUpdateRequestCO", conn);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = tbFirstName.Text;
                        cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = tbLastName.Text;
                        cmd.Parameters.Add("@MiddleInitial", SqlDbType.VarChar).Value = tbMiddleInitial.Text;
                        cmd.Parameters.Add("@Assignment", SqlDbType.VarChar).Value = ddlAssignment.SelectedValue;
                        cmd.Parameters.Add("@Detail", SqlDbType.VarChar).Value = tbDetail.Text;
                        cmd.Parameters.Add("@BeginningDate", SqlDbType.Date).Value = tbBeginningDate.Text;
                        cmd.Parameters.Add("@EndingDate", SqlDbType.Date).Value = tbEndingDate.Text;
                        cmd.Parameters.Add("@Shift", SqlDbType.VarChar).Value = ddlShift.SelectedValue;
                        cmd.Parameters.Add("@BeginningTime", SqlDbType.Time).Value = tbBeginningTime.Text;
                        cmd.Parameters.Add("@EndingTime", SqlDbType.Time).Value = tbEndingTime.Text;
                        cmd.Parameters.Add("@TotalTime", SqlDbType.Int).Value = tbTotalTime.Text;
                        cmd.Parameters.Add("@SubmittedBy", SqlDbType.VarChar).Value = tbSubmittedBy.Text;
                        cmd.Parameters.Add("@UserRank", SqlDbType.VarChar).Value = tbUserRank.Text;
                        cmd.Parameters.Add("@UserStar", SqlDbType.Int).Value = tbUserStar.Text;
                        cmd.Parameters.Add("@DateSubmitted", SqlDbType.Date).Value = tbSubmittedDate.Text;
                        cmd.Parameters.Add("@CaseNumber", SqlDbType.VarChar).Value = tbCaseNumber.Text;
                        cmd.Parameters.Add("@Comment", SqlDbType.VarChar).Value = tbComments.Text;
                        cmd.Parameters.Add("@CourtSession", SqlDbType.VarChar).Value = rblCourtSession.Text;
                        cmd.Parameters.Add("@AppearanceType", SqlDbType.VarChar).Value = rblAppearanceType.Text;
                        cmd.Parameters.Add("@Department", SqlDbType.VarChar).Value = tbDepartment.Text;
                        cmd.Parameters.Add("@CourtType", SqlDbType.VarChar).Value = rblCourtType.Text;
                        cmd.Parameters.Add("@Defendant", SqlDbType.VarChar).Value = tbDefendant.Text;
                        cmd.Parameters.Add("@Charges", SqlDbType.VarChar).Value = tbCharges.Text;
                        cmd.Parameters.Add("@CourtNumber", SqlDbType.Int).Value = tbCourtNumber.Text;
                        cmd.Parameters.Add("@DaApproved", SqlDbType.VarChar).Value = tbDaSigned.Text;
                        cmd.Parameters.Add("@DaApprovedDate", SqlDbType.Date).Value = tbDaSignedDate.Text;
                        cmd.Parameters.Add("@DAApprovedTime", SqlDbType.Time).Value = tbDaSignedTime.Text;

                        cmd.Parameters.Add("@CardNUmber", SqlDbType.VarChar).Value = tbCardNumber.Text;

                        cmd.Parameters.Add("@CreateDate", SqlDbType.DateTime2).Value = DateTime.Now.ToString();
                        cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                        cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "Submitted";

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        tbStatusId.Text = "submitted";

                        conn.Close();

                        SuccessMessage = "Card Submitted/Edited successfully";
                        DisplaySuccessDialog(null, null);

                        ConfigureButtons(null, null);
                    }
                    catch (Exception ex)
                    {
                        PopupTitle = "submit/edit Error: ";
                        ErrorMessage = ex.Message;
                        DisplayErrorDialog(null, null);
                    }
                }
            }
        }

        protected void btnWithdrawClick(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    Int32 rowsAffected;

                    cmd.CommandText = "spUpdateRequestStatusCO";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = conn;

                    cmd.Parameters.Add("@CardNumber", SqlDbType.VarChar).Value = tbCardNumber.Text;
                    cmd.Parameters.Add("@ModifiedBy", SqlDbType.VarChar).Value = tbSubmittedBy.Text = lblUserLoggedIn.Text;
                    cmd.Parameters.Add("@ModifyDate", SqlDbType.Date).Value = DateTime.Today.ToShortDateString();
                    cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "saved";

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    tbStatusId.Text = "saved";

                    conn.Close();

                    ConfigureButtons(null, null);
                }
                catch (Exception ex)
                {

                    //do nothing.  Method throws a ThreadAbortException but still executes properly.
                }
            }
        }

        protected void btnNewCardClick(object sender, EventArgs e)
        {
            Response.Redirect("CORequest.aspx");
        }

        protected void btnDeleteClick(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    Int32 rowsAffected;

                    cmd.CommandText = "spUpdateRequestStatusCO";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = conn;

                    cmd.Parameters.Add("@CardNumber", SqlDbType.VarChar).Value = tbCardNumber.Text;
                    cmd.Parameters.Add("@ModifiedBy", SqlDbType.VarChar).Value = tbSubmittedBy.Text = Session["New"].ToString();
                    cmd.Parameters.Add("@ModifyDate", SqlDbType.Date).Value = DateTime.Today.ToShortDateString();
                    cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "Deleted";

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    conn.Close();

                    CardReadOnly(null, null);

                    btnSign.Visible = false;
                    btnUnsign.Visible = false;

                    Response.Redirect("cardmgr.aspx");

                }
                catch (Exception ex)
                {
                    PopupTitle = "Delete Error: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
            }
        }

        protected void btnCancelClick(object sender, EventArgs e)
        {
            Response.Redirect("CardMgr.aspx");
        }

        protected void btnApproveClick(object sender, EventArgs e)
        {
            WriteApprovalInfoToCard(null, null);

            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    Int32 rowsAffected;

                    cmd.CommandText = "spUpdateRequestApproveCO";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = conn;

                    cmd.Parameters.Add("@CardNumber", SqlDbType.VarChar).Value = tbCardNumber.Text;
                    cmd.Parameters.Add("@ApprovedBy", SqlDbType.VarChar).Value = tbApprovedBy.Text;
                    cmd.Parameters.Add("@ApprovedRank", SqlDbType.VarChar).Value = tbApprovedRank.Text;
                    cmd.Parameters.Add("@ApprovedStar", SqlDbType.VarChar).Value = tbApprovedStar.Text;
                    cmd.Parameters.Add("@ApprovedDate", SqlDbType.Date).Value = DateTime.Now.ToShortDateString();
                    cmd.Parameters.Add("@SupervisorComments", SqlDbType.VarChar).Value = tbSupervisorComments.Text;

                    cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "approved";

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    conn.Close();

                    tbStatusId.Text = "approved";

                    SuccessMessage = "Card approved successfully";
                    DisplaySuccessDialog(null, null);

                    ConfigureButtons(null, null);
                }
                catch (Exception ex)
                {
                    PopupTitle = "Approval Error: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
            }
        }

        protected void btnReturnClick(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    Int32 rowsAffected;

                    cmd.CommandText = "spReturnRequestCO";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = conn;

                    cmd.Parameters.Add("@CardNumber", SqlDbType.VarChar).Value = tbCardNumber.Text;
                    cmd.Parameters.Add("@SupervisorComments", SqlDbType.VarChar).Value = tbSupervisorComments.Text;

                    cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "returned";

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    conn.Close();

                    SuccessMessage = "card returned to user";
                    DisplaySuccessDialog(null, null);

                    Response.Redirect("approvalmgr.aspx");
                }
                catch (Exception ex)
                {
                    PopupTitle = "return error: ";
                    ErrorMessage = ex.Message;
                    DisplayErrorDialog(null, null);
                }
            }
        }

        protected void DisplaySuccessDialog(object sender, EventArgs e)
        {
            PopupTitle = "Success!";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + SuccessMessage + "');", true);
        }

        protected void DisplayErrorDialog(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + ErrorMessage + "');", true);
        }
    }
}