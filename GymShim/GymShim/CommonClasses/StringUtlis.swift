//
//  StringUtlis.swift
//  GymShim

import Foundation
import UIKit

//MARK: String extension
extension String
{
    func trim() -> String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    subscript (index: Int) -> Character {
        return self[self.startIndex.advancedBy(index)]
    }
    
    subscript (index: Int) -> String {
        return String(self[index] as Character)
    }
    
    subscript (range: Range<Int>) -> String {
        let start = startIndex.advancedBy(range.startIndex)
        let end = start.advancedBy(range.endIndex - range.startIndex)
        return self[Range(start ..< end)]
    }
    
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet) == nil
        }
    }
}

/// This function is used to get Base url at run time
///
/// - Returns: baseurl
func getBaseUrl() -> String {
    var dict: NSDictionary?
    if let path = NSBundle.mainBundle().pathForResource(StringUtilsConstant.INFO,
                                                        ofType:StringUtilsConstant.PLIST) {
        dict = NSDictionary(contentsOfFile: path)
    }
    if let BASE_URL = dict![StringUtilsConstant.BASE_URL] {
        return BASE_URL as! String
    } else {
        return StringUtilsConstant.EMPTY_STRING
    }
}

func isValidEmailAddress(enteredEmail:String) -> Bool {
    guard isValidString(enteredEmail) else { return false }
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluateWithObject(enteredEmail.trim())
}

/**
 Sets string with required font size and fontfamily
 
 - parameter stringName: string to be modified
 - parameter fontFamily: font family of string
 - parameter fontSize:   font size of string
 
 - returns: returns customised string
 */
func stringWithFontSizeFontFamily(stringName:String,fontFamily:String,fontSize:CGFloat) -> NSMutableAttributedString {
    let attributesForString = [NSFontAttributeName:UIFont(name:fontFamily,
        size: fontSize)!]
    let attributedString = NSMutableAttributedString(string: stringName,attributes: attributesForString)
    return attributedString
}

/**
 Sets string with required font color
 
 - parameter input:     string to be modified
 - parameter colorCode: colorcode
 
 - returns: returns modified string
 */
func stringWithFontColor(input:NSMutableAttributedString,colorCode:Int) -> NSMutableAttributedString {
    input.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexValue: colorCode), range: NSMakeRange(0,input.length))
    return input
}

/**
 Checks whether mobile number is in valid format or not
 
 - parameter value: mobile number to be tested
 
 - returns: true if mobile number is valid, else returns false
 */
func isValidatePhoneNo(value: String) -> Bool {
    guard isValidString(value) else { return false }
    let PHONE_REGEX = "^[789]\\d{9}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluateWithObject(value.trim())
    return result
}

/**
 Trims the string and check whether it is valid or not
 
 - parameter value: input string to be tested
 
 - returns: true if string is valid, else returns false
 */
func isValidString(value: String) -> Bool {
    return !(value.trim().isEmpty)
}

/// This function returns current months as INT
func getCurrentMonth()->Int {
    return (getCalendar().component(NSCalendarUnit.Month, fromDate: NSDate()))
}

/// This function returns current Year as INT
func getCurrentYear()->Int {
    return (getCalendar().component(NSCalendarUnit.Year, fromDate: NSDate()))
}

/// This function returns calendar used to get Month and year
func getCalendar()->NSCalendar {
    return NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)!
}

/// This function is used to convert date to proper format for date comparision
func formatDateToCompare(date:String)->NSDate{
    var convertedDate = NSDate()
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")
    convertedDate = dateFormatter.dateFromString(date)!
    return convertedDate
}

/// This function Will return Sessions or Session depending on count
func getTitleSession(count: Int)->String{
    return (count > 1) ? StringUtilsConstant.SESSIONS :  StringUtilsConstant.SESSION
}

/**
 This function will format the timestamp to required depending upon day,time
 
 - parameter timeStamp: timestamp from server
 
 - returns: string ,depending upon the condition
 */
func getTimeForFeedbackSection(timeStamp:Double)->String{
    let date1 = NSDate(timeIntervalSince1970:  timeStamp)
    return daysBetweenDates(date1)
}

/**
 This method will format Time as per the conditions
 
 - parameter userCommentedDate: date from the server
 
 - returns: string ,depending upon the condition
 */
