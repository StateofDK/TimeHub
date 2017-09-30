using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TimeHub2.Models;
using System.Data;

namespace TimeHub2
{
    public class DataLayer
    {
        public static int intUserLoggedIn { get; set; }
        public static int intRequestNumber { get; set; }

        public class PhoneType
        {
            public string strValue { get; set; }
            public string strDisplayName { get; set; }

            public static List<PhoneType> PhoneTypeList()
            {
                return new List<PhoneType>
                {
                    new PhoneType {strValue = "", strDisplayName = "-Select-"},
                    new PhoneType {strValue = "cell", strDisplayName = "Cell"},
                    new PhoneType {strValue = "home", strDisplayName = "Home"},
                    new PhoneType {strValue = "work", strDisplayName = "Work"},
                };
            }
        }

        public class ILHoliday
        {
            public int id { get; set; }
            public string name { get; set; }

            public static List<ILHoliday> ListHoliday()
            {
                return new List<ILHoliday>
                {
                    new ILHoliday {id = 1, name = "New Years Day"},
                    new ILHoliday {id = 2, name = "Martin Luther King Jr. Day"},
                    new ILHoliday {id = 3, name = "Presidents Day"},
                    new ILHoliday {id = 4, name = "Memorial Day"},
                    new ILHoliday {id = 5, name = "Independence Day"},
                    new ILHoliday {id = 6, name = "Labor Day"},
                    new ILHoliday {id = 7, name = "Columbus Day"},
                    new ILHoliday {id = 8, name = "Veterans Day"},
                    new ILHoliday {id = 9, name = "Thanksgiving"},
                    new ILHoliday {id = 10, name = "Thanksgiving (Day After)"},
                    new ILHoliday {id = 11, name = "Christmas Day"},
                };
            }
        }

        public class OvertimeCode
        {
            public int id { get; set; }
            public string name { get; set; }
            public string displayname { get { return this.id + " - " + this.name; } set { } }

            public static List<OvertimeCode> ListOvertimeCode()
            {
                return new List<OvertimeCode>
                {
                    new OvertimeCode {id = 1, name = "10B PLES" },
                    new OvertimeCode {id = 2, name = "Investigation" },
                    new OvertimeCode {id = 3, name = "Arrest" },
                    new OvertimeCode {id = 4, name = "Misc" },
                    new OvertimeCode {id = 5, name = "EWW" },
                    new OvertimeCode {id = 6, name = "Holiday" },
                    new OvertimeCode {id = 7, name = "In-Lieu Holiday", displayname = "IL" }
                };
            }
        }

