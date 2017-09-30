using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace TimeHub2
{
    public class EmployeeController : ApiController
    {
        //api routes declared in global.asax.cs

        public DataSet GetEmployeeInfo(int star)
        {
            //query employee data by star number

            DataSet ds = new DataSet();

            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    //SqlCommand cmd = new SqlCommand("SELECT users.user_id , users.user_star , users.last_name , users.first_name, users.middle_initial, users.user_rank, [shift].DisplayName AS 'regular_shift', assignment.AssignmentName AS 'assignment' FROM users JOIN [shift]	ON	users.regular_shift	LIKE [shift].ShiftId JOIN assignment ON users.assignment LIKE assignment.AssignmentId WHERE users.user_star =" + star + "AND status_id LIKE 'active'", conn);
                    SqlCommand cmd = new SqlCommand("SELECT users.user_id , users.user_star , users.last_name , users.first_name , users.middle_initial , users.user_rank , users.regular_shift , assignment.AssignmentName AS 'assignment' FROM users JOIN assignment	ON	users.assignment LIKE assignment.AssignmentId WHERE users.user_star = " + star + "AND status_id LIKE 'active'", conn);
                    cmd.CommandType = System.Data.CommandType.Text;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);


                    conn.Open();

                    da.Fill(ds);

                    conn.Close();


                }
                catch (Exception ex)
                {

                }
            }


            return ds;
        }
    }
}