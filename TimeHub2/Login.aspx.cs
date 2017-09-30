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
    public partial class Login : System.Web.UI.Page
    {
        TimeHub2.Models.User u = new TimeHub2.Models.User();

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["id"] = null;
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            u = TimeHub2.LogicLayer.UserLogic.GetUser(null, tbUsername.Text);

            string passwordOut = u.Password;

            if (passwordOut == tbPassword.Text)
            {
                CreateSession(null, null);

                Response.Redirect("~/UserHome.aspx");
            }
        }

        protected void CreateSession(object sender, EventArgs e)
        {
            //generate SessionId
            var AvailableCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyx1234567890";
            var random = new Random();
            var SessionId = new string(Enumerable.Repeat(AvailableCharacters, 20).Select(s => s[random.Next(s.Length)]).ToArray());

            Session["id"] = SessionId.ToString();

            Session["UserId"] = u.UserId;
            Session["UserName"] = u.UserName;
            Session["Password"] = u.Password;
            Session["FirstName"] = u.FirstName;
            Session["MiddleInitial"] = u.MiddleInitial;
            Session["LastName"] = u.LastName;
            Session["UserStar"] = u.UserStar;
            Session["UserRank"] = u.UserRank;
            Session["UserRankId"] = u.UserRankId;
            Session["Assignment"] = u.Assignment;
            Session["AssignmentId"] = u.AssignmentId;
            Session["Shift"] = u.Shift;
            Session["ShiftId"] = u.ShiftId;
            Session["ContactPhone"] = u.ContactPhone;
            Session["PhoneType"] = u.PhoneType;
            Session["Email"] = u.Email;


            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                //insert session id
                try
                {
                    SqlCommand cmd = new SqlCommand("spInsertSessionId", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = tbUsername.Text;
                    cmd.Parameters.Add("@createdate", SqlDbType.DateTime2).Value = DateTime.Now;
                    cmd.Parameters.Add("@SessionId", SqlDbType.VarChar).Value = SessionId.ToString();

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    //message = "error inserting session: " + ex.Message;
                    //ClientScript.RegisterStartupScript(GetType(), "Popup", "ShowPopup('" + message + "');", true);
                }
            }
        }
    }
}