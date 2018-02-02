//
//  BulkNotificationDetailVC.swift
//  GymShim

import UIKit
import TTTAttributedLabel

class BulkNotificationDetailVC: CustomNotificationController,TTTAttributedLabelDelegate {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageViewGymLogo: UIImageView!
    @IBOutlet weak var labelNotificationText: TTTAttributedLabel!
    @IBOutlet weak var labelNotificationDate: UILabel!
    
    var notificationDescription: String = ""
    var notificationDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetUp()
    }
    
    /// This function is used to do setup on bulknotification VC
    func uiSetUp() {
        hideNotificationButton()
        setPropertiesForNotificationText()
        labelNotificationText.text = notificationDescription
        labelNotificationDate.text = notificationDate
        CommonHelper.addShadowToView(viewContainer)
    }
    
    /// This function is used to open URL in browser which user has clicked
    /// Parameters:- User clicked URL
    func openUrl(url: NSURL?) {
        guard let url = url else {
            return
        }
        UIApplication.sharedApplication().openURL(url)
    }
    
    /// This function is used to detect link in text and add suggested color to it
    func setPropertiesForNotificationText() {
        labelNotificationText.delegate = self
        labelNotificationText.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        labelNotificationText.linkAttributes = [kCTForegroundColorAttributeName : getHyperLinkTextColor()]
        labelNotificationText.lineSpacing = CGFloat(NumberConstant.FIVE)
    }
    
    //MARK: Delegate method for link click
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        openUrl(url)
    }
}
