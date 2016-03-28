using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace TimeHub2.stylesheets
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //show user logged in
            if (Session["New"] != null)
            {
                string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    try
                    {
                        //retreive UserId from Session table

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
                    }
                    catch (Exception ex)
                    {
                        message = "error retreiving session userID: " + ex.Message;
                        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                    }
                }
            }
            //else redirect to login
            else
            {
                Response.Redirect("Login.aspx");
            }

            if (!Page.IsPostBack)
            {
                GetAssignments(null, null);
                GetRequestTypes(null, null);
                GetOvertimeCode(null, null);
                GetCourtTypes(null, null);
                GetTrainingTypes(null, null);
            }
        }

        public string PopupTitle
        {
            get;
            set;
        }

        public string message
        {
            get;
            set;
        }

        protected void btnLogOutClick(object sender, EventArgs e)
        {
            //show user logged in
            Session["New"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void btnSearchClick(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            string cmdstring = "SELECT * FROM ViewAllRequests WHERE card_number IS NOT NULL ";

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = System.Data.CommandType.Text;

            if ((!string.IsNullOrEmpty(tbCardNumber.Text)) && !string.IsNullOrWhiteSpace(tbCardNumber.Text))
            {
                string strRequestID;
                string strRequestType;
                int intRequestNumber;

                strRequestID = tbCardNumber.Text.ToString();
                strRequestType = strRequestID.Substring(0, 2);
                intRequestNumber = Convert.ToInt16(strRequestID.Substring(2));

                cmd.Parameters.Add("@RequestType", SqlDbType.VarChar).Value = strRequestType.ToString();
                cmd.Parameters.Add("@RequestNumber", SqlDbType.Int).Value = Convert.ToInt16(intRequestNumber.ToString());

                cmdstring = cmdstring + "AND RequestType = @RequestType AND card_number = @RequestNumber ";
            }
            else
            {
                string strTemp = "AND (";
                string strItemSelected = null;

                //add conditions that are independent of Request Type
                if ((!string.IsNullOrWhiteSpace(tbUsername.Text.ToString())) && (!string.IsNullOrWhiteSpace(tbUsername.Text.ToString())))
                {
                    cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = tbUsername.Text + "%";
                    cmdstring = "DECLARE @UserID Int = (SELECT user_id FROM dbo.users WHERE username LIKE @Username) " + cmdstring + "AND UserCredited LIKE @UserID ";
                }
                if ((!string.IsNullOrWhiteSpace(tbUserStar.Text.ToString())) && (!string.IsNullOrWhiteSpace(tbUserStar.Text.ToString())))
                {
                    cmd.Parameters.Add("@UserStar", SqlDbType.Int).Value = Convert.ToInt16(tbUserStar.Text.ToString());
                    cmdstring = cmdstring + "AND user_star LIKE @UserStar ";
                }
                if (!(Convert.ToInt16(ddlAssignment.SelectedValue) == 0))
                {
                    cmd.Parameters.Add("@Assignment", SqlDbType.Int).Value = Convert.ToInt16(ddlAssignment.SelectedValue);
                    cmdstring = cmdstring + "AND assignment LIKE @Assignment ";
                }
                if ((!string.IsNullOrWhiteSpace(tbAccountNumber.Text.ToString())) && (!string.IsNullOrEmpty(tbAccountNumber.Text.ToString())))
                {
                    cmd.Parameters.Add("@AccountNumber", SqlDbType.VarChar).Value = tbAccountNumber.Text.ToString();
                    cmdstring = cmdstring + "AND event_number LIKE @AccountNumber";
                }
                if ((!string.IsNullOrWhiteSpace(tbCaseNumber.Text.ToString())) && (!string.IsNullOrEmpty(tbCaseNumber.Text.ToString())))
                {
                    cmd.Parameters.Add("@CaseNumber", SqlDbType.VarChar).Value = tbAccountNumber.Text.ToString();
                    cmdstring = cmdstring + "AND case_number LIKE @CaseNumber";
                }
                if ((!string.IsNullOrEmpty(tbBeginningDate.Text.ToString())) && (!string.IsNullOrWhiteSpace(tbBeginningDate.Text.ToString())))
                {
                    cmd.Parameters.Add("@BeginningDate", SqlDbType.DateTime).Value = Convert.ToDateTime(tbBeginningDate.Text);
                    cmdstring = cmdstring + "AND beginning_date = @BeginningDate ";
                }
                else if ((!string.IsNullOrEmpty(tbDateRangeBegin.Text.ToString())) && (!string.IsNullOrWhiteSpace(tbDateRangeBegin.Text.ToString())))
                {
                    cmd.Parameters.Add("@DateRangeBegin", SqlDbType.Date).Value = Convert.ToDateTime(tbDateRangeBegin.Text);
                    cmd.Parameters.Add("@DateRangeEnd", SqlDbType.Date).Value = Convert.ToDateTime(tbDateRangeEnd.Text);
                    cmdstring = cmdstring + "AND (BeginningDate BETWEEN @DateRangeBegin AND DateRangeEnd) ";
                }


                //add selected Request Types to command string
                //test if individual items have been selected **FLAG001**
                for (int i = 0; i < cblRequestType.Items.Count; i++)
                {
                    if (cblRequestType.Items[i].Selected)
                    {
                        //If item is selected, add to temporary string
                        strItemSelected = cblRequestType.Items[i].Value;
                        strTemp = strTemp + "RequestType = '" + strItemSelected + "' OR ";
                    }
                }
                //trim 'or' off end of temporary string and replace with ')' to complete condition in temporary string
                if (strTemp.EndsWith(" OR "))
                {
                    strTemp = strTemp.Remove(strTemp.Length - 4);
                    strTemp = strTemp + " ) ";
                }

                //test if temporary string had been altered from original declared value
                if (strTemp != "AND (")//this line should not be added after every subtype.---------------------------------------
                {
                    //append value of temporary string to command string
                    cmdstring = cmdstring + strTemp;
                    //reset temporary string to original value
                    strTemp = "AND (";
                }


                //add request subtypes to command statement
                if (cmdstring.Contains("'ot'"))
                {
                    //duplicate of code to test if request types are selected  **FLAG001**
                    for (int i = 0; i < cblOTCode.Items.Count; i++)
                    {
                        if (cblOTCode.Items[i].Selected)
                        {
                            strItemSelected = cblOTCode.Items[i].Text;
                            strTemp = strTemp + "OTCode = " + strItemSelected + " OR ";
                        }
                    }
                }
                if (strTemp.EndsWith(" OR "))
                {
                    strTemp = strTemp.Remove(strTemp.Length - 4);
                    strTemp = strTemp + " ) ";
                }
                if (strTemp != "AND (")
                {
                    cmdstring = cmdstring + strTemp;
                    strTemp = "AND (";
                }


                if (cmdstring.Contains("'co'"))
                {
                    //duplicate of code to test if request types are selected  **FLAG001**
                    for (int i = 0; i < cblCourtSession.Items.Count; i++)
                    {
                        if (cblCourtSession.Items[i].Selected)
                        {
                            strItemSelected = cblCourtSession.Items[i].Text;
                            strTemp = strTemp + "court_session = '" + strItemSelected + "' OR ";
                        }
                    }
                    if (strTemp.EndsWith(" OR "))
                    {
                        strTemp = strTemp.Remove(strTemp.Length - 4);
                        strTemp = strTemp + " ) ";
                    }

                    if (strTemp != "AND (")
                    {
                        cmdstring = cmdstring + strTemp;
                        strTemp = "AND (";
                    }


                    //duplicate of code to test if request types are selected  **FLAG001**
                    for (int i = 0; i < cblCourtType.Items.Count; i++)
                    {
                        if (cblCourtType.Items[i].Selected)
                        {
                            strItemSelected = cblCourtType.Items[i].Text;
                            strTemp = strTemp + "court_type = '" + strItemSelected + "' OR ";
                        }
                    }
                    if (strTemp.EndsWith(" OR "))
                    {
                        strTemp = strTemp.Remove(strTemp.Length - 4);
                        strTemp = strTemp + " ) ";
                    }

                    if (strTemp != "AND (")
                    {
                        cmdstring = cmdstring + strTemp;
                        strTemp = "AND (";
                    }


                    //duplicate of code to test if request types are selected  **FLAG001**
                    for (int i = 0; i < cblAppearanceType.Items.Count; i++)
                    {
                        if (cblAppearanceType.Items[i].Selected)
                        {
                            strItemSelected = cblAppearanceType.Items[i].Text;
                            strTemp = strTemp + "appearance_type = '" + strItemSelected + "' OR ";
                        }
                    }
                    if (strTemp.EndsWith(" OR "))
                    {
                        strTemp = strTemp.Remove(strTemp.Length - 4);
                        strTemp = strTemp + " ) ";
                    }

                    if (strTemp != "AND (")
                    {
                        cmdstring = cmdstring + strTemp;
                        strTemp = "AND (";
                    }
                }
                if (cmdstring.Contains("'tr'"))
                {
                    for (int i = 0; i < cblTrainingCode.Items.Count; i++)
                    {
                        if (cblTrainingCode.Items[i].Selected)
                        {
                            strItemSelected = cblTrainingCode.Items[i].Text;
                            strTemp = strTemp + "ot_Code = " + strItemSelected + " OR ";
                        }
                    }
                    if (strTemp.EndsWith(" OR "))
                    {
                        strTemp = strTemp.Remove(strTemp.Length - 4);
                        strTemp = strTemp + " ) ";
                    }

                    if (strTemp != "AND (")
                    {
                        cmdstring = cmdstring + strTemp;
                        strTemp = "AND (";
                    }
                }
            }
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                cmd.Connection = conn;
                cmd.CommandText = cmdstring;

                SqlDataAdapter daSearchResults = new SqlDataAdapter();
                daSearchResults.SelectCommand = cmd;

                DataTable dtSearchResults = new DataTable();

                try
                {
                    conn.Open();
                    daSearchResults.Fill(dtSearchResults);

                    conn.Close();
                }
                catch (Exception ex)
                {
                    message = "search error: ";
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + ex.Message + "');", true);
                }

                gvSearchResults.DataSource = dtSearchResults;
                gvSearchResults.DataBind();

                gvSearchResults.UseAccessibleHeader = true;
                gvSearchResults.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void GetAssignments(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    //retreive UserId from Session table

                    SqlCommand cmd = new SqlCommand("spSelectAssignments", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    ddlAssignment.DataSource = ds;
                    ddlAssignment.DataTextField = "DisplayName";
                    ddlAssignment.DataValueField = "AssignmentId";
                    ddlAssignment.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating assignment dropdownlist: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
            ddlAssignment.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlAssignment.SelectedIndex = 0;
        }

        protected void GetRequestTypes(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    //retreive UserId from Session table

                    SqlCommand cmd = new SqlCommand("spSelectRequestTypes", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    cblRequestType.DataSource = ds;
                    cblRequestType.DataTextField = "RequestType";
                    cblRequestType.DataValueField = "DisplayName";
                    cblRequestType.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating Request Type CheckBoxList: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
                cblRequestType.Items.Insert(0, new ListItem("All Request Types", "0"));
            }
        }

        protected void GetOvertimeCode(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    //retreive UserId from Session table

                    SqlCommand cmd = new SqlCommand("spSelectOvertimeCodes", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    cblOTCode.DataSource = ds;
                    cblOTCode.DataTextField = "Type";
                    cblOTCode.DataValueField = "Id";
                    cblOTCode.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating overtime code dropdownlist: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
        }

        protected void GetCourtTypes(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    //retreive UserId from Session table

                    SqlCommand cmd = new SqlCommand("spSelectCourtSessions", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    cblCourtSession.DataSource = ds;
                    cblCourtSession.DataTextField = "SubType";
                    cblCourtSession.DataValueField = "Id";
                    cblCourtSession.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating court type radiobuttonlists: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }

                try
                {
                    //retreive UserId from Session table

                    SqlCommand cmd = new SqlCommand("spSelectCourtTypes", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    cblCourtType.DataSource = ds;
                    cblCourtType.DataTextField = "SubType";
                    cblCourtType.DataValueField = "Id";
                    cblCourtType.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating court type radiobuttonlists: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }

                try
                {
                    //retreive UserId from Session table

                    SqlCommand cmd = new SqlCommand("spSelectCourtAppearances", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    cblAppearanceType.DataSource = ds;
                    cblAppearanceType.DataTextField = "SubType";
                    cblAppearanceType.DataValueField = "Id";
                    cblAppearanceType.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating court type radiobuttonlists: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }

            }
        }

        protected void GetTrainingTypes(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    //retreive UserId from Session table

                    SqlCommand cmd = new SqlCommand("spSelectTrainingTypes", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    cblTrainingCode.DataSource = ds;
                    cblTrainingCode.DataTextField = "Category";
                    cblTrainingCode.DataValueField = "ID";
                    cblTrainingCode.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating training code dropdownlist: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
            //cblTrainingCode.Items.Insert(0, new ListItem("--Select--", "0"));
        }
    }
}