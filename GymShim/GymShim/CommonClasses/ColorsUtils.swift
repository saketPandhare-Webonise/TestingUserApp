//
//  ColorsUtils.swift
//  GymShim

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexValue:Int) {
        self.init(red:(hexValue >> 16) & 0xff, green:(hexValue >> 8) & 0xff, blue:hexValue & 0xff)
    }
    
}

func grayColor()->UIColor{
   return  UIColor(hexValue: ColorHexValue.GRAY_COLOR)
}

/**
 sets navigation bar background color
 */
func navigationBarBackgroundcolor(navigationController:UINavigationController){
    navigationController.navigationBar.barTintColor =
        UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
}

/**
 this method returns backGround color for missed seesion by user for calendar view
 */
func getDateBackGroundColorForAbsentSession()->UIColor{
    return UIColor.init(patternImage: UIImage(named: ImageAssets.CALENDAR_MISSED)!)
}

/**
 this method returns backGround color for Attended seesion by user for calendar view
 */
func getDateBackGroundColorForAttendedSession()->UIColor{
   return UIColor.init(patternImage: UIImage(named: ImageAssets.CALENDAR_ATTENDED)!)
}

/**
 This method will return background color for FutureDates
 */
func getDateBackGroundColorForFuture()->UIColor{
    return UIColor.clearColor()
}

/**
 This method will return background color for missed session
 */
func getDateBackGroundColorForNoSession()->UIColor{
    return UIColor.clearColor()
}

/**
 this method returns date text color for Attended/Missed seesion by user for calendar view
 */
func getDateTextColorForAttendedAndMissedSession()->UIColor{
    return UIColor.whiteColor()
}

/**
 this method return text color for NoSession
 */
func getDateTextColorForNoSession()->UIColor{
    return  UIColor(hexValue: ColorHexValue.CALENDAR_DAY_COLOR)
}

/**
 this method will return text color for Upcoming Dates
 */
func getDateTextColorForUpComingDates()->UIColor{
    return  UIColor(hexValue: ColorHexValue.GRAY_COLOR)
}

/**
 this method returns color for upcoming dates i.e date ahead of currend date
 */
func getDefaultDateTextColor()->UIColor{
    return UIColor.blackColor()
}

/**
 this method will return APPTheme color
 */
func getAppThemeColor()->UIColor{
    return UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
}

/**
 this func will return Backround color of view
 */
func getViewBackGroundColor()->UIColor{
    return UIColor(hexValue: ColorHexValue.VIEW_BACKGROUND_COLOR)
}

/**
 this func will return feedback Unseen Color
 */
func getFeedBackBackgroundColor()->UIColor{
    return UIColor(hexValue: ColorHexValue.FEEDBACK_BACKGROUND_COLOR)
}

/**
 this func will return color for more text on feedback screen
 */
func moreTextColor()->UIColor{
    return  UIColor(hexValue: ColorHexValue.MORE_COLOR)
}

/// This fucntion is used to get color for trial status
///
/// - returns: UIColor
func getTrialStatusTextColor(trialStatus: Int) -> UIColor {
    return  (trialStatus == NumberConstant.ONE) ? UIColor(hexValue: ColorHexValue.TRIAL_NOT_ATTENDED) : UIColor(hexValue: ColorHexValue.TRIAL_ATTENDED)
}

/// This function is used to get hyperlink text color
/// - returns: UIColor
func getHyperLinkTextColor() -> UIColor {
     return UIColor(hexValue: ColorHexValue.HYPERLINK_COLOR)
}

