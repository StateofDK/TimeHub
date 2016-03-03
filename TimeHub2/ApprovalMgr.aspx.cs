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

namespace TimeHub2
{
    public partial class ApprovalMgrTest : System.Web.UI.Page
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
                        PopupTitle = "error retrieving UserID: ";
                        message = ex.Message;
                        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                    }
                }
            }
            //else redirect to login
            else
            {
                Response.Redirect("Login.aspx");
            }

            PopulateCardManagers(null, null);
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

        protected void logOutClick(object sender, EventArgs e)
        {
            //show user logged in
            Session["New"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void PopulateCardManagers(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                SqlCommand cmdFillOT = new SqlCommand();
                SqlCommand cmdFillCO = new SqlCommand();
                SqlCommand cmdFillTO = new SqlCommand();
                SqlCommand cmdFillTR = new SqlCommand();
                SqlCommand cmdFillEP = new SqlCommand();

                cmdFillOT = new SqlCommand("spSelectPendingRequestsOT", conn);
                cmdFillCO = new SqlCommand("spSelectPendingRequestsCO", conn);
                cmdFillTO = new SqlCommand("spSelectPendingRequestsTO", conn);
                cmdFillTR = new SqlCommand("spSelectPendingRequestsTR", conn);
                cmdFillEP = new SqlCommand("spSelectPendingRequestsEP", conn);

                cmdFillOT.CommandType = System.Data.CommandType.StoredProcedure;
                cmdFillCO.CommandType = System.Data.CommandType.StoredProcedure;
                cmdFillTO.CommandType = System.Data.CommandType.StoredProcedure;
                cmdFillTR.CommandType = System.Data.CommandType.StoredProcedure;
                cmdFillEP.CommandType = System.Data.CommandType.StoredProcedure;

                cmdFillOT.Parameters.Add("@UserId", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                cmdFillCO.Parameters.Add("@UserId", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                cmdFillTO.Parameters.Add("@UserId", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                cmdFillTR.Parameters.Add("@UserId", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;
                cmdFillEP.Parameters.Add("@UserId", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;

                DataSet dsRequests = new DataSet();

                DataTable dtOTCards;
                DataTable dtCOCards;
                DataTable dtTOCards;
                DataTable dtTRCards;
                DataTable dtEPCards;

                dsRequests.Tables.Add("dtOTCards");
                dsRequests.Tables.Add("dtCOCards");
                dsRequests.Tables.Add("dtTOCards");
                dsRequests.Tables.Add("dtTRCards");
                dsRequests.Tables.Add("dtEPCards");

                dtOTCards = dsRequests.Tables[0];
                dtCOCards = dsRequests.Tables[1];
                dtTOCards = dsRequests.Tables[2];
                dtTRCards = dsRequests.Tables[3];
                dtEPCards = dsRequests.Tables[4];

                SqlDataAdapter daPendingRequestsOT = new SqlDataAdapter();
                SqlDataAdapter daPendingRequestsCO = new SqlDataAdapter();
                SqlDataAdapter daPendingRequestsTO = new SqlDataAdapter();
                SqlDataAdapter daPendingRequestsTR = new SqlDataAdapter();
                SqlDataAdapter daPendingRequestsEP = new SqlDataAdapter();

                daPendingRequestsOT.SelectCommand = cmdFillOT;
                daPendingRequestsCO.SelectCommand = cmdFillCO;
                daPendingRequestsTO.SelectCommand = cmdFillTO;
                daPendingRequestsTR.SelectCommand = cmdFillTR;
                daPendingRequestsEP.SelectCommand = cmdFillEP;

                conn.Open();

                int RowCount = new int();

                try
                {
                        daPendingRequestsOT.Fill(dtOTCards);

                        gvPendingRequestsOT.DataSource = dtOTCards;
                        gvPendingRequestsOT.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating OT Card Manager: ";
                    message = ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
                try
                {
                    daPendingRequestsCO.Fill(dtCOCards);

                    gvPendingRequestsCO.DataSource = dtCOCards;
                    gvPendingRequestsCO.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating CO Card Manager: ";
                    message =  ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
                try
                {
                    daPendingRequestsTO.Fill(dtTOCards);

                    gvPendingRequestsTO.DataSource = dtTOCards;
                    gvPendingRequestsTO.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating TO Card Manager: ";
                    message = ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + ex.Message + "');", true);
                }
                try
                {
                    daPendingRequestsTR.Fill(dtTRCards);

                    gvPendingRequestsTR.DataSource = dtTRCards;
                    gvPendingRequestsTR.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating TR Card Manager: ";
                    message = ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + ex.Message + "');", true);
                }
                try
                {
                    daPendingRequestsEP.Fill(dtEPCards);

                    gvPendingRequestsEP.DataSource = dtEPCards;
                    gvPendingRequestsEP.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating EP Card Manager: ";
                    message = ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + ex.Message + "');", true);
                }
            }
        }
    }
}