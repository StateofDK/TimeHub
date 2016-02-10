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
    public partial class RegisterUser : System.Web.UI.Page
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

        protected void SubmitClick(object sender, EventArgs e)
        {
            string Password = tbPassword.Text.ToLower().ToString();
            string ConfirmPassword = tbConfirmPassword.Text.ToLower().ToString();

            int UsernameLength = tbUsername.Text.Length;
            int MinimumUsernameLength = 6;

            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                //test if password and confirmation match
                if (Password.Equals(ConfirmPassword))
                {
                    //test if username meets minimum length
                    if (UsernameLength >= MinimumUsernameLength)
                    {
                        //search users table for existing username
                        try
                        {
                            SqlCommand cmd = new SqlCommand("spSelectUsername", conn);
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;

                            cmd.Parameters.Add("@UsernameIn", SqlDbType.VarChar).Value = tbUsername.Text;

                            SqlParameter UsernameOut = new SqlParameter();
                            UsernameOut.ParameterName = "@UsernameOut";
                            UsernameOut.SqlDbType = System.Data.SqlDbType.VarChar;
                            UsernameOut.Size = 200;
                            UsernameOut.Direction = System.Data.ParameterDirection.Output;
                            cmd.Parameters.Add(UsernameOut);

                            conn.Open();
                            cmd.ExecuteNonQuery();

                            conn.Close();

                            //if new username is unique, insert user
                            if (string.IsNullOrEmpty(UsernameOut.Value.ToString()))
                            {
                                try
                                {
                                    cmd = new SqlCommand("spInsertuser", conn);
                                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                                    cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = tbUsername.Text;
                                    cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value = tbPassword.Text;

                                    conn.Open();
                                    int RowsAffected = cmd.ExecuteNonQuery();
                                    conn.Close();

                                    if (RowsAffected == 0)
                                    {
                                        message = "Error: unable to register username";
                                        DisplayErrorDialog(null, null);
                                    }
                                    else
                                    {
                                        message = "new user registered successfully.  please login.";
                                        DisplaySuccessDialog(null, null);
                                    }
                                }
                                catch (Exception ex)
                                {
                                    message = "error inserting username";
                                    DisplayErrorDialog(null, null);
                                }
                            }
                            else
                            {
                                message = "the username entered already exists";
                                DisplayErrorDialog(null, null);
                            }
                        }
                        catch (Exception ex)
                        {
                            message = "Error checking submitted username against database";
                            DisplayErrorDialog(null, null);
                        }
                    }
                    else
                    {
                        message = "the username entered is not long enough";
                        DisplayErrorDialog(null, null);
                    }
                }
                else
                {
                    message = "Password and password confirmation must match";
                    DisplayErrorDialog(null, null);
                }
            }

            //string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            //using (SqlConnection conn = new SqlConnection(connstring))
            //{
            //    try
            //    {
            //        SqlCommand cmd = new SqlCommand();
            //        Int32 rowsAffected;

            //        cmd.CommandText = "user_insert";
            //        cmd.CommandType = CommandType.StoredProcedure;
            //        cmd.Connection = conn;

            //        cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = username.Text;
            //        cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password.Text;

            //        conn.Open();
            //        rowsAffected = cmd.ExecuteNonQuery();

            //        conn.Close();

            //        Response.Write("Registration successful!");
            //    }
            //    catch (Exception ex)
            //    {
            //        Response.Write("Error" + ex.Message);
            //    }
            //}
        }

        protected void DisplaySuccessDialog(object sender, EventArgs e)
        {
            PopupTitle = "Success!";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
        }

        protected void DisplayErrorDialog(object sender, EventArgs e)
        {
            PopupTitle = "Error!";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
        }
    }
}