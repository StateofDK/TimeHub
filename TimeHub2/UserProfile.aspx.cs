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
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //DeclarePageCurrent(null, null);

            if (!Page.IsPostBack)
            {
                GetShifts(null, null);
                GetPhoneTypes(null, null);
                GetAssignments(null, null);
                GetRanks(null, null);
            }
            LogicLayer.SessionLogic.ValidateSession();

            PopulateUserData(null, null);
            PopulateRecentActivity(null, null);
            PopulateTopJobs(null, null);
        }

        protected void PopulateUserData(object sender, EventArgs e)
        {
            TimeHub2.LogicLayer.UserLogic.GetUser(DataLayer.intUserLoggedIn, null);

            TimeHub2.Models.User u = new TimeHub2.Models.User();

            lblFullName.Text = " " + Session["FirstName"] + " " + Session["MiddleInitial"] + " " + Session["LastName"] + " #" + Session["UserStar"];
            lblAssignment.Text = " " + Session["Assignment"];
            lblRank.Text = " " + Session["UserRank"];
            lblPhone.Text = " " + Session["ContactPhone"];
            lblEmail.Text = " " + Session["Email"];
            lblShift.Text = " " + Session["Shift"];
            ddlAssignment.SelectedValue = Session["AssignmentId"].ToString();
            ddlRank.SelectedValue = Session["UserRankId"].ToString();
            tbPhone.Text = Session["ContactPhone"].ToString();
            ddlPhoneType.SelectedValue = Session["PhoneType"].ToString();
            tbFirstName.Text = Session["FirstName"].ToString();
            tbMiddleInitial.Text = Session["MiddleInitial"].ToString();
            tbLastName.Text = Session["LastName"].ToString();   
            tbStar.Text = Session["UserStar"].ToString();
            tbEmailAddress.Text = Session["Email"].ToString();
            ddlShift.SelectedValue = Session["ShiftId"].ToString();
        }

        protected void PopulateRecentActivity(object sender, EventArgs e)
        {
            TimeHub2.Models.User u = new Models.User();
            u.UserId = DataLayer.intUserLoggedIn;

            DataTable dt = LogicLayer.UserLogic.GetRecentUserActivity(u);

            rptrRecentActivity.DataSource = dt;
            rptrRecentActivity.DataBind();
        }

        protected void PopulateTopJobs(object sender, EventArgs e)
        {
            //populates 'top jobs' tab on user profile

            TimeHub2.Models.User u = new Models.User();
            u.UserId = DataLayer.intUserLoggedIn;

            DataTable dt = LogicLayer.UserLogic.GetUserJobsTotals(u);

            if (dt.Rows.Count > 0)
            {
                dt.Columns.Add("percent_of_total", typeof(Int32));
                double sumHours = Convert.ToInt32(dt.Compute("sum(total_hours)", ""));
                double hours;
                double percent;

                //inserts percentages for each job to use with progress bars
                foreach (DataRow r in dt.Rows)
                {
                    hours = Convert.ToInt32(r["total_hours"].ToString());
                    percent = Math.Round(((hours / sumHours)*100),0);
                    r["percent_of_total"] = percent;
                }

                rptrTopJobs.DataSource = dt;
                rptrTopJobs.DataBind();
            }
        }

        protected void UpdateProfile(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spUpdateProfile", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = DataLayer.intUserLoggedIn;

                    cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = tbFirstName.Text;
                    cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = tbLastName.Text;
                    cmd.Parameters.Add("@MiddleInitial", SqlDbType.VarChar).Value = tbMiddleInitial.Text;
                    cmd.Parameters.Add("@Assignment", SqlDbType.VarChar).Value = ddlAssignment.SelectedValue;
                    cmd.Parameters.Add("@Rank", SqlDbType.VarChar).Value = ddlRank.SelectedValue;
                    cmd.Parameters.Add("@Star", SqlDbType.Int).Value = Convert.ToInt16(tbStar.Text);

                    cmd.Parameters.Add("@ContactPhone", SqlDbType.VarChar).Value = tbPhone.Text;
                    cmd.Parameters.Add("@PhoneType", SqlDbType.VarChar).Value = ddlPhoneType.SelectedValue;
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = tbEmailAddress.Text;
                    cmd.Parameters.Add("@Shift", SqlDbType.VarChar).Value = ddlShift.SelectedValue;

                    cmd.Parameters.Add("@ModifiedBy", SqlDbType.VarChar).Value = DataLayer.intUserLoggedIn;
                    cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "active";

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    //message = "profile updated successfully: ";
                    //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
                catch (Exception ex)
                {
                    //message = "profile updated error: " + ex.Message;
                    //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
        }

        protected void GetPhoneTypes(object sender, EventArgs e)
        {
            ddlPhoneType.DataSource = DataLayer.PhoneType.PhoneTypeList();
            ddlPhoneType.DataTextField = "strDisplayName";
            ddlPhoneType.DataValueField = "strValue";
            ddlPhoneType.DataBind();
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

        protected void GetAssignments (object sender, EventArgs e)
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
            ddlRank.DataSource = DataLayer.ListRank();
            ddlRank.DataTextField = "DisplayName";
            ddlRank.DataValueField = "id";
            ddlRank.DataBind();

            ddlRank.Items.Insert(0, new ListItem("-Select-", "0"));
            ddlRank.SelectedValue = 0.ToString();
        }
    }
}