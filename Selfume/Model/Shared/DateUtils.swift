
import UIKit

let date_Format_hh_a   = "hh:mm a"
let date_Format_dd_MMM = "dd MMM"
let date_Format_yyyy_MM_dd = "yyyy-MM-dd"
let date_Format_dd_MM_yyyy = "dd-MM-yyyy"
let date_Format_dd_MMM_yyyy = "dd MMM yyyy"
let date_Format_Hour_Z = "HH:mm:ss.SSSZ"
let date_Format_HH_mm_ss = "HH:mm:ss"



class DateUtils: NSObject {
    
    //MARK : This we need to send in GMT timezone because server side GMT
    //MARK : Dont need to create anymore method
    class func convertDateToGMTServer(date:Date) -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        //dateFormatterPrint.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterPrint.timeZone = .current
//        dateFormatterPrint.date
        return dateFormatterPrint.string(from: date)
    }
   
    class func convertDateFromString(date_string:String , formatter_string : String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = formatter_string
        return formatter.date(from: date_string)
    }
    
    class func convertDate(date:Date , formatter_string : String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = formatter_string
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter.string(from: date)
    }
    
    class func convertDateForLocalDisplay(date:Date , formatter_string : String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = formatter_string
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
    
    class func getMinuteBetweenTwoDate(date1 : Date , date2 : Date)-> Int{
        let cal = Calendar.current
        let d1 = date2
        let d2 = date1
        let components = cal.dateComponents([.minute], from: d2, to: d1)
        let diff = components.minute!
        return diff
    }
    
    //MARK:- I'm doing this because just for the display purpose in history for student module :- Booking date 
    class func convertStringToStringFormat(dateString:String) -> String {
        let myDateString = dateString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let myDate = dateFormatter.date(from: myDateString)!
        dateFormatter.dateFormat = "dd MMM yyyy"
        let somedateString = dateFormatter.string(from: myDate)
        return somedateString
    }
    
}

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    func isEqualTo(_ date: Date) -> Bool {
        return self == date
    }
    
    func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
    
    func isSmallerThan(_ date: Date) -> Bool {
        return self < date
    }
}
