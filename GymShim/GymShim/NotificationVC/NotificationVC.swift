//
//  NotificationVC.swift
//  GymShim

import UIKit

class NotificationVC: CustomNotificationController, NotificationAPIDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewNotification: UITableView!
    var notificationViewModel: NotificationViewModel = NotificationViewModel()
    var labelShowErrorMessage = UILabel()
    var window: UIWindow?
    var isFromPushNotification: Bool = false
    var notificationType: String = ""
    var notificationNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        callAPIForNotification()
        uiSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.NOTIFICATION_SCREEN)
    }
    
    override func viewWillDisappear(animated: Bool) {
        labelShowErrorMessage.removeFromSuperview()
    }
    
    /// Custom Setup required for View
    func uiSetup() {
        registerTableViewNibs()
        self.title = NavigationBarTitle.NOTIFICATION
        hideNotificationButton()
    }
    
    /// API call To get Notification data
    func callAPIForNotification() {
        notificationViewModel.notificationAPIDelegate = self 
        notificationViewModel.getUserNotification()
    }
    
    /// Register custom table cells
    func registerTableViewNibs() {
        tableViewNotification.registerNib(UINib(nibName: TableCellIdentifiers.NOTIFICATION_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.NOTIFICATION_TABLE_CELL)
        tableViewNotification.delegate = self
        tableViewNotification.dataSource = self
    }
    
    // MARK: API Successfully called Delegate
    func onSuccess() {
        tableViewNotification.reloadData()
        if (notificationViewModel.notificationListArray.isEmpty){
            showNoResultFound()
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    /// this func is used to reset Notification Count
    func resetNotificationCount() {
        notificationBadgeCount = 0
    }
    
    /**
     show Error Message if no result Found
     */
    func showNoResultFound() {
        labelShowErrorMessage.frame = CGRectMake(0,self.view.frame.size.height/CGFloat(NumberConstant.TWO) - CGFloat(NumberConstant.FIFTY), self.view.frame.size.width, CGFloat(FontSize.TWENTYONE))
        labelShowErrorMessage.font = UIFont(name: FontFamilies.FONTFAMILY_HELVETICA_MEDIUM, size: CGFloat(FontSize.FOURTEEN))
        labelShowErrorMessage.text = ValidationConstants.NO_NOTIFICATIONS
        labelShowErrorMessage.numberOfLines = NumberConstant.TWO
        labelShowErrorMessage.textAlignment = .Center
        labelShowErrorMessage.hidden = false
        self.view.addSubview(labelShowErrorMessage)
    }
    
    override func goBack() {
        isFromPushNotification ? changeRootToHomeVC() : popVC()
    }
    
    /// This function is used to change toot controller to Home screen on click of back from birthday/anniversary view controller depending on condition 
     func changeRootToHomeVC () {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let initialViewController = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TABBAR) as! TabbarViewController
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        initialViewController.tabBar(initialViewController.tabBar, didSelectItem: initialViewController.tabBarItem)
        initialViewController.view .layoutIfNeeded()
    }

}
