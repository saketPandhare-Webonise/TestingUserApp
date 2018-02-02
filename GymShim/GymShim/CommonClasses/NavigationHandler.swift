//
//  NavigationHandler.swift
//  GymShim


import UIKit

class NavigationHandler: NSObject {
    
    
    /// Change root view controller to Tabbar Controller
    func changeRootViewToTabBarController(fromChangePassword: Bool) {
        let viewController = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TABBAR) as! TabbarViewController
        viewController.tabBar(viewController.tabBar, didSelectItem: viewController.tabBarItem)
        viewController.view .layoutIfNeeded()
        UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
        let toastMessage = fromChangePassword ? ToastMessages.CHANGE_PASSWORD_SUCCESSFUL_MESSAGE : ToastMessages.LOGIN_SUCCESSFUL
        CommonHelper().showToastMessageOn(viewController.view, message: toastMessage)
    }
    
    /// Change root to LoginVC After user Logout
    func changeRootToLoginVC(isTokenExpired:Bool, islogOutClicked:Bool) {
        let viewController = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.LOGIN) as! LoginVC
        viewController.isTokenExpired = isTokenExpired
        viewController.isLogOutClicked = islogOutClicked
        let navigationController = UINavigationController(rootViewController: viewController)
        UIApplication.sharedApplication().keyWindow?.rootViewController = navigationController
    }
    
    
    /// this func is used to navigate to membershipdetails from the Schedule VC
    ///
    /// - parameter navigationController: navigation control of Schedule VC
    /// - parameter gymID:GymID from model
    static func navigateToMembershipDetials(navigationController: UINavigationController,membershipID: String){
        let memberShipDetailsVC = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.MEMBERSHIP_DETAILS) as! MemberShipDetailsVC
        memberShipDetailsVC.memberShipID = membershipID
        navigationController.pushViewController(memberShipDetailsVC, animated: true)
    }
    
    /// this func is used to navigate to membershipdetails from the parent VC
    ///
    /// - parameter navigationController: navigation control of parent VC
    /// - parameter gymID:GymID from model
    static func navigateToScheduleScreen(navigationController: UINavigationController,membershipID: String){
        let memberShipDetailsVC = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.GYM_SCHEDULE_VC) as! GymScheduleVC
        memberShipDetailsVC.membershipId = membershipID
        navigationController.pushViewController(memberShipDetailsVC, animated: true)
    }
    
    /// Pushes to feedback listing screen, where feedbacks can be listed
    ///
    /// - parameter window: current window
    static func navigateToFeedBackScreen(window: UIWindow) {
        //window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let initialViewController = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TABBAR) as! TabbarViewController
        initialViewController.selectedIndex = TagBarTagConstants.FEEDBACK
        initialViewController.tabBarItem.tag = TagBarTagConstants.FEEDBACK
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
        initialViewController.tabBar(initialViewController.tabBar, didSelectItem: initialViewController.tabBarItem)
        initialViewController.view .layoutIfNeeded()
    }
    
  
}
