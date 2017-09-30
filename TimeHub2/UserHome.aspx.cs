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
    public partial class UserHome : System.Web.UI.Page
    {
        DataSet ds = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            LogicLayer.SessionLogic.ValidateSession();

            DeclarePageCurrent(null, null);

            if (!Page.IsPostBack)
            {
                PopulateRecentRequests(null, null);
            }
        }

        protected void DeclarePageCurrent(object sender, EventArgs e)
        {
            System.Web.UI.HtmlControls.HtmlGenericControl li;

            li = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("liHome");

            li.Attributes.Add("class", "current-page");
        }

        protected void PopulateRecentRequests(object sender, EventArgs e)
        {
            //ds = TimeHub2.LogicLayer.GetRecentRequests(Convert.ToInt16(Session["UserId"]), true, false, false, false, false, false);
            ds = TimeHub2.LogicLayer.UserLogic.GetRecentRequests("UserHome");


            gvRecentRequests.DataSource = ds.Tables["all"];
            gvRecentRequests.DataBind();

            gvRecentRequests.UseAccessibleHeader = true;
            gvRecentRequests.HeaderRow.TableSection = TableRowSection.TableHeader;

        }
}
}