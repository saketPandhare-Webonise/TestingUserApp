//
//  NotificationTableCell.swift
//  GymShim


import UIKit

class NotificationTableCell: UITableViewCell {
    
    @IBOutlet weak var imageViewNotificationType: UIImageView!
    @IBOutlet weak var notificationText: UILabel!
    @IBOutlet weak var viewNotificationData: UIView!
    @IBOutlet weak var labelNotificationTime: UILabel!
    
    let characterLimit: Int = 100
    var notificationType: String = ""
    var notificationTitle: String = ""
    
    var notificationData = NotificationDetails() {
        didSet {
            setNotificationData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        CommonHelper.addShadowToView(viewNotificationData)
    }
    
    /// This function is used to set notification data that is dispalyed in cell
    func setNotificationData() {
        notificationText.text = (notificationType == NotificationConstant.BULK_UPDATE) ? setBulkNotificationData() : notificationData.notificationTitle
        notificationText.addTextSpacing(CGFloat(NumberConstant.TEXT_SPACING_CONSTANT))
    }
    
    /// This function is used to set notification data for type bulk notification
    /// return: string depending on condition
    func setBulkNotificationData() -> String {
        notificationTitle = notificationData.notificationTitle
        return (notificationTitle.characters.count < characterLimit) ? notificationTitle : notificationTitle[notificationTitle.startIndex..<notificationTitle.startIndex.advancedBy(characterLimit)] + StringUtilsConstant.TRUNCATE_TAIL_CONSTANT
    }
}
