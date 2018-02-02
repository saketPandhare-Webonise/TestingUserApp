//
//  NotificationVC+TableView.swift
//  GymShim


import UIKit

extension NotificationVC {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationViewModel.notificationListArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return constructNotificationListingTableCell(tableView, indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch notificationViewModel.getNotificationType(indexPath) {
            
        case NotificationConstant.FEEDBACK:
            navigateToFeedBackDetailsScreen(indexPath)
            
        case NotificationConstant.MEMBERSHIP_DETAILS,
             NotificationConstant.TRANSFER_NOTIFICATION:
            navigateToMembershipDetailsScreen(indexPath)
            
        case NotificationConstant.TRIAL:
            navigateToTrialScreen(indexPath)
            
        case NotificationConstant.USER_BIRTHDAY, NotificationConstant.USER_ANNIVERSARY:
            navigateToBirthdayScreen(indexPath)
            
        case NotificationConstant.BULK_UPDATE:
            navigateToBulkNotificationDetailPage(indexPath)
            
        default:
            break
        }
        
    }
    
    /// This function is used to change the root view controller
    func changeRootViewController(viewController:UIViewController){
        let  navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        viewController.view .layoutIfNeeded()
    }
    
    /// This function is used to load Notification Table cell
    ///
    /// - parameter tableView: NotificationListTableView
    /// - parameter indexPath: IndexPath
    ///
    /// - returns: TableCell
    func constructNotificationListingTableCell(tableView:UITableView, indexPath:NSIndexPath)->UITableViewCell {
        let notificationTableCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.NOTIFICATION_TABLE_CELL) as! NotificationTableCell
        notificationTableCell.notificationType =  notificationViewModel.getNotificationType(indexPath)
        notificationTableCell.notificationData = notificationViewModel.notificationListArray[indexPath.row]
        notificationTableCell.labelNotificationTime.text = notificationViewModel.getNotificationTime(indexPath)
        return notificationTableCell
    }
    
    //MARK:SCrollView Delegate Method for pagination
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (notificationViewModel.notificationListArray.count < notificationViewModel.getTotalNotificationPresent()){
            notificationViewModel.incrementPageNo()
            notificationViewModel.getUserNotification()
        }
    }
    
    /// This function will navigate user to FeedBackDetail Screen
    ///
    /// - parameter indexPath: Selected TableCell IndexPath
    func navigateToFeedBackDetailsScreen(indexPath: NSIndexPath) {
        let feedBackDetails = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.FEEDBACK_DEATILS) as! FeedBackDetailsVC
        feedBackDetails.fromViewController = .FromNotificationListingScreen
        feedBackDetails.feedBackId = notificationViewModel.getNotificationResourceID(indexPath)
        feedBackDetails.notificationNumber = notificationViewModel.getNotificationID(indexPath)
        pushVC(feedBackDetails)
    }
    
    /// This function will navigate user to MembershipDetails Screen
    ///
    /// - parameter indexPath: Selected TableCell IndexPath
    func navigateToMembershipDetailsScreen(indexPath: NSIndexPath) {
        let storyboard = UIStoryboard.mainStoryboard
        let membershipDetails = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.MEMBERSHIP_DETAILS) as! MemberShipDetailsVC
        membershipDetails.memberShipID = String(notificationViewModel.getNotificationResourceID(indexPath))
        pushVC(membershipDetails)
    }
    
    /// This function will navigate user to TrailScreen Screen
    ///
    /// - parameter indexPath: Selected TableCell IndexPath
    func navigateToTrialScreen(indexPath: NSIndexPath) {
        let trialDetails = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TRIAL_DETAILS_VC) as! TrialDetailsVC
        trialDetails.fromNotificationListingScreen = true
        trialDetails.trialID = notificationViewModel.getNotificationResourceID(indexPath)
        pushVC(trialDetails)
    }
    
    /// This function is used to navigate user to birthday / anniversary screen
    /// - parameters indexPath: Selected table cell indexPath
    
    func navigateToBirthdayScreen(indexPath: NSIndexPath) {
        let birthdayVC = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.BIRTHDAYVC) as! BirthdayAnniversaryVC
        birthdayVC.notificationDescription =  notificationViewModel.getNotificationDescription(indexPath)
        birthdayVC.notificationType = notificationViewModel.getNotificationType(indexPath)
        birthdayVC.fromPushNotification = false
        pushVC(birthdayVC)
    }
    
    /// This function is used to navigate user to bulk notification detail screen
    /// - parameters indexPath: Selected table cell indexPath
    func navigateToBulkNotificationDetailPage(indexPath: NSIndexPath) {
        let bulkNotificationVC = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.BULK_NOTIFICATION_VC) as! BulkNotificationDetailVC
        bulkNotificationVC.notificationDescription =  notificationViewModel.getNotificationDescription(indexPath)
        bulkNotificationVC.notificationDate =  notificationViewModel.getNotificationTime(indexPath)
        pushVC(bulkNotificationVC)
    }
}
