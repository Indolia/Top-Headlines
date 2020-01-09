////
////  Extention+Date.swift
////  Cuisine
////
////  Created by Rohit Kumar on 21/05/17.
////  Copyright © 2017 IVP. All rights reserved.
////
//
//import Foundation
//
//struct DateFormat {
//    static let dd_MMM_yyyy = "dd MMM yyyy"
//    static let yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
//    static let hh_mm_a = "hh:mm a"
//    static let yyyy_MM_dd = "yyyy-MM-dd"
//    static let EEEE_MMMM_yy = "EEEE,MMMM yy"
//    static let EEEE_MMM_dd  = "EEEE, MMM dd"
//    static let EEE_MMM_dd = "EEE, MMM dd" 
//}
//
//extension Date {
//    
//    //MARK: Gernal Method
//    /**
//     Return current Date in UTC
//     */
//    static func currentDate() ->Date {
//        return Date()
//    }
//    
//    static func currentLocalDate() ->Date {
//        let date = Date.currentDate(for:.current , with: DateFormat.yyyy_MM_dd_HH_mm_ss)
//        return date
//    }
//    
//    /**
//     Return current TimeIntervalSince1970
//     */
//    static func currentTimestamp() -> Double {
//        let timestamp = Date().timeIntervalSince1970
//        return timestamp
//    }
//    
//    /**
//     Return current date with current timeZone with given format
//     */
//    static func currentDate(with format:String) ->String{
//        let currentDate = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: currentDate)
//    }
//    
//    /**
//     * @discussion Return date with given time zone and format
//     * @param time zone
//     * @param format
//     * @return date in sting
//     */
//    static func currentDateInStr(for timeZone:TimeZone, with format:String) ->String {
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = timeZone
//        dateFormatter.dateFormat = format
//        let dateStr = dateFormatter.string(from: date)
//        return dateStr
//    }
//    
//    static func currentDate(for timeZone:TimeZone, with format:String) -> Date {
//        let dateStr = Date.currentDateInStr(for: timeZone, with: format)
//        let date = Date.getDate(fromString: dateStr, for: timeZone, with: format)
//        return date
//    }
//    
//    /**
//     * @discussion Return date from given date for time zone with format
//     * @param date
//     * @param timeZone
//     * @param format
//     * @return date in string
//     */
//    static func getDate(from date:Date ,for timeZone:TimeZone,with format:String) ->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = timeZone
//        dateFormatter.dateFormat = format
//        let dateStr = dateFormatter.string(from: date)
//        return dateStr
//        
//    }
//    
//    /**
//     * @discussion Return date from given date for time zone identifier with format
//     * @param date
//     * @param timeZone identifier
//     * @param format
//     * @return date in string
//     */
//    static func getDate(from date:Date,for identifier:String, with format:String) ->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(identifier: identifier)
//        dateFormatter.dateFormat = format
//        let dateStr = dateFormatter.string(from: date)
//        return dateStr
//        
//    }
//    /**
//     * @discussion Return date from given date for time zone identifier with format
//     * @param date
//     * @param timeZone abbreviation
//     * @param format
//     * @return date in string
//     */
//    static func getDate(from date:Date, abbreviation:String, with format:String) ->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: abbreviation)
//        dateFormatter.dateFormat = format
//        let dateStr = dateFormatter.string(from: date)
//        return dateStr
//        
//    }
//    
//    /**
//     * @discussion Return date from date string for given time zone with format
//     * @param date in string
//     * @param time zone
//     * @param formate
//     * @return date
//     */
//    
//    static func getDate(fromString date:String,for timeZone:TimeZone, with format:String) -> Date {
//        let formatter = DateFormatter()
//        formatter.timeZone = timeZone
//        formatter.dateFormat = format
//        let date = formatter.date(from: date)
//        return date!
//    }
//    
//    
//    static func getStringDate(fromString date:String, from currentFromat:String ,to toFormat:String)-> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = currentFromat
//        let date = formatter.date(from: date)
//        formatter.dateFormat = toFormat
//        return formatter.string(from: date!)
//    }
//    
//    /**
//     * @discussion Return date by adding the sec in give date
//     * @param seconds
//     * @return date
//     */
//    
//    func getDate(byAddingSec:TimeInterval) ->Date {
//        return  self.addingTimeInterval(byAddingSec)
//    }
//    
//    /**
//     * @discussion Return date by adding the minutes in give date
//     * @param hours as 1.0 or 1.lc
//     * @return date
//     */
//    
//    func getDate(byAddingMinutes:Int) ->Date {
//        return  self.addingTimeInterval(TimeInterval(byAddingMinutes*60))
//    }
//    /**
//     * @discussion Return date by adding the hours in give date
//     * @param hours as 1.0 or 1.lc
//     * @return date
//     */
//    
//    func getDate(byAddingHours:Int) ->Date {
//        return  self.addingTimeInterval(TimeInterval(byAddingHours*3600))
//    }
//    
//    /**
//     * @discussion Return date by adding sec minutes and hours in give date
//     * @param hours as 1.0 or 1.lc
//     * @return date
//     */
//    
//    func getDate(byAdding sec:TimeInterval ,minutes:Int, hours:Int) ->Date {
//        return  self.addingTimeInterval(TimeInterval(hours*3600))
//    }
//    
//    /**
//     * @discussion Return true/false if date is today date
//     * @param date
//     * @return true/false
//     */
//    
//    func isTodayDate() -> Bool {
//        return Calendar.current.isDateInToday(self)
//    }
//    
//    /**
//     * @discussion Return true/false if date is tomorrow date
//     * @param date
//     * @return true/false
//     */
//    func isTomorrowDate() -> Bool {
//        return Calendar.current.isDateInTomorrow(self)
//    }
//    
//    /**
//     * @discussion Return true/false if date is week date
//     * @param date
//     * @return true/false
//     */
//    func isWeekendDate() -> Bool {
//        return Calendar.current.isDateInWeekend(self)
//    }
//    
//    /**
//     * @discussion Return the day name for date
//     * @return day name
//     */
//    
//    func dayName() -> String {
//        let weekDay = Calendar.current.component(.weekday, from: self)
//        // return 1 to 7
//        let weekDayName = ["","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
//        let someday = weekDayName[weekDay]
//        return someday
//    }
//    
//    /**
//     * @discussion Return the number of days between two dates
//     * @param start date
//     * @param end date
//     * @return number of day
//     */
//    static func numberOfDay(from startDate:Date ,to endDate:Date) -> Int {
//        let calendar = NSCalendar.current
//        // Replace the hour (time) of both dates with 00:00
//        let firstDate = calendar.startOfDay(for: startDate)
//        let secondDate = calendar.startOfDay(for: endDate)
//        let components = calendar.dateComponents([.day], from: firstDate, to: secondDate)
//        return components.day!
//    }
//    
//    
//    
//    //MARK: - Pulse based Method -
//    /**
//     * @discussion Return date in string for next day from the previous date
//     * @param day index
//     * @param format
//     * @return date in String 
//     */
//    static func getDateForDayIndex(index:Int, wtih format:String) -> String{
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        let nextDate = date.addingTimeInterval(TimeInterval(3600*24*index))
//        return dateFormatter.string(from: nextDate)
//    }
//   
//    
//
// 
//
//}