        public static List<Models.Shift> ShiftList()
        {
            return new List<Shift>
            {
                new Shift { intId = 1, strBeginTime = "0000", strEndTime = "0800", intDuration = 8, strDisplayName = "0000-0800" },
                new Shift { intId = 2, strBeginTime = "0100", strEndTime = "0900", intDuration = 8, strDisplayName = "0100-0900" },
                new Shift { intId = 3, strBeginTime = "0200", strEndTime = "1000", intDuration = 8, strDisplayName = "0200-1000" },
                new Shift { intId = 4, strBeginTime = "0300", strEndTime = "1100", intDuration = 8, strDisplayName = "0300-1100" },
                new Shift { intId = 5, strBeginTime = "0400", strEndTime = "1200", intDuration = 8, strDisplayName = "0400-1200" },
                new Shift { intId = 6, strBeginTime = "0500", strEndTime = "1300", intDuration = 8, strDisplayName = "0500-1300" },
                new Shift { intId = 7, strBeginTime = "0600", strEndTime = "1400", intDuration = 8, strDisplayName = "0600-1400" },
                new Shift { intId = 8, strBeginTime = "0700", strEndTime = "1500", intDuration = 8, strDisplayName = "0700-1500" },
                new Shift { intId = 9, strBeginTime = "0800", strEndTime = "1600", intDuration = 8, strDisplayName = "0800-1600" },
                new Shift { intId = 10, strBeginTime = "0900", strEndTime = "1700", intDuration = 8, strDisplayName = "0900-1700" },
                new Shift { intId = 11, strBeginTime = "1000", strEndTime = "1800", intDuration = 8, strDisplayName = "1000-1800" },
                new Shift { intId = 12, strBeginTime = "1100", strEndTime = "1900", intDuration = 8, strDisplayName = "1100-1900" },
                new Shift { intId = 13, strBeginTime = "1200", strEndTime = "2000", intDuration = 8, strDisplayName = "1200-2000" },
                new Shift { intId = 14, strBeginTime = "1300", strEndTime = "2100", intDuration = 8, strDisplayName = "1300-2100" },
                new Shift { intId = 15, strBeginTime = "1400", strEndTime = "2200", intDuration = 8, strDisplayName = "1400-2200" },
                new Shift { intId = 16, strBeginTime = "1500", strEndTime = "2300", intDuration = 8, strDisplayName = "1500-2300" },
                new Shift { intId = 17, strBeginTime = "1600", strEndTime = "0000", intDuration = 8, strDisplayName = "1600-0000" },
                new Shift { intId = 18, strBeginTime = "1700", strEndTime = "0100", intDuration = 8, strDisplayName = "1700-0100" },
                new Shift { intId = 19, strBeginTime = "1800", strEndTime = "0200", intDuration = 8, strDisplayName = "1800-0200" },
                new Shift { intId = 20, strBeginTime = "1900", strEndTime = "0300", intDuration = 8, strDisplayName = "1900-0300" },
                new Shift { intId = 21, strBeginTime = "2000", strEndTime = "0400", intDuration = 8, strDisplayName = "2000-0400" },
                new Shift { intId = 22, strBeginTime = "2100", strEndTime = "0500", intDuration = 8, strDisplayName = "2100-0500" },
                new Shift { intId = 23, strBeginTime = "2200", strEndTime = "0600", intDuration = 8, strDisplayName = "2200-0600" },
                new Shift { intId = 24, strBeginTime = "2300", strEndTime = "0700", intDuration = 8, strDisplayName = "2300-0700" },
                new Shift { intId = 25, strBeginTime = "0000", strEndTime = "0900", intDuration = 9, strDisplayName = "0000-0900" },
                new Shift { intId = 26, strBeginTime = "0100", strEndTime = "1000", intDuration = 9, strDisplayName = "0100-0000" },
                new Shift { intId = 27, strBeginTime = "0200", strEndTime = "1100", intDuration = 9, strDisplayName = "0200-1100" },
                new Shift { intId = 28, strBeginTime = "0300", strEndTime = "1200", intDuration = 9, strDisplayName = "0300-1200" },
                new Shift { intId = 29, strBeginTime = "0400", strEndTime = "1300", intDuration = 9, strDisplayName = "0400-1300" },
                new Shift { intId = 30, strBeginTime = "0500", strEndTime = "1400", intDuration = 9, strDisplayName = "0500-1400" },
                new Shift { intId = 31, strBeginTime = "0600", strEndTime = "1500", intDuration = 9, strDisplayName = "0600-1500" },
                new Shift { intId = 32, strBeginTime = "0700", strEndTime = "1600", intDuration = 9, strDisplayName = "0700-1600" },
                new Shift { intId = 33, strBeginTime = "0800", strEndTime = "1700", intDuration = 9, strDisplayName = "0800-1700" },
                new Shift { intId = 34, strBeginTime = "0900", strEndTime = "1800", intDuration = 9, strDisplayName = "0900-1800" },
                new Shift { intId = 35, strBeginTime = "1000", strEndTime = "1900", intDuration = 9, strDisplayName = "1000-1900" },
                new Shift { intId = 36, strBeginTime = "1100", strEndTime = "2000", intDuration = 9, strDisplayName = "1100-2000" },
                new Shift { intId = 37, strBeginTime = "1200", strEndTime = "2100", intDuration = 9, strDisplayName = "1200-2100" },
                new Shift { intId = 38, strBeginTime = "1300", strEndTime = "2200", intDuration = 9, strDisplayName = "1300-2200" },
                new Shift { intId = 39, strBeginTime = "1400", strEndTime = "2300", intDuration = 9, strDisplayName = "1400-2300" },
                new Shift { intId = 40, strBeginTime = "1500", strEndTime = "0000", intDuration = 9, strDisplayName = "1500-0000" },
                new Shift { intId = 41, strBeginTime = "1600", strEndTime = "0100", intDuration = 9, strDisplayName = "1600-0100" },
                new Shift { intId = 42, strBeginTime = "1700", strEndTime = "0200", intDuration = 9, strDisplayName = "1700-0200" },
                new Shift { intId = 43, strBeginTime = "1800", strEndTime = "0300", intDuration = 9, strDisplayName = "1800-0300" },
                new Shift { intId = 44, strBeginTime = "1900", strEndTime = "0400", intDuration = 9, strDisplayName = "1900-0400" },
                new Shift { intId = 45, strBeginTime = "2000", strEndTime = "0500", intDuration = 9, strDisplayName = "2000-0500" },
                new Shift { intId = 46, strBeginTime = "2100", strEndTime = "0600", intDuration = 9, strDisplayName = "2100-0600" },
                new Shift { intId = 47, strBeginTime = "2200", strEndTime = "0700", intDuration = 9, strDisplayName = "2200-0700" },
                new Shift { intId = 48, strBeginTime = "2300", strEndTime = "0800", intDuration = 9, strDisplayName = "2300-0800" },
                new Shift { intId = 49, strBeginTime = "0000", strEndTime = "1000", intDuration = 10, strDisplayName = "0000-1000" },
                new Shift { intId = 50, strBeginTime = "0100", strEndTime = "1100", intDuration = 10, strDisplayName = "0100-1100" },
                new Shift { intId = 51, strBeginTime = "0200", strEndTime = "1200", intDuration = 10, strDisplayName = "0200-1200" },
                new Shift { intId = 52, strBeginTime = "0300", strEndTime = "1300", intDuration = 10, strDisplayName = "0300-1300" },
                new Shift { intId = 53, strBeginTime = "0400", strEndTime = "1400", intDuration = 10, strDisplayName = "0400-1400" },
                new Shift { intId = 54, strBeginTime = "0500", strEndTime = "1500", intDuration = 10, strDisplayName = "0500-1500" },
                new Shift { intId = 55, strBeginTime = "0600", strEndTime = "1600", intDuration = 10, strDisplayName = "0600-1600" },
                new Shift { intId = 56, strBeginTime = "0700", strEndTime = "1700", intDuration = 10, strDisplayName = "0700-1700" },
                new Shift { intId = 57, strBeginTime = "0800", strEndTime = "1800", intDuration = 10, strDisplayName = "0800-1800" },
                new Shift { intId = 58, strBeginTime = "0900", strEndTime = "1900", intDuration = 10, strDisplayName = "0900-1900" },
                new Shift { intId = 59, strBeginTime = "1000", strEndTime = "2000", intDuration = 10, strDisplayName = "1000-2000" },
                new Shift { intId = 60, strBeginTime = "1100", strEndTime = "2100", intDuration = 10, strDisplayName = "1100-2100" },
                new Shift { intId = 61, strBeginTime = "1200", strEndTime = "2200", intDuration = 10, strDisplayName = "1200-2200" },
                new Shift { intId = 62, strBeginTime = "1300", strEndTime = "2300", intDuration = 10, strDisplayName = "1300-2300" },
                new Shift { intId = 63, strBeginTime = "1400", strEndTime = "0000", intDuration = 10, strDisplayName = "1400-0000" },
                new Shift { intId = 64, strBeginTime = "1500", strEndTime = "0100", intDuration = 10, strDisplayName = "1500-0100" },
                new Shift { intId = 65, strBeginTime = "1600", strEndTime = "0200", intDuration = 10, strDisplayName = "1600-0200" },
                new Shift { intId = 66, strBeginTime = "1700", strEndTime = "0300", intDuration = 10, strDisplayName = "1700-0300" },
                new Shift { intId = 67, strBeginTime = "1800", strEndTime = "0400", intDuration = 10, strDisplayName = "1800-0400" },
                new Shift { intId = 68, strBeginTime = "1900", strEndTime = "0500", intDuration = 10, strDisplayName = "1900-0500" },
                new Shift { intId = 69, strBeginTime = "2000", strEndTime = "0600", intDuration = 10, strDisplayName = "2000-0600" },
                new Shift { intId = 70, strBeginTime = "2100", strEndTime = "0700", intDuration = 10, strDisplayName = "2100-0700" },
                new Shift { intId = 71, strBeginTime = "2200", strEndTime = "0800", intDuration = 10, strDisplayName = "2200-0800" },
                new Shift { intId = 72, strBeginTime = "2300", strEndTime = "0900", intDuration = 10, strDisplayName = "2300-0900" },
                new Shift { intId = 99, intDuration = 0, strDisplayName = "Watch-Off" }
            };
        }

