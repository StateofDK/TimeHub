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

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                cmd.Connection = conn;

                //declare parameters that are independent of request type
                cmd.Parameters.Add("@CardNumber", SqlDbType.VarChar).Value = tbCardNumber.Text;
                cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = tbUsername.Text;
                cmd.Parameters.Add("@Assignment", SqlDbType.VarChar).Value = ddlAssignment.SelectedValue;
                cmd.Parameters.Add("@BeginningDate", SqlDbType.VarChar).Value = tbBeginningDate.Text;

                //declare sqlcommand arguments and parameters that are dependent on request type
                switch (ddlRequestType.SelectedValue.ToString().ToLower())
                {
                    case "co":
                        cmd = new SqlCommand("spSearchCORequests", conn);

                        cmd.Parameters.Add("@CourtSession", SqlDbType.VarChar).Value = rblCourtSession.SelectedValue;
                        cmd.Parameters.Add("@CourtType", SqlDbType.VarChar).Value = rblCourtType.SelectedValue;
                        cmd.Parameters.Add("@AppearanceType", SqlDbType.VarChar).Value = rblAppearanceType.SelectedValue;
                        break;
                    case "ep":
                        cmd = new SqlCommand("spSearchEPRequests", conn);
                        break;
                    case "ot":

                        cmd.CommandText = "spSearchOTRequests";
                        //cmd = new SqlCommand("spSearchOTRequests", conn);

                        cmd.Parameters.Add("@AccountNumber", SqlDbType.VarChar).Value = tbAccountNumber.Text;
                        cmd.Parameters.Add("@OTCode", SqlDbType.VarChar).Value = ddlOTCode.SelectedValue;
                        break;
                    case "to":
                        cmd = new SqlCommand("spSearchTORequests", conn);
                        break;
                    case "tr":
                        cmd = new SqlCommand("spSearchTRRequests", conn);

                        cmd.Parameters.Add("@TrainingCode", SqlDbType.VarChar).Value = ddlTrainingCode.SelectedValue;
                        break;
                }

                SqlDataAdapter daSearchResults = new SqlDataAdapter();
                daSearchResults.SelectCommand = cmd;

                DataTable dtSearchResults = new DataTable();

                try
                {
                    conn.Open();
                    daSearchResults.Fill(dtSearchResults);

                    conn.Close();
                }
                catch(Exception ex)
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
    }
}