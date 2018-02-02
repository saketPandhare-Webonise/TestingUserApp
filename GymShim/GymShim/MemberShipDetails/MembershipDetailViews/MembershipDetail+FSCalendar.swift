//
//  MembershipDetail+FSCalendar.swift
//  GymShim

import UIKit
import FSCalendar

extension MembershipDetailCell {
    
    /// This func is used to set up the calendar that is displayed in membership details screen
    func calendarSetUp() {
        viewCalendar.delegate = self
        viewCalendar.dataSource = self
        viewCalendar.scope = .Month
        viewCalendar.clipsToBounds = true
        viewCalendar.scrollDirection = .Horizontal
        viewCalendar.appearance.adjustsFontSizeToFitContentSize = false
        viewCalendar.appearance.headerTitleColor = UIColor(hexValue: ColorHexValue.RED_COLOR)
        viewCalendar.appearance.headerTitleFont = UIFont(name:FontType.HELVITICA_MEDIUM, size:CGFloat(FontSize.FOURTEEN))
        viewCalendar.appearance.weekdayTextColor = UIColor(hexValue: ColorHexValue.CALENDAR_DAY_COLOR)
        viewCalendar.appearance.weekdayFont = UIFont(name:FontType.HELVITICA_MEDIUM, size:CGFloat(FontSize.TWELVE))
        viewCalendar.appearance.titleFont = UIFont(name:FontType.HELVITICA_MEDIUM, size:CGFloat(FontSize.THIRTEEN))
        viewCalendar.appearance.caseOptions = .WeekdayUsesSingleUpperCase
        viewCalendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        viewCalendar.placeholderType = .None
        viewCalendar.allowsSelection = false
        viewCalendar.backgroundColor = UIColor.clearColor()
        LoadingActivityIndicatorView.hide()
    }
    
    /// Reload calendar when result from WS is received
    func reloadCalendarView() {
        viewCalendar.reloadData()
    }
    
    /// This method is called when you click on butoon to swipe next or previous month
    func calendarSwipeOnButtonClick(monthValue:Int) {
        calendarUnit = NSCalendarUnit.Month
        nextPage = gregorian!.dateByAddingUnit(calendarUnit, value: monthValue, toDate: viewCalendar.currentPage, options: NSCalendarOptions.init(rawValue: 0))!
        viewCalendar.setCurrentPage(nextPage, animated: true)
    }
    
    
    //MARK:Calendar Delegate Method
    
    ///delegate method of Calendar for Layout
    
    //TO-DO: This will be Implemeted When Webservice is integrated to change color for Missed/Attended and no Session by user
    
     func calendar(calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorForDate date: NSDate) -> UIColor?{
        if (memberShipDetailViewModel!.previousAttendancePresent){
            viewCalendar.tag =  AttendanceConstant.NOSESSION
             self.calendar(calendar, appearance: appearance, titleDefaultColorForDate: date)
             return UIColor.whiteColor()
        }
        
        for i in 0...(memberShipDetailViewModel!).getcalendarArrayCountFromModel(){
            var calendarDate = NSDate()
            let serverDate =  memberShipDetailViewModel!.getCalendarDateFromServerResponse(i)
            calendarDate = memberShipDetailViewModel!.formatDateForComparision(date)
            
            if (serverDate .isEqualToDate(calendarDate)){
                switch memberShipDetailViewModel!.getStatusForDateFromServer(i){
                    
                   
                ///user Present for the session
                case AttendanceConstant.PRESENT:
                    viewCalendar.tag =  AttendanceConstant.PRESENT
                    memberShipDetailViewModel?.presentDaysSet .insert(date)
                    return getDateBackGroundColorForAttendedSession()
                    
                /// user absent for the session
                case AttendanceConstant.ABSENT:
                    viewCalendar.tag = AttendanceConstant.ABSENT
                    memberShipDetailViewModel?.absentDaySet .insert(date)
                    return getDateBackGroundColorForAbsentSession()
                    
                /// No session for the date
                case AttendanceConstant.NOSESSION:
                    viewCalendar.tag =  AttendanceConstant.NOSESSION
                    return getDateBackGroundColorForNoSession()
                    
                /// future date
                case AttendanceConstant.UPCOMING:
                    viewCalendar.tag =  AttendanceConstant.UPCOMING
                    return getDateBackGroundColorForFuture()
                    
                 /// Today
                case AttendanceConstant.TODAY:
                    viewCalendar.tag =  AttendanceConstant.TODAY
                    return getDateBackGroundColorForFuture()


                default:
                    break
                }
                self.calendar(calendar, appearance: appearance, titleDefaultColorForDate: date)
            }
            else {
                viewCalendar.tag =  AttendanceConstant.NOSESSION
                self.calendar(calendar, appearance: appearance, titleDefaultColorForDate: date)
                 getDateTextColorForAttendedAndMissedSession()
            }
        }
        attendedMissedSessionCountForUser()
        return UIColor.whiteColor()
    }
    
    
    
    /// This delegate method is used to set the text color of date as per the condition
    func calendar(calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorForDate date: NSDate ) -> UIColor?{
        
        
        switch viewCalendar.tag {
        case AttendanceConstant.UPCOMING:
             return getDateTextColorForUpComingDates()
            
        case AttendanceConstant.ABSENT:
            return getDateTextColorForAttendedAndMissedSession()
            
        case AttendanceConstant.PRESENT:
           return getDateTextColorForAttendedAndMissedSession()
            
        case AttendanceConstant.NOSESSION:
           return getDateTextColorForNoSession()
            
        case AttendanceConstant.TODAY:
            return getDateTextColorForUpComingDates()


        default:
            break
        }
        return getDateTextColorForUpComingDates()
    }
    
    
    /// Delegate method for calendar when user changes month
    func calendarCurrentPageDidChange(calendar: FSCalendar) {
        let components = localCalendar.components([.Month, .Day, .Year], fromDate:calendar.currentPage )
        memberShipDetailViewModel?.currentMonth(components.month)
        memberShipDetailViewModel?.currentYear(components.year)
        memberShipDetailViewModel!.previousAttendancePresent = true
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(callWebserviceToGetSpecificMonthData), userInfo: nil, repeats: false)
        
    }
    
    func calendar(calendar: FSCalendar, appearance: FSCalendarAppearance, titleOffsetForDate date: NSDate) -> CGPoint {
        return CGPoint(x: titleOffset, y: titleOffSetY)
    }
    
    func callWebserviceToGetSpecificMonthData() {
        memberShipDetailViewModel!.previousAttendancePresent = false
        self.calendarSwipeDelegate?.relaodTableData()
    }
    
    /// func set Session count [Attended/Missed] for user per month
    func attendedMissedSessionCountForUser() {
        labelMissed.text =  StringUtilsConstant.MISSED  +
           memberShipDetailViewModel!.formatMissedAndAttendedSessionCount(memberShipDetailViewModel!.absentDaySet.count)
        labelAttended.text =  StringUtilsConstant.ATTENDED +  memberShipDetailViewModel!.formatMissedAndAttendedSessionCount(memberShipDetailViewModel!.presentDaysSet.count)
  }
}