        public static List<Models.Rank> ListRank()
        {
            return new List<Rank>
            {
                new Rank {id = 1, code = "Q2", title = "Officer"},
                new Rank {id = 2, code = "Q3", title = "Officer"},
                new Rank {id = 3, code = "Q4", title = "Officer"},
                new Rank {id = 4, code = "Q35", title = "Inspector"},
                new Rank {id = 5, code = "Q36", title = "Inspector"},
                new Rank {id = 6, code = "Q50", title = "Sergeant"},
                new Rank {id = 7, code = "Q51", title = "Sergeant"},
                new Rank {id = 8, code = "Q52", title = "Sergeant"},
                new Rank {id = 9, code = "Q60", title = "Lieutenant"},
                new Rank {id = 10, code = "Q61", title = "Lieutenant"},
                new Rank {id = 11, code = "Q62", title = "Lieutenant"},
                new Rank {id = 12, code = "Q80", title = "Captain"},
                new Rank {id = 13, code = "Q81", title = "Captain"},
                new Rank {id = 14, code = "Q82", title = "Captain"},
                new Rank {id = 15, code = "Q83", title = "Captain"},
                new Rank {id = 16, code = "0488", title = "Commander"},
                new Rank {id = 17, code = "0489", title = "Commander"},
                new Rank {id = 18, code = "0490", title = "Commander"},
                new Rank {id = 19, code = "0400", title = "Deputy Chief"},
                new Rank {id = 20, code = "0401", title = "Deputy Chief"},
                new Rank {id = 21, code = "0402", title = "Deputy Chief"},
                new Rank {id = 22, code = "0395", title = "Assistant Chief"},
                new Rank {id = 23, code = "0390", title = "Chief"},
            };
        }

