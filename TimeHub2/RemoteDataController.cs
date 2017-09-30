using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace TimeHub2
{
    public class RemoteDataController : ApiController
    {
        // api routes declared in global.asax.cs
        
        public DataSet GetTotalHours(int CreditedUser)
        {
            DataSet ds = new DataSet();

            string connstring = ConfigurationManager.ConnectionStrings["TimeHubDBCS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("TESTspSelectTotalHoursByMonth", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = DataLayer.intUserLoggedIn;
                    cmd.Parameters.Add("@CurrentDate", SqlDbType.Date).Value = DateTime.Now;
                    DateTime d = new DateTime();
                    d = DateTime.Today; 
                    d = d.AddDays(-(d.Day-1));
                    d = d.AddMonths(-11);
                    cmd.Parameters.Add("@TargetDate", SqlDbType.DateTime2).Value = d;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);

                    conn.Open();
                    da.Fill(ds);
                    conn.Close();

                    DataTable t = ds.Tables[0];
                    int cm = DateTime.Now.Month;
                    int cy = DateTime.Now.Year;
                    int bm = d.Month;
                    int by = d.Year;
                    
                    for (int n = 0; n < 12; n++)
                    {
                        DataRow r = t.NewRow();
                        r["month_worked"] = bm;
                        r["year_worked"] = by;
                        r["total_hours"] = 0;

                        if (t.Rows.Count <= n)
                        {
                            t.Rows.InsertAt(r, n);
                        }   

                        int m = Convert.ToInt32(t.Rows[n]["month_worked"].ToString());
                        int y = Convert.ToInt32(t.Rows[n]["year_worked"].ToString());
                        int h = Convert.ToInt32(t.Rows[n]["total_hours"].ToString());

                        if (y != by)
                        {
                            t.Rows.InsertAt(r, n);
                        }
                        else
                        {
                            if (m != bm)
                            {
                                t.Rows.InsertAt(r, n);
                            }
                        };

                        //increment up month/year
                        if (bm != 12)
                        {
                            bm++;
                        }
                        else
                        {
                            bm = 1;
                            by++;
                        };
                    };

                    t.Columns.Add("display_date", typeof(string));

                    foreach (DataRow row in t.Rows)
                    {
                        string str = row["year_worked"] + "/" + row["month_worked"] + "/01";
                        DateTime dtime = Convert.ToDateTime(str);
                        string dtimestr = dtime.ToString("MMM yyyy");
                        row["display_date"] = dtimestr;
                    };

                    //resort datatable with new rows
                    DataView v = new DataView(t);
                    v.Sort = "year_worked ASC, month_worked ASC";
                    ds.Tables.Clear();
                    ds.Tables.Add(v.ToTable());


                }
                catch (Exception ex)
                {

                }
            }

            return ds;
        }
    }
}