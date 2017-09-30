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
    public partial class SupervisorEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                        //ErrorMessage = ex.Message;
                        //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + ErrorMessage + "');", true);
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                FirstGridViewRow();

                GetTrainingTypes(null, null);
                GetRequestTypes(null, null);
                GetOvertimeCode(null, null);
                GetShifts(null, null);
                GetCourtTypes(null, null);
                GetPTOTypes(null, null);
            }
            else
            {
                ShowSubTypes(null, null);
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

        protected void ShowSubTypes(object sender, EventArgs e)
        {
            switch (rblRequestType.SelectedValue)
            {
                case "co":
                    coSelections.Attributes["style"] = "";
                    break;

                case "ep":
                    epSelections.Attributes["style"] = "";
                    break;

                case "ot":
                    otSelections.Attributes["style"] = "";
                    break;

                case "to":
                    toSelections.Attributes["style"] = "";
                    break;

                case "tr":
                    trSelections.Attributes["style"] = "";
                    break;
            }
        }

        protected void btnLogOutClick(object sender, EventArgs e)
        {
            //show user logged in
            Session["New"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void GetTrainingTypes(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spSelectTrainingTypes", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    ddlTrainingCode.DataSource = ds;
                    ddlTrainingCode.DataTextField = "Category";
                    ddlTrainingCode.DataValueField = "ID";
                    ddlTrainingCode.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating training code dropdownlist: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
            ddlTrainingCode.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlTrainingCode.SelectedIndex = 0;
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

                    rblRequestType.DataSource = ds;
                    rblRequestType.DataTextField = "RequestType";
                    rblRequestType.DataValueField = "DisplayName";
                    rblRequestType.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating Request Type CheckBoxList: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
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

                    ddlOvertimeCode.DataSource = ds;
                    ddlOvertimeCode.DataTextField = "Type";
                    ddlOvertimeCode.DataValueField = "Id";
                    ddlOvertimeCode.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating overtime code dropdownlist: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
            ddlOvertimeCode.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlOvertimeCode.SelectedIndex = 0;
        }

        protected void GetShifts(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    //retreive Shifts from Shift table

                    SqlCommand cmd = new SqlCommand("spSelectShifts", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    foreach (GridViewRow row in gvEmployeeInfo.Rows)
                    {
                        DropDownList ddl = new DropDownList();
                        ddl = (DropDownList)row.FindControl("ddlShiftWorked");

                        ddl.DataSource = ds;
                        ddl.DataTextField = "DisplayName";
                        ddl.DataValueField = "ShiftId";
                        ddl.DataBind();

                        ddl.Items.Insert(0, new ListItem("--Select--", "0"));
                        ddl.SelectedIndex = 0;
                    }


                    //ddlShiftWorked.DataSource = ds;
                    //ddlShiftWorked.DataTextField = "DisplayName";
                    //ddlShiftWorked.DataValueField = "ShiftId";
                    //ddlShiftWorked.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating Request Type CheckBoxList: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
            //ddlShiftWorked.Items.Insert(0, new ListItem("--Select--", "0"));
            //ddlShiftWorked.SelectedIndex = 0;
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

                    rblCourtSession.DataSource = ds;
                    rblCourtSession.DataTextField = "SubType";
                    rblCourtSession.DataValueField = "Id";
                    rblCourtSession.DataBind();
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

                    rblCourtType.DataSource = ds;
                    rblCourtType.DataTextField = "SubType";
                    rblCourtType.DataValueField = "Id";
                    rblCourtType.DataBind();
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

                    rblAppearanceType.DataSource = ds;
                    rblAppearanceType.DataTextField = "SubType";
                    rblAppearanceType.DataValueField = "Id";
                    rblAppearanceType.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating court type radiobuttonlists: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }

            }
        }

        protected void GetPTOTypes(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    //retreive UserId from Session table

                    SqlCommand cmd = new SqlCommand("spSelectPTOTypes", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    conn.Open();

                    da.Fill(ds);

                    conn.Close();

                    rblTimeUsed.DataSource = ds;
                    rblTimeUsed.DataTextField = "Category";
                    rblTimeUsed.DataValueField = "display_name";
                    rblTimeUsed.DataBind();
                }
                catch (Exception ex)
                {
                    message = "error populating overtime code dropdownlist: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
        }

        protected void CommitEntries(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvEmployeeInfo.Rows)
            {
                TextBox tb = (TextBox)row.FindControl("txtStar");
                HyperLink h = (HyperLink)row.FindControl("hlRequestID");    
                string strCardNumber = null;

                string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Connection = conn;
                    cmd.CommandText = null;

                    //check if RequestID hyperlink is populated.  if populated it represents existing request and should use an update command.
                    if (!string.IsNullOrEmpty(h.Text) && !string.IsNullOrWhiteSpace(h.Text))
                    {
                        switch (rblRequestType.SelectedValue)
                        {
                            case "co":
                                cmd.CommandText = "spUpdateRequestCO";
                                break;

                            case "ep":
                                cmd.CommandText = "spUpdateRequestEP";
                                break;

                            case "ot":
                                cmd.CommandText = "spUpdateRequestOT";
                                break;

                            case "to":
                                cmd.CommandText = "spUpdateRequestTO";
                                break;

                            case "tr":
                                cmd.CommandText = "spUpdateRequestTR";
                                break;
                        }

                        //
                        strCardNumber = h.Text.ToString().Substring(h.Text.ToString().Length - 4, 4);
                        cmd.Parameters.Add("@CardNumber", SqlDbType.VarChar).Value = Convert.ToInt16(strCardNumber);
                    }

                    //if no RequestID, check to see if txtStar is populated. If so, no request exists and Insert command is used and appropriate parameters added to command.
                    else if (!string.IsNullOrEmpty(tb.Text) && !string.IsNullOrWhiteSpace(tb.Text) && (string.IsNullOrEmpty(h.Text)))
                    {
                        switch (rblRequestType.SelectedValue)
                        {
                            case "co":
                                cmd.CommandText = "spInsertRequestCO";
                                cmd.Parameters.Add("@RequestType", SqlDbType.VarChar).Value = "CO";
                                cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                                break;

                            case "ep":
                                cmd.CommandText = "spInsertRequestEP";
                                cmd.Parameters.Add("@RequestType", SqlDbType.VarChar).Value = "EP";
                                cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                                break;

                            case "ot":
                                cmd.CommandText = "spInsertRequestOT";
                                cmd.Parameters.Add("@RequestType", SqlDbType.VarChar).Value = "OT";
                                cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                                break;

                            case "to":
                                cmd.CommandText = "spInsertRequestTO";
                                cmd.Parameters.Add("@RequestType", SqlDbType.VarChar).Value = "TO";
                                cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                                break;

                            case "tr":
                                cmd.CommandText = "spInsertRequestTR";
                                cmd.Parameters.Add("@RequestType", SqlDbType.VarChar).Value = "TR";
                                cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                                break;
                        }
                    }

                    //add type specific parameters based on request type.
                    switch (rblRequestType.SelectedValue)
                    {
                        case "co":
                            cmd.Parameters.Add("@CaseNumber", SqlDbType.VarChar).Value = tbCaseNumber.Text;
                            cmd.Parameters.Add("@ShiftWorked", SqlDbType.Int).Value = ((DropDownList)row.FindControl("ddlShiftWorked") as DropDownList).SelectedValue;
                            cmd.Parameters.Add("@CourtSession", SqlDbType.VarChar).Value = rblCourtSession.SelectedValue;
                            cmd.Parameters.Add("@AppearanceType", SqlDbType.VarChar).Value = rblAppearanceType.SelectedValue;
                            cmd.Parameters.Add("@Department", SqlDbType.VarChar).Value = tbCourtDepartment.Text;
                            cmd.Parameters.Add("@CourtType", SqlDbType.VarChar).Value = rblCourtType.SelectedValue;
                            cmd.Parameters.Add("@Defendant", SqlDbType.VarChar).Value = tbDefendant.Text;
                            cmd.Parameters.Add("@Charges", SqlDbType.VarChar).Value = tbCharges.Text;
                            cmd.Parameters.Add("@CourtNumber", SqlDbType.Int).Value = Convert.ToInt32(tbCourtNumber.Text);
                            break;

                        case "ep":
                            cmd.Parameters.Add("@InPlaceName", SqlDbType.VarChar).Value = tbInPlaceName.Text;
                            cmd.Parameters.Add("@InPlaceRank", SqlDbType.VarChar).Value = tbInPlaceRank.Text;
                            break;

                        case "ot":
                            cmd.Parameters.Add("@CaseNumber", SqlDbType.VarChar).Value = tbCaseNumber.Text;
                            cmd.Parameters.Add("@ILHoliday", SqlDbType.VarChar).Value = tbILHoliday.Text;
                            cmd.Parameters.Add("@ShiftWorked", SqlDbType.Int).Value = ((DropDownList)row.FindControl("ddlShiftWorked") as DropDownList).SelectedValue;
                            cmd.Parameters.Add("@OTCode", SqlDbType.Int).Value = ddlOvertimeCode.SelectedValue;
                            cmd.Parameters.Add("@TimePay", SqlDbType.VarChar).Value = rblTimePay.SelectedValue;
                            cmd.Parameters.Add("@EventNumber", SqlDbType.VarChar).Value = tbAccountNumber.Text;
                            break;

                        case "to":
                            cmd.Parameters.Add("@TimeUsed", SqlDbType.VarChar).Value = rblTimeUsed.Text;
                            break;

                        case "tr":
                            cmd.Parameters.Add("@CaseNumber", SqlDbType.VarChar).Value = tbCaseNumber.Text;
                            cmd.Parameters.Add("@ILHoliday", SqlDbType.VarChar).Value = tbILHoliday.Text;
                            cmd.Parameters.Add("@TrainingCode", SqlDbType.Int).Value = ddlTrainingCode.SelectedValue;
                            break;
                    }

                    //add common parameters that are independent of request type.
                    cmd.Parameters.Add("@StarCredited", SqlDbType.Int).Value = ((TextBox)row.FindControl("txtStar") as TextBox).Text;

                    cmd.Parameters.Add("@BeginningDate", SqlDbType.Date).Value = tbBeginningDate.Text;
                    cmd.Parameters.Add("@EndingDate", SqlDbType.Date).Value = tbEndingDate.Text;
                    cmd.Parameters.Add("@BeginningTime", SqlDbType.Time).Value = DateTime.ParseExact(tbBeginningTime.Text, "HHmm", null).TimeOfDay;
                    cmd.Parameters.Add("@EndingTime", SqlDbType.Time).Value = DateTime.ParseExact(tbEndingTime.Text, "HHmm", null).TimeOfDay;
                    cmd.Parameters.Add("@TotalTime", SqlDbType.Int).Value = tbTotalTime.Text;

                    cmd.Parameters.Add("@SubmittedBy", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                    cmd.Parameters.Add("@DateSubmitted", SqlDbType.Date).Value = DateTime.Now;

                    cmd.Parameters.Add("@SupervisorComment", SqlDbType.VarChar).Value = ((TextBox)row.FindControl("txtSupervisorComment") as TextBox).Text;

                    //add returned card number as outparam
                    SqlParameter CardNumberOut = new SqlParameter();
                    CardNumberOut.ParameterName = "@CardNumberOut";
                    CardNumberOut.SqlDbType = System.Data.SqlDbType.Int;
                    CardNumberOut.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(CardNumberOut);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    strCardNumber = CardNumberOut.Value.ToString();
                    conn.Close();

                    //concatenate card number and request type into RequestID and write to hyperlink in gridview
                    string strCardId = (rblRequestType.SelectedValue.ToString().ToUpper()) + strCardNumber.ToString();

                    h.Text = strCardId.ToString();
                    h.NavigateUrl = rblRequestType.SelectedValue.ToString().ToUpper() + "Request.aspx?id=" + strCardNumber.ToString();
                }
            }
        }

        protected void PostCommitReadOnly(object sender, EventArgs e)
        {

        }

        private void FirstGridViewRow()
        {
            DataTable dt = new DataTable();
            DataRow dr = null;
            dt.Columns.Add(new DataColumn("#", typeof(string)));
            dt.Columns.Add(new DataColumn("Col1", typeof(string)));
            dt.Columns.Add(new DataColumn("Col2", typeof(string)));
            dt.Columns.Add(new DataColumn("Col3", typeof(string)));
            dt.Columns.Add(new DataColumn("Col4", typeof(string)));
            dt.Columns.Add(new DataColumn("Col5", typeof(string)));
            dt.Columns.Add(new DataColumn("Col6", typeof(string)));
            dt.Columns.Add(new DataColumn("Col7", typeof(string)));

            dr = dt.NewRow();
            dr["#"] = 1;
            dr["Col1"] = string.Empty;
            dr["Col2"] = string.Empty;
            dr["Col3"] = string.Empty;
            dr["Col4"] = string.Empty;
            dr["Col5"] = string.Empty;
            dr["Col6"] = string.Empty;
            dr["Col7"] = string.Empty;

            dt.Rows.Add(dr);

            ViewState["CurrentTable"] = dt;

            gvEmployeeInfo.DataSource = dt;
            gvEmployeeInfo.DataBind();

            int rowIndex = 0;

            //add onBlur attributes to controls within gridview to enable employee info population api

            TextBox TextBoxStar = (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[1].FindControl("txtStar");
            TextBoxStar.Attributes["onblur"] = "alertRowIndex(this, " + Convert.ToInt16(rowIndex) + ")";

            TextBox TextBoxName = (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[2].FindControl("txtName");
            TextBoxName.Attributes["onfocus"] = "FocusToStar()";

            TextBox TextBoxRank = (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[3].FindControl("txtRank");
            TextBoxRank.Attributes["onfocus"] = "FocusToStar()";

            TextBox TextBoxAssignment = (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[4].FindControl("txtAssignment");
            TextBoxAssignment.Attributes["onfocus"] = "FocusToStar()";


        }

        protected void ButtonAddNewRowClick(object sender, EventArgs e)
        {
            int intNewRowCount = Convert.ToInt16(((TextBox)gvEmployeeInfo.FooterRow.FindControl("txtAddRowCount")).Text);

            int rowIndex = 0;

            if (ViewState["CurrentTable"] != null)
            {
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    for (int i = 0; i < dtCurrentTable.Rows.Count; i++)
                    {
                        TextBox TextBoxStar =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[1].FindControl("txtStar");
                        TextBox TextBoxName =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[2].FindControl("txtName");
                        TextBox TextBoxRank =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[3].FindControl("txtRank");
                        TextBox TextBoxAssignment =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[4].FindControl("txtAssignment");
                        DropDownList DropDownListShiftWorked =
                          (DropDownList)gvEmployeeInfo.Rows[rowIndex].Cells[5].FindControl("ddlShiftWorked");
                        HyperLink HyperLinkRequestID =
                          (HyperLink)gvEmployeeInfo.Rows[rowIndex].Cells[6].FindControl("hlRequestID");
                        TextBox TextBoxSupervisorComment =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[7].FindControl("txtSupervisorComment");

                        drCurrentRow = dtCurrentTable.NewRow();
                        drCurrentRow["#"] = i + 1;

                        dtCurrentTable.Rows[i]["Col1"] = TextBoxStar.Text;
                        dtCurrentTable.Rows[i]["Col2"] = TextBoxName.Text;
                        dtCurrentTable.Rows[i]["Col3"] = TextBoxRank.Text;
                        dtCurrentTable.Rows[i]["Col4"] = TextBoxAssignment.Text;
                        dtCurrentTable.Rows[i]["Col5"] = DropDownListShiftWorked.SelectedValue;
                        dtCurrentTable.Rows[i]["Col6"] = HyperLinkRequestID.Text;
                        dtCurrentTable.Rows[i]["Col7"] = TextBoxSupervisorComment.Text;

                        rowIndex++;
                    }

                    dtCurrentTable.Rows.InsertAt(drCurrentRow, 0);

                    ViewState["CurrentTable"] = dtCurrentTable;

                    gvEmployeeInfo.DataSource = dtCurrentTable;
                    gvEmployeeInfo.DataBind();

                    GetShifts(null, null);
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }
            SetPreviousData();
        }

        private void SetPreviousData()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        TextBox TextBoxStar =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[1].FindControl("txtStar");
                        TextBox TextBoxName =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[2].FindControl("txtName");
                        TextBox TextBoxRank =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[3].FindControl("txtRank");
                        TextBox TextBoxAssignment =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[4].FindControl("txtAssignment");
                        DropDownList DropDownListShiftWorked =
                          (DropDownList)gvEmployeeInfo.Rows[rowIndex].Cells[5].FindControl("ddlShiftWorked");
                        HyperLink HyperLinkRequestID =
                          (HyperLink)gvEmployeeInfo.Rows[rowIndex].Cells[6].FindControl("hlRequestID");
                        TextBox TextBoxSupervisorComment =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[7].FindControl("txtSupervisorComment");

                        TextBoxStar.Text = dt.Rows[i]["Col1"].ToString();
                        TextBoxName.Text = dt.Rows[i]["Col2"].ToString();
                        TextBoxRank.Text = dt.Rows[i]["Col3"].ToString();
                        TextBoxAssignment.Text = dt.Rows[i]["Col4"].ToString();
                        DropDownListShiftWorked.Text = dt.Rows[i]["Col5"].ToString();
                        HyperLinkRequestID.Text = dt.Rows[i]["Col6"].ToString();
                        TextBoxSupervisorComment.Text = dt.Rows[i]["Col7"].ToString();

                        //add onBlur attribute to each txtStar to enable employee info population api
                        TextBoxStar.Attributes["onblur"] = "alertRowIndex(this," + Convert.ToInt16(rowIndex) + ")";
                        TextBoxName.Attributes["onfocus"] = "FocusToStar()";
                        TextBoxRank.Attributes["onfocus"] = "FocusToStar()";
                        TextBoxAssignment.Attributes["onfocus"] = "FocusToStar()";

                        rowIndex++;
                    }
                }
            }
        }

        protected void gvEmployeeInfo_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            HyperLink h = (HyperLink)gvEmployeeInfo.Rows[Convert.ToInt32(e.RowIndex)].FindControl("hlRequestId");

            if (string.IsNullOrEmpty(h.Text) && string.IsNullOrWhiteSpace(h.Text))
            {
                SetRowData();
                if (ViewState["CurrentTable"] != null)
                {
                    DataTable dt = (DataTable)ViewState["CurrentTable"];
                    DataRow drCurrentRow = null;
                    int rowIndex = Convert.ToInt32(e.RowIndex);
                    if (dt.Rows.Count > 1)
                    {
                        dt.Rows.Remove(dt.Rows[rowIndex]);
                        drCurrentRow = dt.NewRow();
                        ViewState["CurrentTable"] = dt;
                        gvEmployeeInfo.DataSource = dt;
                        gvEmployeeInfo.DataBind();

                        GetShifts(null, null);

                        for (int i = 0; i < gvEmployeeInfo.Rows.Count - 1; i++)
                        {
                            gvEmployeeInfo.Rows[i].Cells[0].Text = Convert.ToString(i + 1);
                        }
                        SetPreviousData();
                    }
                }
            }
            else
            {
                //put alert in here to say "cannot delete a row that has been committed to the database"
            }
        }

        private void SetRowData()
        {
            int rowIndex = 0;

            if (ViewState["CurrentTable"] != null)
            {
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {

                        TextBox TextBoxStar =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[1].FindControl("txtStar");
                        TextBox TextBoxName =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[2].FindControl("txtName");
                        TextBox TextBoxRank =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[3].FindControl("txtRank");
                        TextBox TextBoxAssignment =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[4].FindControl("txtAssignment");
                        DropDownList DropDownListShiftWorked =
                          (DropDownList)gvEmployeeInfo.Rows[rowIndex].Cells[5].FindControl("ddlShiftWorked");
                        HyperLink HyperLinkRequestID =
                          (HyperLink)gvEmployeeInfo.Rows[rowIndex].Cells[6].FindControl("hlRequestID");
                        TextBox TextBoxSupervisorComment =
                          (TextBox)gvEmployeeInfo.Rows[rowIndex].Cells[7].FindControl("txtSupervisorComment");

                        drCurrentRow = dtCurrentTable.NewRow();
                        drCurrentRow["#"] = i + 1;
                        dtCurrentTable.Rows[i - 1]["Col1"] = TextBoxStar.Text;
                        dtCurrentTable.Rows[i - 1]["Col2"] = TextBoxName.Text;
                        dtCurrentTable.Rows[i - 1]["Col3"] = TextBoxRank.Text;
                        dtCurrentTable.Rows[i - 1]["Col4"] = TextBoxAssignment.Text;
                        dtCurrentTable.Rows[i - 1]["Col5"] = DropDownListShiftWorked.SelectedValue;
                        dtCurrentTable.Rows[i - 1]["Col6"] = HyperLinkRequestID.Text;
                        dtCurrentTable.Rows[i - 1]["Col7"] = TextBoxSupervisorComment.Text;

                        rowIndex++;
                    }
                    ViewState["CurrentTable"] = dtCurrentTable;
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }
            //SetPreviousData();
        }
    }
}