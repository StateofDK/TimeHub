using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Windows.Forms;
using TimeHub2.Models;


namespace TimeHub2
{
    public partial class OvertimeRequestTest : System.Web.UI.Page
    {
        DataTable dt = new DataTable();

        int n = new int();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GetShifts(null, null);
                GetAssignments(null, null);
                GetRanks(null, null);
                GetHolidays(null, null);
                GetOvertimeCodes(null, null);
            }
            LogicLayer.SessionLogic.ValidateSession();
            FillData(null, null);
        }

        protected void GetShifts(object sender, EventArgs e)
        {
            ddlShift.DataSource = DataLayer.ShiftList();
            ddlShift.DataTextField = "strDisplayName";
            ddlShift.DataValueField = "intId";
            ddlShift.DataBind();

            ddlShift.Items.Insert(0, new ListItem("-Select-", "0"));
            ddlShift.SelectedValue = 0.ToString();
        }

        protected void GetAssignments(object sender, EventArgs e)
        {
            ddlAssignment.DataSource = DataLayer.ListAssignment();
            ddlAssignment.DataTextField = "name";
            ddlAssignment.DataValueField = "id";
            ddlAssignment.DataBind();

            ddlAssignment.Items.Insert(0, new ListItem("-Select-", "0"));
            ddlAssignment.SelectedValue = 0.ToString();
        }

        protected void GetRanks(object sender, EventArgs e)
        {
            ddlSubmittedRank.DataSource = DataLayer.ListRank();
            ddlSubmittedRank.DataTextField = "DisplayName";
            ddlSubmittedRank.DataValueField = "id";
            ddlSubmittedRank.DataBind();

            ddlSubmittedRank.Items.Insert(0, new ListItem("-Select-", "0"));
            ddlSubmittedRank.SelectedValue = 0.ToString();


            ddlApprovedRank.DataSource = DataLayer.ListRank();
            ddlApprovedRank.DataTextField = "DisplayName";
            ddlApprovedRank.DataValueField = "id";
            ddlApprovedRank.DataBind();

            ddlApprovedRank.Items.Insert(0, new ListItem("-Select-", "0"));
            ddlApprovedRank.SelectedValue = 0.ToString();
        }

        protected void GetHolidays(object sender, EventArgs e)
        {
            ddlILHoliday.DataSource = DataLayer.ILHoliday.ListHoliday();
            ddlILHoliday.DataTextField = "name";
            ddlILHoliday.DataValueField = "id";
            ddlILHoliday.DataBind();

            ddlILHoliday.Items.Insert(0, new ListItem("-Select-", "0"));
            ddlILHoliday.SelectedValue = 0.ToString();
        }

        protected void GetOvertimeCodes(object sender, EventArgs e)
        {
            ddlOvertimeCode.DataSource = DataLayer.OvertimeCode.ListOvertimeCode();
            ddlOvertimeCode.DataTextField = "displayname";
            ddlOvertimeCode.DataValueField = "id";
            ddlOvertimeCode.DataBind();

            ddlOvertimeCode.Items.Insert(0, new ListItem("-Select-", "0"));
            ddlOvertimeCode.SelectedValue = 0.ToString();
        }

        protected void FillData(object sender, EventArgs e)
        {
            int id;

            bool result = Int32.TryParse(Request["id"], out id);
            if (result)
            {
                //conversion was successful
                lblRequestId.Text = id.ToString();
            }
            else
            {
                //id was empty or null
                FillUserData(null, null);
                ddlOvertimeCode.Focus();
            }
        }

        protected void FillUserData(object sender, EventArgs e)
        {
            tbLastName.Text = Session["LastName"].ToString();
            tbFirstName.Text = Session["FirstName"].ToString();
            tbMiddleInitial.Text = Session["MiddleInitial"].ToString();
            ddlAssignment.SelectedValue = Session["AssignmentId"].ToString();
            ddlShift.SelectedValue = Session["ShiftId"].ToString();

            tbLastName.Attributes.Add("disabled", null);
            tbFirstName.Attributes.Add("disabled", null);
            tbMiddleInitial.Attributes.Add("disabled", null);
            ddlAssignment.Attributes.Add("disabled", null);
            ddlShift.Attributes.Add("disabled", null);
            tbTotalTime.Attributes.Add("ReadOnly", "True");

            btnApprove.Attributes.Add("style", "display: none");
            btnReturn.Attributes.Add("style", "display: none");
            btnSubmit.Attributes.Add("style", "display: none");
            btnDelete.Attributes.Add("style", "display: none");
            btnUnSign.Attributes.Add("style", "display: none");
        }

        protected void RequestTransaction(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.Button btn = (System.Web.UI.WebControls.Button)sender;
            OvertimeRequest r = new OvertimeRequest();
            Transaction t = new Transaction();

            //set properties of Transaction
            t.Requester = Int32.Parse(Session["Userid"].ToString());
            r.RequestType = "ot";
            t.TransactionType = btn.Text.ToLower();
            if ((!string.IsNullOrEmpty(lblRequestId.Text)) && (!string.IsNullOrWhiteSpace(lblRequestId.Text)))
            {
                r.RequestNumber = Convert.ToInt16((lblRequestId.Text).Remove(0, 3));
            };

            //set properties of request based
            r.CreditedUser = Convert.ToInt16(Session["UserId"].ToString());
            r.Detail = tbDetail.Text;
            r.InLieuHoliday = ddlILHoliday.SelectedValue;
            r.CompType = Convert.ToInt16(rblCompType.SelectedValue);
            r.OvertimeCode = Convert.ToInt16(ddlOvertimeCode.SelectedValue);
            r.ShiftWorked = Convert.ToInt16(ddlShift.SelectedValue);
            r.CreatedBy = Convert.ToInt16(Session["Userid"]);
            r.ModifiedBy = Convert.ToInt16(Session["Userid"]);
            r.BeginningDate = DateTime.Parse(tbBeginningDate.Text);
            r.EndingDate = DateTime.Parse(tbEndingDate.Text);
            r.TotalTime = Convert.ToInt16(tbTotalTime.Text);

            if ((!string.IsNullOrEmpty(tbCaseNumber.Text)) && (!string.IsNullOrWhiteSpace(tbCaseNumber.Text)))
            {
                r.CaseNumber = Convert.ToInt16(tbCaseNumber.Text);
            };
            if ((!string.IsNullOrEmpty(tbComments.Text)) && (!string.IsNullOrWhiteSpace(tbComments.Text)))
            {
                r.Comment = tbComments.Text;
            };
            if (!string.IsNullOrEmpty(tbSubmittedBy.Text))
            {
                r.SubmittedBy = tbSubmittedBy.Text;
            };
            if (!string.IsNullOrEmpty(tbApprovedBy.Text))
            {
                r.ApprovedBy = tbApprovedBy.Text;
            };

            //package transaction together with request
            r.transaction = t;
            RequestPackage rp = new RequestPackage();
            rp.OvertimeRequests.Add(r);
            rp = LogicLayer.RequestLogic.ProcessRequestPackage(rp);

            //n = LogicLayer.RequestTransaction(t, r);

            lblRequestId.Text = " - " + r.RequestNumber;

            //alter to usercontrols based on transaction type
            switch (t.TransactionType)
            {
                case "save":
                    break;
                case "sign":
                    tbSubmittedBy.Text = Session["UserName"].ToString();
                    tbSubmittedDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    tbSubmittedStar.Text = Session["UserStar"].ToString();
                    ddlSubmittedRank.SelectedValue = Session["UserRank"].ToString();

                    ddlOvertimeCode.Attributes.Add("ReadOnly", "True");
                    ddlShift.Attributes.Add("disabled", null);
                    ddlILHoliday.Attributes.Add("disabled", null);
                    tbBeginningDate.ReadOnly = true;
                    tbEndingDate.ReadOnly = true;
                    tbCaseNumber.ReadOnly = true;
                    tbCertifiedBy.ReadOnly = true;
                    tbComments.ReadOnly = true;
                    //add code to disable rblCompType

                    btnSign.Attributes.Add("style", "display: none");
                    btnUnSign.Attributes.Remove("style");
                    break;
                case "unsign":
                    tbSubmittedBy.Text = string.Empty;
                    tbSubmittedDate.Text = string.Empty;
                    tbSubmittedStar.Text = string.Empty;
                    ddlSubmittedRank.SelectedValue = "0";

                    ddlOvertimeCode.Attributes.Remove("ReadOnly");
                    ddlShift.Attributes.Remove("disabled");
                    ddlILHoliday.Attributes.Remove("disabled");
                    tbBeginningDate.ReadOnly = false;
                    tbEndingDate.ReadOnly = false;
                    tbCaseNumber.ReadOnly = false;
                    tbCertifiedBy.ReadOnly = false;
                    tbComments.ReadOnly = false;
                    //add code to enable rblCompType

                    btnUnSign.Attributes.Add("style", "display: none");
                    btnSign.Attributes.Remove("style");
                    break;
                case "approve":
                    break;
                case "return":
                    break;
                case "delete":
                    break;
            };
        }
    }
}