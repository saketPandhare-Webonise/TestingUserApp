//
//  CommonHelper.swift
//  GymShim

import UIKit
import Toast_Swift
import QRCode

class CommonHelper {
    
    /**
     below method draws line below text field
     */
    func drawLineBelowTextField(textField : UITextField) {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor(hexString:ColorHexValue.TEXTFIELD_BOTTOM_BORDER)?.CGColor
        border.frame = CGRectMake(0, textField.frame.size.height - borderWidth  , textField.frame.size.width , textField.frame.size.height )
        border.borderWidth = borderWidth
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    /**
     shows toast message
     
     - parameter view:    view on which message is to be placed
     - parameter message: message to be displayed on view
     */
    func showToastMessageOn(view:UIView, message:String) {
        view.makeToast(message, duration: ToastConstants.TOAST_TIME, position: .Center)
    }
    
    /**
     Gets device size  for image
     - returns: returns image icon size
     */
    func getDeviceSizeForImage ()->String {
        enum iPhoneSizes : Int {
            case CASE_1X = 1, CASE_2X, CASE_3X
        }
        var iconSizeToreturn : String = ""
        var getPixelDimension : NSInteger = 0
        
        getPixelDimension = NSInteger(UIScreen .mainScreen().scale)
        switch getPixelDimension {
        case iPhoneSizes.CASE_1X.rawValue:
            iconSizeToreturn = ImageIconSize.SMALL
            return iconSizeToreturn
        case iPhoneSizes.CASE_2X.rawValue:
            iconSizeToreturn = ImageIconSize.MEDIUM
            return iconSizeToreturn
        case iPhoneSizes.CASE_3X.rawValue:
            iconSizeToreturn = ImageIconSize.LARGE
            return iconSizeToreturn
        default:
            break
        }
        return iconSizeToreturn
    }
    
    /**
     func to make imageview round
     
     - parameter image: UIImageView
     */
    func makeImageRound (image : UIImageView) {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.2).CGColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
    }
    
    /// Generate QR-Code For users unique no
    /// Parameters:- membershipNumber
    /// - returns: QR-Code Image
    func generateQRCodeForText(membershipNumber: String) -> UIImage{
        var combinedNumber: String = StringUtilsConstant.EMPTY_STRING
        combinedNumber = (membershipNumber != userID) ?
            userID + StringUtilsConstant.UNDERSCORE + membershipNumber  :
        membershipNumber
        let qrCode = QRCode(String(combinedNumber))
        return (qrCode?.image) ?? UIImage()
    }
    
    /// Get Calendar strip width depending upon phone size
    /// Autolayout is not working ,because calendar view requires specific width ,other wise its alingnment will not be proper so this function is needed
    /// - returns: width constant
    func getWidthForCalendarStrip()->CGFloat{
        var calendarStripWidth = CGFloat()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        if (screenSize.width == CGFloat(DeviceWidth.IPHONE_5)){
            calendarStripWidth = CGFloat(CalendarStripWidth.MINIMUM_WIDTH)
        }
        else if (screenSize.width == CGFloat(DeviceWidth.IPHONE_6_7)){
            calendarStripWidth = CGFloat(CalendarStripWidth.NORMAL_WIDTH)
        }
        else if (screenSize.width == CGFloat(DeviceWidth.IPHONE_6PLUS_7PLUS)){
            calendarStripWidth = CGFloat(CalendarStripWidth.MAXIMUM_WIDTH)
        }
            // default
        else{
            calendarStripWidth = CGFloat(CalendarStripWidth.MINIMUM_WIDTH)
        }
        return calendarStripWidth
    }
    
    /// Add red border below Button
    static func setCustomColorToButtonBelow(sender:UIButton, isSelected: Bool)->CALayer{
        let borderSenderButtonLayer = CALayer()
        borderSenderButtonLayer.backgroundColor  =  (isSelected == true) ? UIColor.init(hexValue: ColorHexValue.RED_COLOR).CGColor : UIColor(hexValue:ColorHexValue.NAVIGATION_BAR).CGColor
        borderSenderButtonLayer.frame = CGRectMake(0, (sender.layer.bounds.height + 1) + CGFloat(NumberConstant.TWO * UIButtonConstants.BUTTON_UNDERLYING_CONSTANT), sender.layer.bounds.width + CGFloat(UIButtonConstants.BUTTON_UNDERLYING_CONSTANT) , CGFloat(UIButtonConstants.BUTTON_UNDERLYING_CONSTANT))
        return borderSenderButtonLayer
    }
    
