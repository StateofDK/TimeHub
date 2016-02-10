using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace TimeHub2
{
    public partial class CardMgrTest : System.Web.UI.Page
    {
        public string message
        {
            get;
            set;
        }

        public string PopupTitle
        {
            get;
            set;
        }

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

                cmdFillOT = new SqlCommand("spSelectRecentRequestsOT", conn);
                cmdFillCO = new SqlCommand("spSelectRecentRequestsCO", conn);
                cmdFillTO = new SqlCommand("spSelectRecentRequestsTO", conn);
                cmdFillTR = new SqlCommand("spSelectRecentRequestsTR", conn);
                cmdFillEP = new SqlCommand("spSelectRecentRequestsEP", conn);

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

                SqlDataAdapter daRecentRequestsOT = new SqlDataAdapter();
                SqlDataAdapter daRecentRequestsCO = new SqlDataAdapter();
                SqlDataAdapter daRecentRequestsTO = new SqlDataAdapter();
                SqlDataAdapter daRecentRequestsTR = new SqlDataAdapter();
                SqlDataAdapter daRecentRequestsEP = new SqlDataAdapter();

                daRecentRequestsOT.SelectCommand = cmdFillOT;
                daRecentRequestsCO.SelectCommand = cmdFillCO;
                daRecentRequestsTO.SelectCommand = cmdFillTO;
                daRecentRequestsTR.SelectCommand = cmdFillTR;
                daRecentRequestsEP.SelectCommand = cmdFillEP;

                conn.Open();

                try
                {
                    daRecentRequestsOT.Fill(dtOTCards);

                    gvRecentRequestsOT.DataSource = dtOTCards;
                    gvRecentRequestsOT.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating OT Card Manager: ";
                    message = ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
                try
                {
                    daRecentRequestsCO.Fill(dtCOCards);

                    gvRecentRequestsCO.DataSource = dtCOCards;
                    gvRecentRequestsCO.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating CO Card Manager: ";
                    message = ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
                try
                {
                    daRecentRequestsTO.Fill(dtTOCards);

                    gvRecentRequestsTO.DataSource = dtTOCards;
                    gvRecentRequestsTO.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating TO Card Manager: ";
                    message = ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
                try
                {
                    daRecentRequestsTR.Fill(dtTRCards);

                    gvRecentRequestsTR.DataSource = dtTRCards;
                    gvRecentRequestsTR.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating TR Card Manager: ";
                    message =  ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
                try
                {
                    daRecentRequestsEP.Fill(dtEPCards);

                    gvRecentRequestsEP.DataSource = dtEPCards;
                    gvRecentRequestsEP.DataBind();
                }
                catch (Exception ex)
                {
                    PopupTitle = "error populating EP Card Manager: ";
                    message = ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
        }

        protected void RedirectCORequest(object sender, EventArgs e)
        {
            Response.Redirect("CORequest.aspx");
        }

        protected void RedirectEPRequest(object sender, EventArgs e)
        {
            Response.Redirect("EPRequest.aspx");
        }

        protected void RedirectOTCard(object sender, EventArgs e)
        {
            Response.Redirect("OTRequest.aspx");
        }

        protected void RedirectTRRequest(object sender, EventArgs e)
        {
            Response.Redirect("TRRequest.aspx");
        }

        protected void RedirectTORequest(object sender, EventArgs e)
        {
            Response.Redirect("TORequest.aspx");
        }
    }
}