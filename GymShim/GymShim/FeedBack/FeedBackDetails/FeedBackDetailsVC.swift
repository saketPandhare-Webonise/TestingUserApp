//
//  FeedBackDetailsVC.swift
//  GymShim

import UIKit

protocol ReplyViwedByUser {
    func replyViewedbyUser()
}

class FeedBackDetailsVC: CustomNotificationController, GymFeedBackViewedDelegate {
    
    @IBOutlet weak var imageViewUserPhoto: UIImageView!
    @IBOutlet weak var labelUserCommentGymName: UILabel!
    @IBOutlet weak var labelSubject: UILabel!
    @IBOutlet weak var labelUserComment: UILabel!
    @IBOutlet weak var labelCommentTime: UILabel!
    @IBOutlet weak var imageViewGymPhoto: UIImageView!
    @IBOutlet weak var labelReplyedBy: UILabel!
    @IBOutlet weak var labelRepliedTime: UILabel!
    @IBOutlet weak var labelRepliedDescription: UILabel!
    @IBOutlet weak var viewGymReply: UIView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewFeedbackListCard: UIView!
    @IBOutlet weak var viewUserFeedBack: UIView!
    
    var viewAnimationTime: NSTimeInterval = 2.0
    var feedBackId: Int = 0
    var window: UIWindow?
    var spacing:CGFloat = 10
    var userFeedBack = FeedBackList()
    var gymFeedBack = GymReview()
    var feedBackViewModel = FeedBackDetailViewModel()
    var replyViwedDelegate: ReplyViwedByUser?
    var notificationNumber: Int = 0 /// To Mark Notification As viewed
    
    enum FromViewController {
        case FromNotification
        case FromNotificationListingScreen
        case FromFeedBackScreen
        case None
    }
    
    var fromViewController = FromViewController.None
    
    //MARK: View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// This is used to set feedback data in feedback details screen
        feedBackViewModel.notificationNumber = notificationNumber
        feedBackViewModel.feedBackID = feedBackId
        feedBackViewModel.delegateGymFeedBackViewed = self
        setDataOnView()
        hideNotificationButton()
        CommonHelper.addShadowToView(viewFeedbackListCard)
        initialSetUpForViewController()
    }
    
    override func viewWillAppear(animated: Bool) {
         Analytics.trackScreenByGoogleAnalytic(ScreenNames.FEEDBACK_DETAILSCREEN)
    }
    
    override func viewDidLayoutSubviews() {
        CommonHelper().makeImageRound(imageViewUserPhoto)
        CommonHelper().makeImageRound(imageViewGymPhoto)
        CommonHelper.addTopBorderToView(viewGymReply)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initialSetUpForViewController() {
        
        switch fromViewController {
            
        case .FromNotification:
             feedBackViewModel.getFeedBackInfo(feedBackId)
             feedBackViewModel.notifyServerAboutNotificationViewed(notificationNumber)
            
        case .FromNotificationListingScreen:
             feedBackViewModel.getFeedBackInfo(feedBackId)
            
        case .FromFeedBackScreen:
             showOrHideGymReply()
            
        default:
            break
            
        }
    }
    
    
    /**
     This func is used for initial set up of VC
     */
    func setDataOnView() {
        self.navigationItem.title = NavigationBarTitle.FEEDBACK
        labelUserComment.text = userFeedBack.userComment
        labelSubject.text = userFeedBack.title
        labelCommentTime.text = getTimeForFeedbackSection(userFeedBack.feedBackTime)
        labelUserCommentGymName.text = userFeedBack.revivedGymName
        labelRepliedDescription.text = gymFeedBack.gymComment
        labelRepliedTime.text = getTimeForFeedbackSection(gymFeedBack.reviewTime)
        labelReplyedBy.text = StringUtilsConstant.REPLY_BY + userFeedBack.revivedGymName
        labelUserComment.addTextSpacing(spacing)
        labelRepliedDescription.addTextSpacing(spacing)
        ImageUtility.setAsyncImage(imageViewUserPhoto!, imageUrl: (userFeedBack.reviewerImage), defaultImageName: ImageAssets.USERDEFAULT_IMAGE, completionBlock: nil)
        ImageUtility.setAsyncImage(imageViewGymPhoto!, imageUrl: (userFeedBack.revivedGymImage), defaultImageName: ImageAssets.GYM_ICON, completionBlock: nil)
        /// if feedback is not viwed then change background color of reply view
        
        if (!gymFeedBack.isViewed){
            viewGymReply.backgroundColor = getFeedBackBackgroundColor()
            animateViewAndMarkFeedBackAsViewed()
        }
    }
    
    ///MARK:FeedBack Viewed Delegate
    func gymFeedBackViewDelegate() {
        gymFeedBack.isViewed = true
        replyViwedDelegate?.replyViewedbyUser()
    }
    
    func gymFeedBackNotification() {
        userFeedBack = feedBackViewModel.userSingleFeedBackModel.dictionaryUserFeedBack
        gymFeedBack = feedBackViewModel.userSingleFeedBackModel.dictionaryUserFeedBack.dictionaryGymComment
        setDataOnView()
    }
    
    
    /// This function is used to animate background color of gym reply view
    func animateViewAndMarkFeedBackAsViewed() {
        UIView.animateWithDuration(viewAnimationTime, animations: { () -> Void in
            self.viewGymReply.backgroundColor = UIColor.whiteColor()
        })
        self.markFeedBackAsViewed()
    }
    
    /**
     It marks the feedback as viewed
     */
    func markFeedBackAsViewed(){
        feedBackViewModel.markFeedBackAsViewed(gymFeedBack.id)
    }
    
    /**
     It shows or hides reply
     */
    func showOrHideGymReply() {
        if isValidString(gymFeedBack.gymComment) {
            viewGymReply.hidden =  false
        } else {
            viewGymReply.hidden =  true
            bottomViewHeightConstraint.constant = CGFloat(NumberConstant.ZERO)
        }
    }
    
    /// Currently in Testing
    override func goBack(){
        
        switch fromViewController {
        case .FromNotification:
            navigateToFeedBackScreen()
            
        case .FromNotificationListingScreen:
            popVC()
            
        case .FromFeedBackScreen:
            popVC()
            
        default:
            break
        }
    }
    
    /// This function will navigate user back to feedback screen when user comes from notification screen ,this will set the navigation stack
    func navigateToFeedBackScreen() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let initialViewController = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TABBAR) as! TabbarViewController
        initialViewController.selectedIndex = TagBarTagConstants.FEEDBACK
        initialViewController.tabBarItem.tag = TagBarTagConstants.FEEDBACK
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        initialViewController.tabBar(initialViewController.tabBar, didSelectItem: initialViewController.tabBarItem)
        initialViewController.view .layoutIfNeeded()
    }
}