    /**
     Adds drop down shadow to view
     
     - parameter view: view on which shadow is to be added
     */
    static func addShadowToView(view: UIView) {
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSizeMake(1, 3)
    }
    
    /// Add red border below Button
    static func setBorderToButtonBelow(sender:UIButton, isSelected: Bool)->CALayer{
        let borderSenderButtonLayer = CALayer()
        borderSenderButtonLayer.backgroundColor  =  (isSelected == true) ? UIColor.init(hexValue: ColorHexValue.RED_COLOR).CGColor : UIColor(hexValue:ColorHexValue.NAVIGATION_BAR).CGColor
        borderSenderButtonLayer.frame = CGRectMake(CGFloat(UIButtonConstants.LEFT_SPACE), sender.layer.bounds.height - CGFloat(UIButtonConstants.BUTTON_UNDERLYING_CONSTANT), sender.layer.bounds.width - 30 , CGFloat(UIButtonConstants.BUTTON_UNDERLYING_CONSTANT))
        return borderSenderButtonLayer
    }
    
    static func clearSavedData() {
        let savedToken = NSUserDefaults.standardUserDefaults()
        savedToken.removeObjectForKey(UserDefaultConstants.TOKEN)
        isDeviceTokenRegistered = false
    }
    
    /**
     JSON serialization error handler and adds toast if the condition fails
     - parameter error: error in json format
     - parameter view: view on which toast is to be displayed
     */
    static func jsonSerializationErrorHandler(error: AnyObject, view: UIView) {
        if let json = try? NSJSONSerialization.JSONObjectWithData(error as! NSData, options: []) as! NSDictionary{
            CommonHelper().showToastMessageOn(view, message: (json.valueForKey(ResponseParameters.INFO)?.valueForKey(ResponseParameters.MESSAGE)!)! as! String)
        }
    }
    
    /**
     Adds border to the top of view
     - parameter view: vview on which border is to be placed
     */
    static func addTopBorderToView(view: UIView) {
        let border = CALayer()
        border.backgroundColor = UIColor.init(hexValue: ColorHexValue.DIVIDER_COLOR).CGColor
        border.frame = CGRectMake(CGFloat(NumberConstant.FIFTEEN), CGFloat(NumberConstant.ZERO), UIScreen.mainScreen().bounds.size.width - CGFloat(NumberConstant.FIFTY), CGFloat(NumberConstant.ONE))
        view.layer.addSublayer(border)
    }
    
    /// This function will return device token required for Notification
    ///
    /// - parameter deviceToken: data to het device token
    ///
    /// - returns: Device token as string
    static func getDeviceToken(deviceToken: NSData)->String {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        return tokenString
    }
    
    /// This function Will make button with rounded corner with apptheme color
    ///
    /// - parameter button: uibutton
    static func setButtonWithRoundedCorners(button: UIButton) {
        button.layer.cornerRadius =  button.bounds.size.width / 2
        button.backgroundColor = getAppThemeColor()
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.clipsToBounds = true
    }
    
    /// This function will clear color for rounded button in schedule view
    ///
    /// - parameter button: uibutton
    static func setClearColorForButtonBackground(button: UIButton) {
        button.backgroundColor = UIColor.clearColor()
        button.setTitleColor(UIColor(hexValue: ColorHexValue.GRAY_COLOR), forState: .Normal)
    }
    
    /// This function will return current year.
    ///
    /// - returns: current year as string
    static func getCurrentYear()->String {
        let year =  getDateComponent().year
        return String(year)
    }
    
    /// This function will return date component required to get current year and month
    ///
    /// - returns: date component
    static func getDateComponent()->NSDateComponents {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        return components
    }
    
    /// This function will return current month as string
    ///
    /// - returns: current month
    static func getCurrentMonth()->String {
        return NSDate().monthOfTheDate()!
    }
}

extension UIButton {
    
    /// Add spacing to image pace besides button text
    ///
    /// - parameter spacing: Image space from tile
    func centerImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
    }
}

extension NSDate {
    
    func getDateComponentForFormat(format: String) -> String? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
    
    /// This function will return current Month as String
    ///
    /// - returns: current month as string
    func monthOfTheDate() -> String? {
        return getDateComponentForFormat(StringUtilsConstant.CURRENT_MONTH_COMPONENT)
    }
}



