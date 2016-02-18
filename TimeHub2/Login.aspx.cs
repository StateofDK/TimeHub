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
    public partial class WebForm6 : System.Web.UI.Page
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

        protected void Login_Click(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spSelectPassword", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = tb_username.Text;

                    SqlParameter password = new SqlParameter();
                    password.ParameterName = "@password";
                    password.SqlDbType = System.Data.SqlDbType.VarChar;
                    password.Size = 200;
                    password.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(password);
                    
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string passwordOut = password.Value.ToString();

                    if (passwordOut == tb_password.Text)
                    {

                        CreateSession(null, null);
                        
                        Response.Redirect("~/UserHome.aspx");
                    }
                    else
                    {
                        message = "that username/password combination does not exist";
                        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                    }
                }
                catch(Exception ex)
                {
                    //catch placed to swallow "thread was being aborted" exception.  C# was throwing exception even as the login and redirect occurred properly.
                }
            }
        }

        protected void CreateSession(object sender, EventArgs e)
        {
            //generate SessionId
            var AvailableCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyx1234567890";
            var random = new Random();
            var SessionId = new string(Enumerable.Repeat(AvailableCharacters, 20).Select(s => s[random.Next(s.Length)]).ToArray());

            String UserIdOut = null;

            Session["New"] = SessionId.ToString();

            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                //retreive user id
                try
                {
                    SqlCommand cmd = new SqlCommand("spInsertSessionId", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = tb_username.Text;
                    cmd.Parameters.Add("@createdate", SqlDbType.DateTime2).Value = DateTime.Now;
                    cmd.Parameters.Add("@SessionId", SqlDbType.VarChar).Value = SessionId.ToString();

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    message = "error inserting session: " + ex.Message;
                    ClientScript.RegisterStartupScript(GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
        }

        protected void RegisterClick(object sender, EventArgs e)
        {
            Response.Redirect("RegisterUser.aspx");
        }
    }
}