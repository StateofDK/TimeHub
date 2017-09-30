using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TimeHub2.Models
{
    public class User
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string MiddleInitial { get; set; }
        public string LastName { get; set; }
        public int UserStar { get; set; }
        public string UserRank { get; set; }
        public int UserRankId { get; set; }
        public string Assignment { get; set; }
        public string Shift { get; set; }
        public int ShiftId { get; set; }
        public string ContactPhone { get; set; }
        public string PhoneType { get; set; }
        public string Email { get; set; }
        public int AssignmentId { get; set; }
    }

    public class Rank
    {
        public int id { get; set; }
        public string code { get; set; }
        public string title { get; set; }
        public string DisplayName { get { return this.code + " - " + this.title; } }
    }

    public class Shift
    {
        public int intId { get; set; }
        public string strBeginTime { get; set; }
        public string strEndTime { get; set; }
        public int intDuration { get; set; }
        public string strDisplayName { get; set; }
    }

    public class Assignment
    {
        public int id { get; set; }
        public string name { get; set; }
        public string displayname { get; set; }
    }
}