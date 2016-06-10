using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Windows.Forms;

namespace DispatchData
{
    public class Helper
    {
        //these are kluges because of my poor understanding of vb's Program.Settings in C# 
        public static string[] StationArray = {"Station2", "Station3"};
        public static int NumberOfStations = 3;
        public static string LogFileLocation = @"./";
        public static string LogFile = @"Log.txt";
        public static string ThisStation = "StationX";
        public static bool IsLoggingEnabled;

        public static StringBuilder StringSoFar = new StringBuilder();

        public static bool AreYouSure(string title)
        {
            var result = MessageBox.Show("Are you sure?",
                title,
                MessageBoxButtons.OKCancel,
                MessageBoxIcon.Question);

            return (result == DialogResult.OK) ? true : false;
        }

        public static void TurnLoggingOff()
        {
            IsLoggingEnabled = false;
        }

        public static string GetCustomerName(string custID)
        {
            //test with "NEWEL"

            var first = customer.Find(x => x.CustomerID == custID).FirstOrDefault() ??
                        new customer {CustomerID = custID, CustomerName = "NOT SET"};
            return first.CustomerName;
        }

        public static string GetDefaultRouteID(string custID)
        {
            var first = customer.Find(x => x.CustomerID == custID).FirstOrDefault() ??
                        new customer {CustomerID = custID, DefaultRouteID = "XX"};
            return first.DefaultRouteID;
        }

        public static string GetRoute2RouteName(string routeID)
        {
            var first = ROUTE2.Find(x => x.RouteID == routeID).FirstOrDefault() ??
                        new ROUTE2 {RouteID = routeID, RouteName = "NOT SET"};
            return first.RouteName;
        }

        public static string GetRoute2DefaultDriverID(string routeID)
        {
            var first = ROUTE2.Find(x => x.RouteID == routeID).FirstOrDefault() ??
                        new ROUTE2 {RouteID = routeID, DefaultDriverID = "XX"};

            return first.DefaultDriverID;
        }

        public static CurrentDayPickup GetOneCDP(int? cdpkey)
        {
            // return  (CurrentDayPickup.All().Where(x => (x.CurrentDayPickupID == key))).FirstOrDefault();
            var name = "GETOneCDP(int? cdpkey";
            if (cdpkey.HasValue)
            {
                return (CurrentDayPickup.Find(x => x.CurrentDayPickupID == cdpkey.Value).First());
            }
            else
            {
                CurrentDayPickup cdp = CurrentDayPickup.Find(x => x.CurrentDayPickupID == cdpkey.Value).DefaultIfEmpty(
                    new CurrentDayPickup
                    {
                        CDPCustomerID = "QQQQQ",
                        CDPCustomerName = name,
                        CDPDispatched = false,
                        CDPChecked = false,
                        CDPDeleted = false,
                        CDPSent = false,
                        CDPSendConfirmed = false
                    }).First();
                return cdp;
            }
        }

        public static CurrentDayRoute GetOneCDR(int? cdrkey)
        {
            // original return  (CurrentDayRoute.All().Where(x => (x.CurrentDayRouteID == cdrkey))).FirstOrDefault();
            var name = "GetOneCDR(int? cdrkey)";
            if (cdrkey.HasValue)
            {
                return (CurrentDayRoute.Find(x => x.CurrentDayRouteID == cdrkey).First());
            }
            else
            {
                CurrentDayRoute cdr = CurrentDayRoute.Find(x => x.CurrentDayRouteID == cdrkey.Value).DefaultIfEmpty(
                    new CurrentDayRoute
                    {
                        CDRRouteID = "xx",
                        CDRRouteName = name,
                        DUser = "not allowed",
                        Terminal = "not allowed"
                    }).First();
                return cdr;
            }
        }

        public static Boolean CustomerExists(int? custkey)
        {
            return  customer.Exists(x => x.CustomerTableID == custkey);
        }

        public static customer GetOneCustomer(int? custkey)
        {
            var name = "GetOneCustomer(int? key)";
            if (custkey.HasValue)
            {
                return (customer.Find(x => x.CustomerTableID == custkey).First());
            } //return (customer.All().Where(x => (x.CustomerTableID == custkey))).FirstOrDefault();
            else
            {
                customer c = customer.Find(x => x.CustomerTableID == custkey.Value).DefaultIfEmpty(
                    new customer
                    {
                        CustomerID = "ZZZZZ",
                        CustomerName = name,
                        DUser = "not allowed",
                        Terminal = "not allowed"
                    }).First();
                return c;
            }
        }

        public static DRIVER GetOneDriver(int? key)
        {
            return (DRIVER.All().Where(x => (x.DriverTableID == key))).FirstOrDefault();
        }

        public static Pickup GetOnePickup(int? key)
        {
            return (Pickup.All().Where(x => (x.PickupTableID == key))).FirstOrDefault();
        }

        public static bool HasCDP(string custID)
        {
            return (CurrentDayPickup.Exists(x => (!x.CDPDeleted && x.CDPCustomerID == custID)));
        }