        public static List<Models.Assignment> ListAssignment()
        {
            return new List<Assignment>
            {
                new Assignment {id = 1, name = "Other", displayname = "All Others"},
                new Assignment {id = 2, name = "Central Station", displayname = "Co A"},
                new Assignment {id = 3, name = "Central Station - SIT", displayname = "Co A - SIT"},
                new Assignment {id = 4, name = "Southern Station", displayname = "Co B"},
                new Assignment {id = 5, name = "Southern Station - SIT", displayname = "Co B - SIT"},
                new Assignment {id = 6, name = "Bayview Station", displayname = "Co C"},
                new Assignment {id = 7, name = "Bayview Station - SIT", displayname = "Co C - SIT"},
                new Assignment {id = 8, name = "Mission Station", displayname = "Co D"},
                new Assignment {id = 9, name = "Mission Station - SIT", displayname = "Co D - SIT"},
                new Assignment {id = 10, name = "Northern Station", displayname = "Co E"},
                new Assignment {id = 11, name = "Northern Station - SIT", displayname = "Co E - SIT"},
                new Assignment {id = 12, name = "Park Station", displayname = "Co F"},
                new Assignment {id = 13, name = "Park Station - SIT", displayname = "Co F - SIT"},
                new Assignment {id = 14, name = "Richmond Station", displayname = "Co G"},
                new Assignment {id = 15, name = "Richmond Station - SIT", displayname = "Co G - SIT"},
                new Assignment {id = 16, name = "Ingleside Station", displayname = "Co H"},
                new Assignment {id = 17, name = "Ingleside Station - SIT", displayname = "Co H - SIT"},
                new Assignment {id = 18, name = "Taraval Station", displayname = "Co I"},
                new Assignment {id = 19, name = "Taraval Station - SIT", displayname = "Co I - SIT"},
                new Assignment {id = 10, name = "Tenderloin Station", displayname = "Co J"},
                new Assignment {id = 21, name = "Tenderloin Station - SIT", displayname = "Co J - SIT"},
                new Assignment {id = 22, name = "Traffic Company", displayname = "Co K"},
                new Assignment {id = 23, name = "Crime Scene Investigations", displayname = "CSI"},
                new Assignment {id = 24, name = "Department Operations Center", displayname = "DOC"},
                new Assignment {id = 25, name = "Equal Employment Opportunity", displayname = "EEO"},
                new Assignment {id = 26, name = "Facilities Management", displayname = "Facilities"},
                new Assignment {id = 27, name = "Field Operations Bureau", displayname = "FOB"},
                new Assignment {id = 28, name = "Fleet Management", displayname = "Fleet"},
                new Assignment {id = 29, name = "Fugitive Recovery Enforcement Team", displayname = "FRET"},
                new Assignment {id = 30, name = "Gang Task Force", displayname = "GTF"},
                new Assignment {id = 31, name = "Graffiti Abatement", displayname = "Graffiti Abatement"},
                new Assignment {id = 32, name = "Hit & Run", displayname = "Hit & Run"},
                new Assignment {id = 33, name = "Homeland Security Unit", displayname = "HSU"},
                new Assignment {id = 34, name = "Homicide", displayname = "Homidice"},
                new Assignment {id = 35, name = "Housing Unit", displayname = "Housing"},
                new Assignment {id = 36, name = "Municipal Transport Agency", displayname = "MTA"},
                new Assignment {id = 37, name = "Narcotics", displayname = "Narcotics"},
                new Assignment {id = 38, name = "Outside Agency", displayname = "Outside Agency"},
                new Assignment {id = 39, name = "Permits Bureau", displayname = "Permits"},
                new Assignment {id = 40, name = "Property Section", displayname = "Property"},
                new Assignment {id = 41, name = "Risk Management Office", displayname = "Risk Mgmt"},
                new Assignment {id = 42, name = "Special Victims Unit", displayname = "SVU"},
                new Assignment {id = 43, name = "Special Investigations", displayname = "SID"},
                new Assignment {id = 44, name = "Violence Reduction Team", displayname = "VRT"},
                new Assignment {id = 45, name = "Administration Bureau", displayname = "Admin"},
                new Assignment {id = 46, name = "Airport Bureau", displayname = "Airport"},
                new Assignment {id = 47, name = "Alcoholic Beverage Control Liaison", displayname = "ABC"},
                new Assignment {id = 48, name = "Arson Unit", displayname = "Arson"},
            };
        }
    }
}