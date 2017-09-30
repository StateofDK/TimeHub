using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TimeHub2.Models
{
    public class RequestPackage
    {
        public List<OvertimeRequest> OvertimeRequests = new List<OvertimeRequest>();
        public List<CourtRequest> CourtRequests = new List<CourtRequest>();
        public List<TrainingRequest> TrainingRequests = new List<TrainingRequest>();
        public List<EqualPayRequest> EqualPayRequests = new List<EqualPayRequest>();
        public List<TimeOffRequest> TimeOffRequests = new List<TimeOffRequest>();
    }

    public class Transaction
    {
        public int Requester { get; set; }
        public string TransactionType { get; set; }
    }

    public class Request
    {
        public Transaction transaction { get; set; }

        public int RequestNumber { get; set; }
        public int CreditedUser { get; set; }
        public string FirstName { get; set; }
        public string MiddleInitial { get; set; }
        public string LastName { get; set; }
        public int CreditedStar { get; set; }
        public int CreditedRank { get; set; }
        public int Assignment { get; set; }
        public string Detail { get; set; }
        public DateTime BeginningDate { get; set; }
        public DateTime EndingDate { get; set; }
        public int TotalTime { get; set; }
        public string SubmittedBy { get; set; }
        public int SubmittedRank { get; set; }
        public int SubmittedStar { get; set; }
        public DateTime SubmittedDate { get; set; }
        public string ApprovedBy { get; set; }
        public int ApprovedRank { get; set; }
        public int ApprovedStar { get; set; }
        public DateTime ApprovedDate { get; set; }
        public int StatusId { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string RequestType { get; set; }
    }

    public class OvertimeRequest : Request
    {
        public int CaseNumber { get; set; }
        public int CertifiedBy { get; set; }
        public int ShiftWorked { get; set; }
        public int InputBy { get; set; }
        public string Comment { get; set; }

        public int OvertimeCode { get; set; }
        public int CompType { get; set; }
        public string InLieuHoliday { get; set; }
        public string EventNumber { get; set; }
    }

    public class CourtRequest : Request
    {
        public int CaseNumber { get; set; }
        public int CertifiedBy { get; set; }
        public int ShiftWorked { get; set; }
        public int InputBy { get; set; }
        public string Comment { get; set; }

        public string CourtSession { get; set; }
        public string AppearanceType { get; set; }
        public string Department { get; set; }
        public string CourtType { get; set; }
        public string Defendant { get; set; }
        public string Charges { get; set; }
        public string AttorneyApproved { get; set; }
        public DateTime AttorneyTimestamp { get; set; }
        public string CourtNumber { get; set; }

    }

    public class TrainingRequest : Request
    {
        public int CaseNumber { get; set; }
        public int CertifiedBy { get; set; }
        public int ShiftWorked { get; set; }
        public string InLieuHoliday { get; set; }
        public int TrainingCode { get; set; }
        public int CompType { get; set; }
    }

    public class EqualPayRequest : Request
    {
        public string InPlaceName { get; set; }
        public string InPlaceRank { get; set; }
    }

    public class TimeOffRequest : Request
    {
        public int TimeUsed { get; set; }
    }
}