        public static string GetCustNameFromCustID(string custid)
        {
            // original...
            // var ccx= (customer.All().Where(x => (x.CustomerID == custid))).FirstOrDefault();
            // Debug.Assert(ccx != null, "ccx != null");
            // return ccx.CustomerName;

            var name = "Missing Customer Name in GetCustNameFromCustID(string custid)";

            if (!String.IsNullOrEmpty(custid))
            {
                return (customer.Find(x => x.CustomerID == custid).First().CustomerName);
            }
            else
            {
                customer c = customer.Find(x => x.CustomerID == custid).DefaultIfEmpty(
                    new customer
                    {
                        CustomerID = "ZZZZZ",
                        CustomerName = name,
                        DUser = "not allowed",
                        Terminal = "not allowed"
                    }).First();
                return c.CustomerName;
            }
        }


        public static customer GetCustomerFromCustID(string custID)
        {
            customer cust;
            if (customer.Exists(x => x.CustomerID == custID))
            {
                cust = customer.Find(x => x.CustomerID == custID).Single();
            }
            else
            {
                cust = null;
            }
            return cust;
        }

        public static bool CustomerContains(string custID)
        {
            return customer.Exists(x => x.CustomerID == custID);
        }

        public static List<DRIVER> GetDriverList()
        {
            return (from d in DRIVER.All()
                orderby d.LastName
                select d).ToList();
        }

        public static DRIVER GetDriverByDriverID(string driverid)
        {
            return (from d in DRIVER.All()
                where d.DriverID == driverid
                select d).FirstOrDefault();
        }

        public static List<ROUTE2> GetRoute2List()
        {
            return (from r in ROUTE2.All()
                orderby r.RouteID
                select r).ToList();
        }

        public static int GetRoute2Count()
        {
            return ROUTE2.All().Count();
        }

        public static List<CurrentDayPickup> ListPickupsForThisCustomer(string custID)
        {
            return (CurrentDayPickup.All()
                .Where(pp => (pp.CDPCustomerID == custID &&
                 ! pp.CDPDeleted )))
                .ToList();
        } 
        public static List<CurrentDayPickup> GetCDPList()
        {
            return (from p in CurrentDayPickup.All()
                select p).ToList();
        }

        public static string GetPickupComment(string text)
        {
            var retval = "";
            var p = (from pp in Pickup.All()
                where (pp.CustomerID == text)
                select pp).FirstOrDefault();
            if (p != null)
            {
                retval = p.Comment;
            }

            return retval;
        }

        public static List<customer> GetSortedCustomers()
        {
            List<customer> retval;
            retval = (from cus in customer.All()
                orderby cus.CustomerID
                select cus).ToList();
            return retval;
        }

        public static List<customer> GetCustomersSortedByName()
        {
            List<customer> retval;
            retval = (from cus in customer.All()
                orderby cus.CustomerName
                select cus).ToList();
            return retval;
        }

        public static bool GetCustomerFromCustomerName(string proposedname)
        {
            return customer.Exists(x => x.CustomerName == proposedname);
        }

        public static int GetUndeletedPickupCount()
        {
            return CurrentDayPickup.All().Where(x => x.CDPDeleted == false).Count();
        }

        public static List<CurrentDayPickup> GetPickupsForThisRoute(string tag)
        {
            var p = (from pp in CurrentDayPickup.All()
                where (pp.CDPDefaultRouteID == tag && pp.CDPDeleted == false)
                select pp);
            return p.ToList();
        }

        public static CurrentDayRoute GetCDRWithRouteID(string tag)
        {
            return (from r in CurrentDayRoute.All()
                where (r.CDRRouteID == tag)
                select r).FirstOrDefault();
        }

        public static List<Epickup> GetPickupsToEdit()
        {
            var plist = Pickup.Find(x => x.Comment == "DP" || x.PickupDate >= DateTime.Today
                                         || x.Monday == true
                                         || x.Tuesday == true
                                         || x.Wednesday == true
                                         || x.Thursday == true
                                         || x.Friday == true);


            return (from p in plist
                from customer c in customer.Find(c => c.CustomerID == p.CustomerID)
                select new Epickup
                {
                    PickupTableID=p.PickupTableID ,
                    CustomerID = p.CustomerID,
                    Route = c.DefaultRouteID,
                    CustomerName = c.CustomerName,
                    City = c.City,
                    Message = p.Comment,
                    Monday = p.Monday,
                    Tuesday = p.Tuesday,
                    Wednesday = p.Wednesday,
                    Thursday = p.Thursday,
                    Friday = p.Friday,
                    Infostring = c.InfoString,
                    PuDate = p.PickupDate
                }).ToList();
        }

