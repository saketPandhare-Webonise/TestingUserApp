//
//  AppDelegate.swift
//  GymShim


import UIKit
import EZSwiftExtensions
import IQKeyboardManagerSwift
import UserNotifications
import ObjectMapper
import Google

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    var notificationModel: NotificationModel = NotificationModel()
    var pageNo:Int = 1
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        uiSetup()
        configureGoogleAnalytics()
        registerForPushNotifications(application)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        if (deviceToken.isEmpty && UIApplication.sharedApplication().currentUserNotificationSettings()?.types.rawValue != 0){
            registerForPushNotifications(application)
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        callAPIToCheckNotificationBadgeCount()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /// This method is used for initial configuration of GoogleAnalytic
    func configureGoogleAnalytics() {
        // Configure tracker from GoogleService-Info.plist.
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        // Optional: configure GAI options.
        guard let gai = GAI.sharedInstance() else {
            assert(false, "Google Analytics not configured correctly")
            return
        }
        gai.trackUncaughtExceptions = true  // report uncaught exceptions
    }
    
    /// This method is used to check notification badge count when user comes from background
    func callAPIToCheckNotificationBadgeCount() {
        if (!userLoginToken.isEmpty) {
             let userFeedBackRequestPara = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.PAGE: pageNo,RequestParameters.PER_PAGE: pageNo]
            WebserviceHandler().callWebService(WebServiceUrls.USER_NOTIFICATION(), methodType: WebServiceType.GET, parameters: userFeedBackRequestPara, succeess: {
                (response, headerFields) in
                self.mapResponseToModel(response)
                }, failure: { (error) in
                    print("Error has \(error)")
            })
        }
    }
    
    /// This function maps response of notification count to its model
    ///
    /// - parameter response: response from API Call
    func mapResponseToModel(response: AnyObject?) {
        notificationModel = Mapper<NotificationModel>().map(response)!
        setNotificationBadgeCount()
    }
    
    /// This function is used to setNotificationBadgeCout when app comes from background
    func setNotificationBadgeCount() {
        notificationBadgeCount = notificationModel.dictionaryNotification.unReadCount
        localNotificationToUpdateBadgeCount()
    }
    
    //MARK:Notification Setting
    func registerForPushNotifications(application: UIApplication) {
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.currentNotificationCenter().delegate = self
            UNUserNotificationCenter.currentNotificationCenter().requestAuthorizationWithOptions([.Badge, .Sound, .Alert], completionHandler: {(granted, error) in
                if (granted)
                {
                    UIApplication.sharedApplication().registerForRemoteNotifications()
                }
                else{
                    //Do stuff if unsuccessful...
                }
            })
        }
        else{ //If user is not on iOS 10 use the old methods we've been using
            let notificationSettings = UIUserNotificationSettings(
                forTypes: [.Badge, .Sound, .Alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
            
        }
    }
    
    //MARK:Notification delegate Methods
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    ///TO-DO:Need to change after API Integration
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken token: NSData) {
        deviceToken = CommonHelper.getDeviceToken(token)
        if (!userLoginToken.isEmpty && !deviceToken.isEmpty) {
            registerUserForNotification(userLoginToken)
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register:", error)
    }
    
    ///To-DO Currently in testing Below code will chage once API is Integrated
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]){
        navigateForNotificationType(application, userInfo: userInfo)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void)
    {
        //Handle the notification
       //increase the notification Badge count on Receiving Notification
        notificationBadgeCount = notificationBadgeCount + 1
        localNotificationToUpdateBadgeCount()
        completionHandler(
            [UNNotificationPresentationOptions.Alert,
                UNNotificationPresentationOptions.Sound,
                UNNotificationPresentationOptions.Badge])
    }
    
    /// This method is used to Post Notification to update badgecount when App is in active state
    func localNotificationToUpdateBadgeCount() {
        let badgeUpdateNotification = NSNotificationCenter.defaultCenter()
        badgeUpdateNotification.postNotificationName(NotificationConstant.UPDATE_BADGE_NOTIFICATION,
                                object: nil,
                                userInfo: nil)
    }
    
    /// This Method will Navigate to screen according to notification Received
    ///
    /// - parameter application: UIApplication
    /// - parameter userInfo:    userInformation
    func navigateForNotificationType(application: UIApplication,userInfo: [NSObject : AnyObject]){
        
        /// This is done to handle case when user is using ios version less than 10
        /// Notifications will not be received when app is in foreground state
        if (UIDevice.isVersionOrEarlier(.Nine) && application.applicationState == .Active){
            return
        }
        
        if (application.applicationIconBadgeNumber > 0) {
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber - 1
        }
          navigateAfterReceivingNotification(userInfo)
       }
    
    /// This function is used to seperate out parametes required to navigate after receiving notification 
    /// parameters: userInfo received form notification
    func getParametersFromNotification (userInfo: [NSObject : AnyObject]) -> (notificationType: String, notificationID: Int, notificationNumber: Int, notificationDescription: String) {
        var notificationType: String? = StringUtilsConstant.EMPTY_STRING
        var notificationID: Int? = NumberConstant.ZERO
        var notificationNumber: Int? = NumberConstant.ZERO
        var notificationDescription: String? = StringUtilsConstant.EMPTY_STRING
        
        if (((userInfo[NotificationConstant.TYPE]) != nil)  && ((userInfo[NotificationConstant.RESOURCE]) != nil)){
            notificationType = userInfo[NotificationConstant.TYPE] as? String
            notificationID = userInfo[NotificationConstant.RESOURCE] as? Int
            notificationNumber = userInfo[NotificationConstant.NOTIFICATIONID] as? Int
            notificationDescription = userInfo[NotificationConstant.NOTIFICATION_DESCRIPTION] as? String
            
            /// Decrease the notification Count when user Open its
            if (notificationBadgeCount > NumberConstant.ZERO) {
                notificationBadgeCount = notificationBadgeCount - NumberConstant.ONE
            }
            
        }
        return(notificationType ?? StringUtilsConstant.EMPTY_STRING,
               notificationID ?? NumberConstant.ZERO, notificationNumber ?? NumberConstant.ZERO,
               notificationDescription ?? StringUtilsConstant.EMPTY_STRING)
    }
    
    /// This function is used to navigate user to different screen after click on notification received
    /// parameters: userinfo received form notification
    func navigateAfterReceivingNotification(userInfo: [NSObject : AnyObject]) {
        
        let notificationData = getParametersFromNotification(userInfo)
        
        switch notificationData.notificationType {
        case NotificationConstant.FEEDBACK:
            navigateToFeedBackDetailScreen(notificationData.notificationID, notificationNumber:notificationData.notificationNumber)
            
        case NotificationConstant.MEMBERSHIP_DETAILS,
             NotificationConstant.TRANSFER_NOTIFICATION:
             navigateToMemberShipDetailScreen(notificationData.notificationID, notificationNumber:notificationData.notificationNumber)
            
        case NotificationConstant.TRIAL:
            navigateToMyTrialScreenScreen(notificationData.notificationID, notificationNumber:notificationData.notificationNumber)
            
        case NotificationConstant.USER_ANNIVERSARY, NotificationConstant.USER_BIRTHDAY:
            navigateToBirthdayScreen(notificationData.notificationID, notificationNumber: notificationData.notificationNumber, notificationDescription: notificationData.notificationDescription, notificationType:notificationData.notificationType)
       
        case NotificationConstant.PAYMENT_NOTIFICATION, NotificationConstant.BULK_UPDATE:
             navigateToNotificationListingScreen()
            
        default:
            navigateToNotificationListingScreen()
        }

    }
    
    func setupIQKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    
    /**
     Sets up tab bar and decides which screen should be root view controller depending whether user has logged in or not
     */
    func uiSetup() {
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        let statusBar: UIView = UIApplication.sharedApplication().valueForKey(StatusBarConstants.STATUS_BAR) as! UIView
        if statusBar.respondsToSelector(Selector(StatusBarConstants.SET_BACKGROUND_COLOR)) {
            statusBar.backgroundColor = UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
        }
        if (!userLoginToken.isEmpty && isResetPassword){
            navigateToHomeScreen()
        } else if (!userLoginToken.isEmpty && !isResetPassword){
            navigateToChangePasswordScreen()
        } else {
            deviceToken = ""
            navigateToLoginScreen()
        }
    }
    
    /// This function navigates to HomeScreen if we have accesstoken as well as password is reset by user
    func navigateToHomeScreen() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let initialViewController = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TABBAR) as! TabbarViewController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        initialViewController.tabBar(initialViewController.tabBar, didSelectItem: initialViewController.tabBarItem)
        initialViewController.view .layoutIfNeeded()
    }
    
    /// navigate to Change password screen if user has not reset it
    func navigateToChangePasswordScreen() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let changePasswordVC = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.CHANGEPASSWORD) as! ChangePasswordVC
        changePasswordVC.fromLogin = true
        changeRootViewController(changePasswordVC)
    }
    
    /// navigate to Login screen if its first time user
    func navigateToLoginScreen() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let loginVC = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.LOGIN) as! LoginVC
        changeRootViewController(loginVC)
    }
    
    /// This function is used to change the root view controller
    func changeRootViewController(viewController:UIViewController){
        let  navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        viewController.view .layoutIfNeeded()
    }
    
    /// This method will navigate to FeedBackDetail Page when Notification Received
    ///
    /// - parameter feedbackId: feedBackID
    func navigateToFeedBackDetailScreen(feedbackId: Int, notificationNumber:Int) {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let feedBackDetails = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.FEEDBACK_DEATILS) as! FeedBackDetailsVC
        feedBackDetails.fromViewController = .FromNotification
        feedBackDetails.feedBackId = feedbackId
        feedBackDetails.notificationNumber = notificationNumber
        changeRootViewController(feedBackDetails)
    }
    
    /// This method will navigate to MemberShipDetails  Page when Notification Received
    ///
    /// - parameter feedbackId: memberShipID
    func navigateToMemberShipDetailScreen(membershipID: Int, notificationNumber:Int) {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let membershipDetails = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.MEMBERSHIP_DETAILS) as! MemberShipDetailsVC
        membershipDetails.fromNotification = true
        membershipDetails.notificationNumber = notificationNumber
        membershipDetails.memberShipID = String(membershipID)
        changeRootViewController(membershipDetails)
    }
    
    /// This method will navigate to MemberShipDetails  Page when Notification Received
    ///
    /// - parameter feedbackId: memberShipID
    func navigateToMyTrialScreenScreen(trialID: Int, notificationNumber:Int) {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let trialDetailsScreen = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TRIAL_DETAILS_VC) as! TrialDetailsVC
        trialDetailsScreen.fromNotification = true
        trialDetailsScreen.notificationNumber = notificationNumber
        trialDetailsScreen.trialID = trialID
        changeRootViewController(trialDetailsScreen)
    }
    
    /// This method will navigate to Birthday/Anniversary Screen when Notification Received
    /// - parameters birthdatID: birthdayID
    /// - parameters notificationNumber:notificationNumber
    /// - parameters notificationDescription:Description
    func navigateToBirthdayScreen(birthdayId: Int, notificationNumber:Int, notificationDescription: String, notificationType:String) {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let birthdayVC = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.BIRTHDAYVC) as! BirthdayAnniversaryVC
        birthdayVC.fromPushNotification = true
        birthdayVC.notificationDescription = notificationDescription
        birthdayVC.notificationNumber = notificationNumber
        birthdayVC.notificationType = notificationType
        changeRootViewController(birthdayVC)
    }
    
    /// This method is used to navigate user to notification listing screen
    func navigateToNotificationListingScreen() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let notificationVC = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.NOTIFICATION_VC) as! NotificationVC
        notificationVC.isFromPushNotification = true
        changeRootViewController(notificationVC)
    }
    
    /// Register user to receive notification
    func registerUserForNotification(authToken: String){
        if (!deviceToken.isEmpty){
            let notificationInfo = [RequestParameters.OS : StringUtilsConstant.OS, RequestParameters.REG_ID : deviceToken]
            let userInfo = [RequestParameters.NOTIFICATION : notificationInfo, RequestParameters.AUTH_TOKEN:userLoginToken]
            WebserviceHandler().callWebService(WebServiceUrls.USER_NOTIFICATION(), methodType: WebServiceType.POST, parameters: userInfo, succeess: {(response, headerFields) in
              let regestrationID: String =  (response?.valueForKeyPath(ResponseParameters.AUTHENTICATION)?.valueForKeyPath(StringUtilsConstant.NOTIFICATION_REG_ID) as? String) ?? ""
                        userRegistrationID = regestrationID
                        isDeviceTokenRegistered = true
                }, failure: {_ in
            })
        } else {
            userRegistrationID = ""
        }
    }

}
