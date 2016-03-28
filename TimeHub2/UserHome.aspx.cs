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
    public partial class WebForm7 : System.Web.UI.Page
    {
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
                PopulateRecentRequestTable(null, null);
            }
        }

        protected void lbtn_logout_Click(object sender, EventArgs e)
        {
            Session["New"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void RedirectOTCard(object sender, EventArgs e)
        {
            Response.Redirect("OTRequest.aspx");
        }

        protected void RedirectCourtCard(object sender, EventArgs e)
        {
            Response.Redirect("CORequest.aspx");
        }

        protected void RedirectTimeOffCard(object sender, EventArgs e)
        {
            Response.Redirect("TORequest.aspx");
        }

        protected void RedirectTrainingCard(object sender, EventArgs e)
        {
            Response.Redirect("TRRequest.aspx");
        }

        protected void RedirectEqualPayCard(object sender, EventArgs e)
        {
            Response.Redirect("EPRequest.aspx");
        }

        protected void PopulateRecentRequestTable(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                SqlCommand cmd = new SqlCommand();
                cmd = new SqlCommand("spSelectRecentRequestsAll", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = lblUserLoggedIn.Text;

                SqlDataAdapter daRecentRequests = new SqlDataAdapter();
                daRecentRequests.SelectCommand = cmd;

                DataTable dtRecentRequests = new DataTable();

                try
                {
                    conn.Open();
                    daRecentRequests.Fill(dtRecentRequests);

                    conn.Close();
                
                    gvRecentRequests.DataSource = dtRecentRequests;
                    gvRecentRequests.DataBind();

                    gvRecentRequests.UseAccessibleHeader = true;
                    gvRecentRequests.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
                catch (Exception ex)
                {
                    if (ex is NullReferenceException)
                    {
                        PopupTitle = "Null reference on populating recent request table: ";
                        message = ex.Message;
                        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                    }
                    else
                    {
                        PopupTitle = "error populating recent request table: ";
                        message = ex.Message;
                        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                    }
                }
            }
        }
    }
}