        public static Posting GetOtherStationPosting(string ThisStation)
        {
            // p.Originator realy means 'posting message DESTINATION' 
            var qq = Posting.All().Where(p => p.Originator == ThisStation).Select(p => new Posting());

            //IEnumerable<Posting> q = Posting.All();
            //// p.Originator realy means 'posting message DESTINATION' 
            //q.Where( p => p.Originator == ThisStation &&
            //                  p.NumberofPendingUpdates == 0);
            //q.Select( p => new Posting());
            if (qq.Count() > 0)
            {
                return qq.First();
            }
            else
            {
                return new Posting
                {
                    DataType = "CurrentDayPickup",
                    DefaultRouteId = "999",
                    key = null,
                    NumberofPendingUpdates = 99,
                    isDragnDrop = false,
                    Originator = "foo"
                };
            }
        }

        public static Posting Get_next_posting_to_process(string ThisStation)
        {
            IList<Posting> plist;
            plist = Posting.Find(x => x.Originator == ThisStation);
            return plist.Count > 0 ? plist.First() : null;
        }

        public static void Clear_out_my_postings(string sta)
        {
            DispatchData.Posting.Delete(x => x.Originator == sta);
        }

        // call this to avoid SQL exception
        // see:  http://stackoverflow.com/questions/2776673/how-do-i-truncate-a-net-string
        // rgk 4/14/2014        
        // DataType is varchar(50)
        // length is 47 because elipsis will be added 
        // e.g. =>p.DataType = truncateString(p.DataType, 47);
        public static string TruncateString(string originalString, int length)
        {
            if (string.IsNullOrEmpty(originalString))
            {
                return originalString;
            }
            if (originalString.Length > length)
            {
                return originalString.Substring(0, length) + "...";
            }
            else
            {
                return originalString;
            }
        }

        public static void MakePostings(Posting p)
        {
            // if (NumberOfStations==0 || StationArray.Count()==0) return false; 
            // NumberOfStations is saved as Posting.NumberofPendingUpdates
            // Posting Destination => the Originator column

            // if NumberOfStations = 1  make zero records
            // if NumberOfStations = 2  make one  record
            // if NumberOfStations = 3  make two  records
            var myDragnDrop = p.DataType.Contains("CurrentDayPickup") && p.isDragnDrop == true;

            p.DataType = TruncateString(p.DataType, 47);

            switch (NumberOfStations - 1)
            {
                case 0:
                    break;
                case 1:
                    p.Originator = StationArray[0];
                    p.isDragnDrop = myDragnDrop;
                    p.Save();
                    break;
                case 2:
                    var number1 = new Posting()
                    {
                        DataType = p.DataType,
                        key = p.key,
                        NumberofPendingUpdates = p.NumberofPendingUpdates,
                        Originator = StationArray[0],
                        DefaultRouteId = p.DefaultRouteId,
                        PreviousRouteID = p.PreviousRouteID,
                        isDragnDrop = myDragnDrop
                    };
                    number1.Save();
                    var number2 = new Posting()
                    {
                        DataType = p.DataType,
                        key = p.key,
                        NumberofPendingUpdates = p.NumberofPendingUpdates,
                        Originator = StationArray[1],
                        DefaultRouteId = p.DefaultRouteId,
                        PreviousRouteID = p.PreviousRouteID,
                        isDragnDrop = myDragnDrop
                    };
                    number2.Save();
                    break;
                default:
                    break;
            }
        }

        public static bool IsValidDriver(string ThisDriver)
        {
            return DRIVER.Exists(x => x.DriverID == ThisDriver);
        }

        public static bool IsCustNameAndCityInUse(string proposedname, string proposedcity)
        {
            return customer.Exists(x => x.City == proposedcity && x.CustomerName == proposedname);
        }

        public static List<customer> GetPreviewList(string toString)
        {
            var clist = customer.Find(x => x.CustomerID.StartsWith(toString));
            return (from c in clist
                orderby c.CustomerID
                select new customer
                {
                    CustomerID = c.CustomerID,
                    InfoString = String.Format("{0}: {1}@{2}",
                        c.CustomerID,
                        c.CustomerName,
                        c.City)
                }).ToList();
        }

        public static bool CompareNewCDP(CurrentDayPickup currentDayPickup, Posting posting)
        {
            var pu = Helper.GetOneCDP(currentDayPickup.CurrentDayPickupID);
            return pu.Equals(currentDayPickup);
        }

        public static int GetCDRCount()
        {
            return CurrentDayRoute.All().Count();
        }

        public static string GetCity(string customerId)
        {
            var first = customer.Find(x => x.CustomerID == customerId).FirstOrDefault() ??
                        new customer {CustomerID = customerId, City = "XX"};
            return first.City;
        }

        public static CurrentDayRoute GetRouteWithKey(int? key)
        {
            var first = CurrentDayRoute.Find(x => x.CurrentDayRouteID == key).FirstOrDefault() ??
                        new CurrentDayRoute {CurrentDayRouteID = 500, CDRDriverLastName = "invalid route"};
            return first;
        }

        public static ROUTE2 GetRoute2(string item)
        {
            return ROUTE2.Find(x => x.RouteID == item).FirstOrDefault() ??
                   new ROUTE2 {RouteID = item, RouteName = "NOT FOUND"};
        }
    }
}

