//
//  MembershipDetailViewModel.swift
//  GymShim

import UIKit
import ObjectMapper
import FSCalendar
import  EZSwiftExtensions

protocol MembershipDetailApiCallDelegate {
    func onSuccess()
    func onFailure(error:String)
}

class MembershipDetailViewModel: NSObject {
    var memberShipDetailModel: MemberShipDetailModel = MemberShipDetailModel()
    var membershipDetailApiCallDelegate: MembershipDetailApiCallDelegate?
    var currentMonth = Int()
    var currentYear = Int()
    var previousAttendancePresent:Bool = false
    var presentDaysSet =  Set<NSDate>()
    var absentDaySet =  Set<NSDate>()
    
    /// Webservice call to get membership details
    ///
    /// - parameter memberShipID: membershipID Of User
    /// - parameter month:Month for which data is requested
    /// - parameter year:Year for which data is requested
    func getMemberShipDetails(memberShipID:String, month:Int, year:Int){
        if (!userLoginToken.isEmpty) {
        let membershipDetailRequest = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.ID:memberShipID,RequestParameters.MONTH:month,RequestParameters.YEAR:year]
        
        WebserviceHandler().callWebService(WebServiceUrls.MEMBERSHIP_DETAILS(memberShipID), methodType: WebServiceType.GET, parameters: membershipDetailRequest, succeess: {
            (response, headerFields) in
            self.initializeAttendedAndMissedSessionCount()
            self.previousAttendancePresent = false
            self.mapResponseToModel(response)
            self.membershipDetailApiCallDelegate?.onSuccess()
            }, failure: { (error) in
                print("Error has \(error)")
                self.membershipDetailApiCallDelegate?.onFailure(error.description)
        })
    }
    }
    
    /// This function will Notify Server that Notification has been read
    ///
    /// - parameter notificationID: notification number
    func notifyServerAboutNotificationViewed(notificationID: Int) {
        WebserviceHandler().notifyServerNotificationViewed(notificationID)
    }
    
    /**
     Maps response to profile model
     
     - parameter response: response from api call which is to be mapped
     */
    func mapResponseToModel(response: AnyObject?) {
        self.memberShipDetailModel = Mapper<MemberShipDetailModel>().map(response)!
    }
    
    ///set current Month from MembershipDetailsVC As well as when we scroll calendar
    func currentMonth(month:Int){
        currentMonth = month
    }
    
    ///set current year from MembershipDetailsVC As well as when we scroll calendar
    func currentYear(year:Int){
        currentYear = year
    }
    
    /// get current Month that is set from MembershipDetailsVC as well as when user swipes the calendar
    func getCurrentMonth()->Int{
        return currentMonth
    }
    
    /// get current year that is set from MembershipDetailsVC as well as when user swipes the calendar
    func getCurrentYear()->Int{
        return currentYear
    }
    
    /// get Count of calendar days array to itterate for checking status and apply color according to it
    func getcalendarArrayCountFromModel()->Int{
        return (memberShipDetailModel.dictionaryMembershipDetail.arrayAttendance.count - 1)
    }
    
    /// this function gets date from the Model that is saved from WS
    func getCalendarDateFromServerResponse(index:Int)->NSDate {
        return formatDateForComparision(NSDate(timeIntervalSince1970:Double(memberShipDetailModel.dictionaryMembershipDetail.arrayAttendance[index].date)))
    }
    
    /// this function formats the date for comparision
    func formatDateForComparision(serverDate:NSDate)->NSDate{
        return (formatDateToCompare(serverDate.toString(format: DateFormatterConstant.CALENDAR_FORMAT)))
    }
    
    /// this function will return status for the date from server
    func getStatusForDateFromServer(index:Int)->Int {
        return memberShipDetailModel.dictionaryMembershipDetail.arrayAttendance[index].status
    }
    
    /// this func will set color for date as per the status
    func setColorForDateTitle(calendar:FSCalendar, color:UIColor){
        calendar.appearance.titleDefaultColor = color
        calendar.appearance.titleTodayColor = color
    }
    
    /// initialize session count when user changes month
    func initializeAttendedAndMissedSessionCount(){
        presentDaysSet = Set<NSDate>()
        absentDaySet = Set<NSDate>()
    }
    
    /// func get count for total missed sessions
    func formatMissedAndAttendedSessionCount(count:Int)->String {
        return  (count < 10) ? (BracketConstant.ZERO + String (count))  : ( String (count))
    }
    
}
