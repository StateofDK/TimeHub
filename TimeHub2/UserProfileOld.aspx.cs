using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace TimeHub2
{
    public partial class UserProfile : System.Web.UI.Page
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

                        userloggedin.Text = UserIdOut;
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("error retreiving session username: " + ex.Message);
                    }
                }
            }
            //else redirect to login
            else
                Response.Redirect("Login.aspx");

            if (!Page.IsPostBack)
            {
                PopulateFields(null, null);
            }
        }

        protected void LogOutClick(object sender, EventArgs e)
        {
            //show user logged in
            Session["New"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void PopulateFields(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spPopulateProfile", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = userloggedin.Text;

                    SqlParameter UserName = new SqlParameter();
                    SqlParameter FirstName = new SqlParameter();
                    SqlParameter MiddleInitial = new SqlParameter();
                    SqlParameter LastName = new SqlParameter();
                    SqlParameter UserStar = new SqlParameter();
                    SqlParameter UserRank = new SqlParameter();
                    SqlParameter Assignment = new SqlParameter();
                    SqlParameter Shift = new SqlParameter();
                    SqlParameter ContactPhone = new SqlParameter();
                    SqlParameter PhoneType = new SqlParameter();
                    SqlParameter Email = new SqlParameter();

                    UserName.ParameterName = "@UserName";
                    FirstName.ParameterName = "@FirstName";
                    MiddleInitial.ParameterName = "@MiddleInitial";
                    LastName.ParameterName = "@LastName";
                    UserStar.ParameterName = "@UserStar";
                    UserRank.ParameterName = "@UserRank";
                    Assignment.ParameterName = "@Assignment";
                    Shift.ParameterName = "@Shift";
                    ContactPhone.ParameterName = "@ContactPhone";
                    PhoneType.ParameterName = "@PhoneType";
                    Email.ParameterName = "@Email";

                    UserName.SqlDbType = System.Data.SqlDbType.VarChar;
                    FirstName.SqlDbType = System.Data.SqlDbType.VarChar;
                    MiddleInitial.SqlDbType = System.Data.SqlDbType.VarChar;
                    LastName.SqlDbType = System.Data.SqlDbType.VarChar;
                    UserStar.SqlDbType = System.Data.SqlDbType.VarChar;
                    UserRank.SqlDbType = System.Data.SqlDbType.VarChar;
                    Assignment.SqlDbType = System.Data.SqlDbType.VarChar;
                    Shift.SqlDbType = System.Data.SqlDbType.VarChar;
                    ContactPhone.SqlDbType = System.Data.SqlDbType.VarChar;
                    PhoneType.SqlDbType = System.Data.SqlDbType.VarChar;
                    Email.SqlDbType = System.Data.SqlDbType.VarChar;

                    UserName.Size = 200;
                    FirstName.Size = 200;
                    MiddleInitial.Size = 200;
                    LastName.Size = 200;
                    UserStar.Size = 200;
                    UserRank.Size = 200;
                    Assignment.Size = 200;
                    Shift.Size = 200;
                    ContactPhone.Size = 200;
                    PhoneType.Size = 200;
                    Email.Size = 200;

                    UserName.Direction = System.Data.ParameterDirection.Output;
                    FirstName.Direction = System.Data.ParameterDirection.Output;
                    MiddleInitial.Direction = System.Data.ParameterDirection.Output;
                    LastName.Direction = System.Data.ParameterDirection.Output;
                    UserStar.Direction = System.Data.ParameterDirection.Output;
                    UserRank.Direction = System.Data.ParameterDirection.Output;
                    Assignment.Direction = System.Data.ParameterDirection.Output;
                    Shift.Direction = System.Data.ParameterDirection.Output;
                    ContactPhone.Direction = System.Data.ParameterDirection.Output;
                    PhoneType.Direction = System.Data.ParameterDirection.Output;
                    Email.Direction = System.Data.ParameterDirection.Output;

                    cmd.Parameters.Add(UserName);
                    cmd.Parameters.Add(FirstName);
                    cmd.Parameters.Add(MiddleInitial);
                    cmd.Parameters.Add(LastName);
                    cmd.Parameters.Add(UserStar);
                    cmd.Parameters.Add(UserRank);
                    cmd.Parameters.Add(Assignment);
                    cmd.Parameters.Add(Shift);
                    cmd.Parameters.Add(ContactPhone);
                    cmd.Parameters.Add(PhoneType);
                    cmd.Parameters.Add(Email);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string UserNameOut = UserName.Value.ToString();
                    string FirstNameOut = FirstName.Value.ToString();
                    string MiddleInitialOut = MiddleInitial.Value.ToString();
                    string LastNameOut = LastName.Value.ToString();
                    string UserStarOut = UserStar.Value.ToString();
                    string UserRankOut = UserRank.Value.ToString();
                    string AssignmentOut = Assignment.Value.ToString();
                    string ShiftOut = Shift.Value.ToString();
                    string ContactPhoneOut = ContactPhone.Value.ToString();
                    string PhoneTypeOut = PhoneType.Value.ToString();
                    string EmailOut = Email.Value.ToString();

                    username.Text = UserNameOut;
                    first_name.Text = FirstNameOut;
                    middle_initial.Text = MiddleInitialOut;
                    last_name.Text = LastNameOut;
                    star.Text = UserStarOut;
                    rank.Text = UserRankOut;
                    ddl_assignment.Text = AssignmentOut;
                    ddl_shift.Text = ShiftOut;
                    contact_phone.Text = ContactPhoneOut;
                    phone_type.Text = PhoneTypeOut;
                    email.Text = EmailOut;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("card population error: " + ex.Message);
                }
            }
        }

        protected void UpdateProfile(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spUpdateProfile", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = userloggedin.Text;

                    cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = first_name.Text;
                    cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = last_name.Text;
                    cmd.Parameters.Add("@MiddleInitial", SqlDbType.VarChar).Value = middle_initial.Text;
                    cmd.Parameters.Add("@Assignment", SqlDbType.VarChar).Value = ddl_assignment.Text;
                    cmd.Parameters.Add("@Rank", SqlDbType.VarChar).Value = rank.Text;
                    cmd.Parameters.Add("@Star", SqlDbType.VarChar).Value = star.Text;

                    cmd.Parameters.Add("@ContactPhone", SqlDbType.VarChar).Value = contact_phone.Text;
                    cmd.Parameters.Add("@PhoneType", SqlDbType.VarChar).Value = phone_type.Text;
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = email.Text;
                    cmd.Parameters.Add("@Shift", SqlDbType.VarChar).Value = ddl_shift.Text;

                    cmd.Parameters.Add("@ModifyDate", SqlDbType.VarChar).Value = DateTime.Now.ToString();
                    cmd.Parameters.Add("@ModifiedBy", SqlDbType.VarChar).Value = userloggedin.Text;
                    cmd.Parameters.Add("@StatusId", SqlDbType.VarChar).Value = "active";

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    MessageBox.Show("Profile updated successfully!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Profile update error:  " + ex.Message);
                }
            }
        }

        protected void ResetFields(object sender, EventArgs e)
        {
            PopulateFields(null, null);
        }
    }
}