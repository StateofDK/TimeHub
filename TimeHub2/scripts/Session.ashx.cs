using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace TimeHub2.scripts
{
    /// <summary>
    /// Store values for Session State to make them accessible to JQuery/ Javascript
    /// </summary>
    public class Session : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/javascript";

            context.Response.Write("var TIMEHUB = {};");
            context.Response.Write("TIMEHUB.sessionId = '" + context.Session["id"] + "';");
            context.Response.Write("TIMEHUB.userId = " + context.Session["UserId"] + ";");
            context.Response.Write("TIMEHUB.userName = '" + context.Session["UserName"] + "';");
            context.Response.Write("TIMEHUB.password = '" + context.Session["Password"] + "';");
            context.Response.Write("TIMEHUB.firstName = '" + context.Session["FirstName"] + "';");
            context.Response.Write("TIMEHUB.middleInitial = '" + context.Session["MiddleInitial"] + "';");
            context.Response.Write("TIMEHUB.lastName = '" + context.Session["LastName"] + "';");
            context.Response.Write("TIMEHUB.userStar = " + context.Session["UserStar"] + ";");
            context.Response.Write("TIMEHUB.userRank = '" + context.Session["UserRank"] + "';");
            context.Response.Write("TIMEHUB.userRankId = " + context.Session["UserRankId"] + ";");
            context.Response.Write("TIMEHUB.assignment = '" + context.Session["Assignment"] + "';");
            context.Response.Write("TIMEHUB.assignmentId = " + context.Session["AssignmentId"] + ";");
            context.Response.Write("TIMEHUB.shift = '" + context.Session["Shift"] + "';");
            context.Response.Write("TIMEHUB.shiftId = " + context.Session["ShiftId"] + ";");
            context.Response.Write("TIMEHUB.contactPhone = '" + context.Session["ContactPhone"] + "';");
            context.Response.Write("TIMEHUB.phoneType = '" + context.Session["PhoneType"] + "';");
            context.Response.Write("TIMEHUB.email = '" + context.Session["Email"] + "';");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}