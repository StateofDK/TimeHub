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
    public partial class SupervisorHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            string cmdstring = "SELECT COUNT(*) FROM ViewAllRequests WHERE status_id LIKE 'Submitted';";

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = System.Data.CommandType.Text;

            using (SqlConnection conn = new SqlConnection(connstring))
            {
                cmd.Connection = conn;
                cmd.CommandText = cmdstring;
                try
                {
                    
                    conn.Open();
                    int intRecordCount = (int)cmd.ExecuteScalar();
                    conn.Close();

                    lblPendingRequestCount.Text = intRecordCount.ToString();
                }
                catch (Exception ex)
                {
                    message = "search error: ";
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + ex.Message + "');", true);
                }
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
    }
}