//
//  FeedBackVC.swift
//  GymShim

import UIKit
import ResponsiveLabel

class FeedBackVC: CustomNotificationController, FeedBackDelegate, UITableViewDelegate, UITableViewDataSource, FeedBackListingApiDelegate, ReplyViwedByUser{
    
    @IBOutlet weak var tableViewFeedBack: UITableView!
    
    var feedBackViewModel = FeedBackViewModel()
    var TABLE_CELL_HEIGHT:CGFloat = 222
    var USERCOMMENT_SECTION_HEIGHT:CGFloat = 100
    var labelShowErrorMessage = UILabel()
    var makeWebserviceCall: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        showAddFeedBackButton()
        makeWebserviceCall = true
        addLogoAsNavigationTitle()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /// if the view just pops dont call API
        if (makeWebserviceCall){
            feedBackViewModel.pageNo = 1
            feedBackViewModel.feedBackListSet.removeAllObjects()
            feedBackViewModel.feedBackApiDelegate = self
            feedBackViewModel.getUserFeedBacks()
        } else {
            checkForErrorFromPostFeedBackScreen()
        }
        registerForNotificationToUpdateBadgeCount()
        makeWebserviceCall = true
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.FEEDBACK_SCREEN)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        labelShowErrorMessage.removeFromSuperview()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///Add observer to update Notification Badge
    func registerForNotificationToUpdateBadgeCount() {
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self,
                                 selector: #selector(checkForBadgeCount),
                                 name: NotificationConstant.UPDATE_BADGE_NOTIFICATION,
                                 object: nil)
    }
    
    /// this function is used for initial setup of feedback view
    func initialSetUp() {
        labelShowErrorMessage.hidden = true
        tableViewFeedBack.delegate = self
        tableViewFeedBack.dataSource = self
        tableViewFeedBack.registerNib(UINib(nibName: TableCellIdentifiers.FEEDBACK_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.FEEDBACK_TABLE_CELL)
    }
    
    /**
     navigate to feedback screen on button click
     */
    override func navigateToPostFeedBackScreen() {
        let postFeedBackVC = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.POST_FEEDBACK_VC) as! PostFeedBackVC
        makeWebserviceCall = false
        postFeedBackVC.feedBackDelegate = self
        pushVC(postFeedBackVC)
    }
    
    //MARK:Delegate Method
    func showToastMessage(response: AnyObject){
        feedBackViewModel.mapSinglePostToModel(response)
        CommonHelper().showToastMessageOn(view, message: ToastConstants.FEEDBACK_SUBMITTED_TOST)
        tableViewFeedBack.reloadData()
    }
    
    func noGymMembership() {
        self.view.makeToast(ToastMessages.NO_MEMBERSHIP_POST_FEEDBACK, duration: ToastConstants.TOAST_TIME, position: .Center)
    }
    
    /**
     reload tableview on successful API Call
     */
    func onSuccess() {
        feedBackViewModel.getTotalNumberOfSection() == NumberConstant.ZERO ? showNoResultFound() :  tableViewFeedBack.reloadData()
    }
    
    //TO-DO
    /**
     If the feedback api is failed to hit the code to be executed
     */
    func onFailure(error:String) {
        
    }
    
    //MARK: Reply Viewed Delegate
    func replyViewedbyUser() {
        tableViewFeedBack.reloadData()
    }
    
    /**
     show Error Message if no result Found
     */
    func showNoResultFound() {
        labelShowErrorMessage.frame = CGRectMake(0,self.view.frame.size.height/CGFloat(NumberConstant.TWO) - CGFloat(NumberConstant.FIFTY), self.view.frame.size.width, CGFloat(FontSize.TWENTYONE))
        labelShowErrorMessage.font = UIFont(name: FontFamilies.FONTFAMILY_HELVETICA_MEDIUM, size: CGFloat(FontSize.FOURTEEN))
        labelShowErrorMessage.text = ValidationConstants.NO_FEEDBACK_YET
        labelShowErrorMessage.numberOfLines = NumberConstant.TWO
        labelShowErrorMessage.textAlignment = .Center
        labelShowErrorMessage.hidden = false
        self.view.addSubview(labelShowErrorMessage)
        tableViewFeedBack.reloadData()
    }
    
    
    /// Check for Error Message When User Pops from Post feedback Screen
    func checkForErrorFromPostFeedBackScreen() {
        if (feedBackViewModel.getTotalNumberOfSection() == NumberConstant.ZERO){
            showNoResultFound()
        }
    }
}
