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
    public partial class CardManager : System.Web.UI.Page
    {
        DataSet ds = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            //DeclarePageCurrent(null, null);

            if (!Page.IsPostBack)
            {

            }
            LogicLayer.SessionLogic.ValidateSession();

            PopulateCardManagers(null, null);
        }

        protected void PopulateCardManagers(object sender, EventArgs e)
        {
            //ds = TimeHub2.LogicLayer.GetRecentRequests(Convert.ToInt16(Session["UserId"]), false, true, true, true, true, true);
            ds = TimeHub2.LogicLayer.UserLogic.GetRecentRequests("CardManager");

            gvRecentRequestsCO.DataSource = ds.Tables["co"];
            gvRecentRequestsCO.DataBind();

            gvRecentRequestsCO.UseAccessibleHeader = true;
            gvRecentRequestsCO.HeaderRow.TableSection = TableRowSection.TableHeader;


            
            gvRecentRequestsOT.DataSource = ds.Tables["ot"];
            gvRecentRequestsOT.DataBind();

            gvRecentRequestsOT.UseAccessibleHeader = true;
            gvRecentRequestsOT.HeaderRow.TableSection = TableRowSection.TableHeader;



            gvRecentRequestsTO.DataSource = ds.Tables["to"];
            gvRecentRequestsTO.DataBind();

            gvRecentRequestsTO.UseAccessibleHeader = true;
            gvRecentRequestsTO.HeaderRow.TableSection = TableRowSection.TableHeader;


            
            gvRecentRequestsTR.DataSource = ds.Tables["tr"];
            gvRecentRequestsTR.DataBind();

            gvRecentRequestsTR.UseAccessibleHeader = true;
            gvRecentRequestsTR.HeaderRow.TableSection = TableRowSection.TableHeader;



            gvRecentRequestsEP.DataSource = ds.Tables["ep"];
            gvRecentRequestsEP.DataBind();

            gvRecentRequestsEP.UseAccessibleHeader = true;
            gvRecentRequestsEP.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}