func daysBetweenDates(userCommentedDate: NSDate)->String{
    let dateFormatter = NSDateFormatter()
    var timeStampDate: Int
    var todayDate: Int
    
    dateFormatter.dateFormat = TimeConversition.DATE
    timeStampDate = Int(dateFormatter.stringFromDate(userCommentedDate))!
    todayDate =  Int(dateFormatter.stringFromDate(NSDate()))!
    let daysDifference = numberOfDays(userCommentedDate, endDate: NSDate())
    if daysDifference == NumberConstant.ONE {
        
        return StringUtilsConstant.YESTERDAY
    } else if daysDifference == NumberConstant.ZERO {
        
        dateFormatter.dateFormat = TimeConversition.HOUR
        return dateFormatter.stringFromDate(userCommentedDate)
    }
    dateFormatter.dateFormat = TimeConversition.PREVIOUS_DATE
    return dateFormatter.stringFromDate(userCommentedDate)
}

/**
 Calculates number of days between two dates
 - parameter startDate: it indicates the starting date
 
 - parameter endDate: it indicates the end date
 
 - returns: difference of days between two days
 */
func numberOfDays(startDate: NSDate, endDate: NSDate) -> Int {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = StringUtilsConstant.DATE_FORMAT
    let formattedStartDate = dateFormatter.stringFromDate(startDate)
    let formattedEndDate = dateFormatter.stringFromDate(endDate)
    let endingDate:NSDate = dateFormatter.dateFromString(formattedEndDate)!
    let startingDate:NSDate = dateFormatter.dateFromString(formattedStartDate)!
    let calendar = NSCalendar.currentCalendar()
    let unit: NSCalendarUnit = .Day
    let components = calendar.components(unit, fromDate: startingDate, toDate: endingDate, options: [])
    return components.day
}

/// This function is used to get feedback text given by user or Gym
///
/// - parameter feedBack: UserFeedback or GymReply
///
/// - returns: feebdack or reply string
func getAttributedFeedBackText(feedBack: String) -> NSAttributedString {
    let feedBackTextColorAttribute = [NSForegroundColorAttributeName: getDateTextColorForUpComingDates()]
    let myAttribute = [ NSFontAttributeName: UIFont(name: FontType.HELVITICA_MEDIUM, size: CGFloat(FontSize.THIRTEEN))! ]
    var feedBackString = NSAttributedString(string: feedBack, attributes: feedBackTextColorAttribute)
    feedBackString = NSAttributedString(string: feedBack, attributes: myAttribute)
    return feedBackString
}

/// This Function is used to get Truncated String
///
/// - returns: TruncatedString
func getTruncatedString() -> NSAttributedString {
    let moreString = StringUtilsConstant.TRUNCATED_MORE
    let truncateStringColor = [NSForegroundColorAttributeName: moreTextColor()]
    return NSAttributedString(string: moreString, attributes: truncateStringColor)
}

/// This function is used to add zero for singular values
///
/// - parameter count: total count
///
/// - returns: zero or count value depending on condition
func appendZeroForSingularValue(count: Int) -> String {
    return (count > NumberConstant.NINE) ? String(count) :  BracketConstant.ZERO + String(count)
}

/// This function is used to get status for trial card
///
/// - parameter trialStatus: status of trial /attended,not attended
///
/// - returns: string value depending on condition
func getTrialStatusText(trialStatus: Int) -> String {
    return trialStatus == NumberConstant.ONE ? StringUtilsConstant.TRIA_NOT_ATTENDED  : StringUtilsConstant.TRIAL_ATTENDED
}

/// This function is used to show and hide Trial attendance lable depending on condition
///
/// - parameter trialType: Type of trial
///
/// - returns: boolean value determining wheher to show or hide label
func showTrialAttendanceLabel(trialType: String) -> Bool {
    return (trialType == StringUtilsConstant.PAST_TRIAL) ?  false : true
}

extension UILabel{
    /// this function will add spacing in label text
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    /**
     Number of lines in between the text lines
     
     - parameter yourString:  labelText
     - parameter labelWidth:  labelWidth
     - parameter labelHeight: labelHeight
     - parameter font:        Font for the label
     
     - returns: number of lines for label
     */
    func numberOfLinesInLabel(labelText: String, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = labelHeight
        paragraphStyle.maximumLineHeight = labelHeight
        paragraphStyle.lineBreakMode = .ByWordWrapping
        let attributes: [String: AnyObject] = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        let constrain = CGSizeMake(labelWidth, CGFloat(Float.infinity))
        let size = labelText.sizeWithAttributes(attributes)
        let stringWidth = size.width
        let numberOfLines = ceil(Double(stringWidth/constrain.width))
        return Int(numberOfLines)
    }
}

