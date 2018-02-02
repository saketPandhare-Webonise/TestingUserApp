//
//  CustomNotificationController.swift
//  GymShim

import UIKit
import MIBadgeButton_Swift

class CustomNotificationController: UIViewController {
    
    @IBOutlet var btnNotificationBell: MIBadgeButton?  = MIBadgeButton()
    var btnNotificationHeight: CGFloat = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpNavigationController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpNavigationController() {
        addNotificationButton()
        navigationBarBackgroundcolor(self.navigationController!)
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image:UIImage(named: ImageAssets.BACK_BUTTON), style:.Plain, target:self, action:#selector(goBack))
        navigationBarBackgroundcolor(self.navigationController!)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.translucent = false
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()];
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
    }
    
    override func viewWillAppear(animated: Bool) {
          super.viewWillAppear(animated)
        
          checkForBadgeCount()
    }
    
    /// This function is used to add notification button to the RHS of Navigation bar
    func addNotificationButton() {
        btnNotificationBell!.frame = CGRectMake(0, 0, btnNotificationHeight, btnNotificationHeight)
        btnNotificationBell!.setImage(UIImage(named: ImageAssets.NOTIFICATION), forState: .Normal)
        btnNotificationBell!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
         btnNotificationBell!.addTarget(self, action: #selector(CustomNotificationController.navigateToNotificationScreen(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        let barButton : UIBarButtonItem = UIBarButtonItem(customView: btnNotificationBell!)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    
    /// This function will navigate user to notificationListing screen
    ///
    /// - parameter sender: button 
    func navigateToNotificationScreen(sender:UIButton) {
        let notificationVC = UIStoryboard.mainStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.NOTIFICATION_VC) as! NotificationVC
        navigationController?.pushViewController(notificationVC, animated: false)
    }
    
    /// Pop to previous controller
    func goBack(){
        popVC()
    }
    
    /// Hide back button from viewController where it is not needed
    func hideBackButton(){
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    /// Hide notification button from viewController whenever not needed
    func hideNotificationButton() {
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    /// Add feebback button On navigation bar
    func showAddFeedBackButton() {
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image:UIImage(named: ImageAssets.ADD_FEEDBACK), style:.Plain, target:self, action:#selector(navigateToPostFeedBackScreen))
    }
    
    /// navigate to feedback screen on button click,this method is overriden in child class
    func navigateToPostFeedBackScreen() {
    }
    
    /// add logo as title of navigation bar
    func addLogoAsNavigationTitle() {
        let logo = UIImage(named: ImageAssets.APPLOGO)
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    /// add logo as title of navigation bar as left aligned
    func addLogoAsNavigationTitleInLeft() {
        var logo = UIImage(named: ImageAssets.APPLOGO)
        logo = logo?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: logo, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    /// Set badge Count on notification bell
    func checkForBadgeCount() {
         dispalyNotificationBadge(notificationBadgeCount)
    }

    /// Display Notification Count Badge
    ///
    /// - parameter count: Inseen Notification Count
    func dispalyNotificationBadge(count: Int) {
         btnNotificationBell?.badgeString = (count == 0) ? "" : String(count)
    }
}
