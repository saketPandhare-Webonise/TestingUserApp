//
//  PNSettingTableViewCell.swift
//  GymShim
//

import UIKit

class PNSettingTableViewCell: UITableViewCell {
    @IBOutlet var switchPushNotificationOnOff: UISwitch!
    @IBOutlet var viewPNSetting: UIView!
    @IBOutlet var labelOptForPushNotification: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        CommonHelper.addShadowToView(viewPNSetting)
        switchPushNotificationOnOff.transform = CGAffineTransformMakeScale(CGFloat(NumberConstant.SWITCH_SCALING_FACTOR), CGFloat(NumberConstant.SWITCH_SCALING_FACTOR))
        labelOptForPushNotification.addTextSpacing(CGFloat(NumberConstant.FIVE))
    }
    
    ///This function is used to set default status of notification button depending on what user action has been performed
    func setDefaultStatus() {
        
        if (deviceToken.isEmpty && !isDeviceTokenRegistered){
            setLabelAndSwitchInfo(StringUtilsConstant.NOTIFICATION_DISABLE_TEXT, enableSwitch: false, switchStatus: false)
        }
        else if (!isDeviceTokenRegistered){
            setLabelAndSwitchInfo(StringUtilsConstant.DEFAULT_TEXT_NOTIFICATION, enableSwitch: true, switchStatus: false)
        }
        else if (isDeviceTokenRegistered) {
            setLabelAndSwitchInfo(StringUtilsConstant.DEFAULT_TEXT_NOTIFICATION, enableSwitch: true, switchStatus: true)
        }
        labelOptForPushNotification.addTextSpacing(CGFloat(NumberConstant.FIVE))
    }
    
    
    /// This function sets label data along with UISwitch properties depending on user action
    ///
    /// - parameter labelText:    label text
    /// - parameter enableSwitch: enable switch flag
    /// - parameter switchStatus: switch on /off flag
    func setLabelAndSwitchInfo(labelText: String, enableSwitch: Bool, switchStatus:Bool) {
        labelOptForPushNotification.text = labelText
        switchPushNotificationOnOff.enabled = enableSwitch
        switchPushNotificationOnOff.on = switchStatus
    }
}
