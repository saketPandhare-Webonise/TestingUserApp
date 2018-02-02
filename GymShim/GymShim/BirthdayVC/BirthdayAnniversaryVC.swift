//
//  BirthdayAnniversaryVC.swift
//  GymShim


import UIKit

class BirthdayAnniversaryVC: CustomNotificationController {

    @IBOutlet weak var labelBirthdayText: UILabel!
    @IBOutlet weak var imageViewBirthday: UIImageView!
    var window: UIWindow?
    var notificationType: String = ""
    var notificationDescription: String = ""
    var fromPushNotification: Bool = false
    var notificationNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideNotificationButton()
        setBirthdayAnniversaryData()
        if (fromPushNotification) {
            readNotificationAPI()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// This function is used to set text and image as per notification type
    func setBirthdayAnniversaryData() {
        labelBirthdayText.text =  notificationDescription
        imageViewBirthday.image = getImageForBirthdayOrAnniversary()
    }
    
    /// This function return image to be displayed as per condition from notification
    /// return: UIImage [Birthday/Anniversary]
    func getImageForBirthdayOrAnniversary() -> UIImage {
        return ((notificationType == NotificationConstant.USER_BIRTHDAY) ? UIImage.init(named: ImageAssets.BIRTHDAY_IMAGE)  :   UIImage.init(named: ImageAssets.ANNIVERSARY_IMAGE))!
    }
    
    /// This function is used pop back depending on notification type
    override func goBack() {
        fromPushNotification ? navigateToNotificationListingScreen() : popVC()
    }
    
    /// This function will navigate user back to feedback screen when user comes from notification screen ,this will set the navigation stack
    func navigateToNotificationListingScreen() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let notificationController = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.NOTIFICATION_VC) as! NotificationVC
        notificationController.isFromPushNotification = true
        let navigationController = UINavigationController.init(rootViewController: notificationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    /// This function is used to Notify Server that notification has been read.
    func readNotificationAPI() {
        WebserviceHandler().notifyServerNotificationViewed(notificationNumber)
    }
}
