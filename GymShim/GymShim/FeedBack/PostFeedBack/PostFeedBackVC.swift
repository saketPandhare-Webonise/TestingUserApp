//
//  PostFeedBackVC.swift
//  GymShim

import UIKit
import IQKeyboardManagerSwift

protocol FeedBackDelegate {
    func showToastMessage(response: AnyObject)
    func noGymMembership()
}

class PostFeedBackVC: CustomNotificationController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, GymNamePostFeedBackDelegate, FeedBackPostedDelegate {
    @IBOutlet weak var textViewGymName: UITextView!
    @IBOutlet weak var textViewSubject: UITextView!
    @IBOutlet weak var textViewUserFeedBack: UITextView!
    @IBOutlet weak var tableViewGymList: UITableView!
    @IBOutlet weak var buttonDropDownImage: UIButton!
    @IBOutlet weak var buttonShowGymList: UIButton!
    @IBOutlet var viewSubject: UIView!
    @IBOutlet var viewGymName: UIView!
    
    var feedBackDelegate: FeedBackDelegate?
    var postFeedBackViewModel = PostFeedBackViewModel()
    var isSubjectAdded:Bool = false
    var isFeedBackAdded:Bool = false
    var isGymSelected:Bool = false
    var gymNameTextFieldtag:Int = 1
    var subjectTextFieldTag:Int = 2
    var feedBackTextFieldTag:Int = 3
    var selectedGymID:Int = 0
    var gymNameCellHeight:CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        initialUiSetUp()
    }
    
    override func viewWillAppear(animated: Bool) {
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.ADD_FEEDBACK_SCREEN)
    }

    override func viewDidLayoutSubviews() {
        textViewUserFeedBack.layer.shadowColor = UIColor.blackColor().CGColor
        textViewUserFeedBack.layer.shadowOffset =  CGSizeMake(0, 0)
        textViewUserFeedBack.layer.shadowOpacity = 0.1
        CommonHelper.addShadowToView(viewSubject)
        CommonHelper.addShadowToView(viewGymName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     this func is used for initial configuration when view loads
     */
    func initialConfiguration() {
        postFeedBackViewModel.getSubscribedGymListForUser()
        postFeedBackViewModel.gymNamePostFeedBackDelegate = self
        postFeedBackViewModel.feedBackPostedDelegate = self
        configureGymListTableView()
        setupIQKeyboardManager()
        hideNotificationButton()
    }
    
    /**
     this func is used for initial SetUp of UI when view loads
     */
    func initialUiSetUp() {
        navigationItem.title = NavigationBarTitle.FEEDBACK
        textViewGymName.delegate = self
        textViewSubject.delegate = self
        textViewUserFeedBack.delegate = self
        textViewSubject.textContainer.maximumNumberOfLines = 1
        hideDropDownMenuFromVC(true)
        tableViewGymList.hidden = true
    }
    
    func setupIQKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    
    func hideDropDownMenuFromVC(show:Bool){
        buttonDropDownImage.hidden = show
        buttonShowGymList.hidden = show
    }
    
    func configureGymListTableView() {
        tableViewGymList.delegate = self
        tableViewGymList.dataSource = self
        tableViewGymList.registerNib(UINib(nibName: TableCellIdentifiers.GYM_NAME_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.GYM_NAME_TABLE_CELL)
    }
    
    //MARK: TextViewDelegarte Methods
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.tag == subjectTextFieldTag && textView.text == StringUtilsConstant.SUBJECT){
            textViewSubject.text = ""
            isSubjectAdded = false
        }
        else if (textView.tag == feedBackTextFieldTag && textView.text == StringUtilsConstant.WRITE_YOUR_FEED_BACK){
            textViewUserFeedBack.text = ""
            isFeedBackAdded = false
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        ///checking data for feedBack textfield and assign appropriate flag
        if (!textViewUserFeedBack.text .isEmpty && textView.tag == feedBackTextFieldTag){
            isFeedBackAdded = true
        }
        else if (textViewUserFeedBack.text .isEmpty && textView.tag == feedBackTextFieldTag){
            isFeedBackAdded = false
        }
        
        //// checking data for subject textfield and assign appropriate flag
        if (!textViewSubject.text.isEmpty && textView.tag == subjectTextFieldTag){
            isSubjectAdded = true
        }
        else if (textViewSubject.text.isEmpty && textView.tag == subjectTextFieldTag){
            isSubjectAdded = false
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (textViewSubject.text.isEmpty && textView.tag == subjectTextFieldTag){
            textView.text = StringUtilsConstant.SUBJECT
        }
        else if (textViewUserFeedBack.text .isEmpty && textView.tag == feedBackTextFieldTag){
            textView.text = StringUtilsConstant.WRITE_YOUR_FEED_BACK
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        /// if its the subject TextView then on its click dismiss keyboard
        if(textView.tag == subjectTextFieldTag && text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    /// currently in testing will remove print statment after WS Implementation
    //MARK: Button Click Event
    @IBAction func buttonSubmitFeedBack(sender: AnyObject) {
        if (!isFeedBackAdded || !isSubjectAdded || !isGymSelected){
            CommonHelper().showToastMessageOn(self.view, message: ValidationConstants.ENTER_ALL_FIELDS)
        }else {
            postFeedBackViewModel.callWebserviceForPostingFeedBack(selectedGymID, subject: textViewSubject.text, feedBack:textViewUserFeedBack.text)
        }
    }
    
    //// currently in testing
    @IBAction func buttonDropDownClicked(sender: AnyObject) {
        toggleTableViewAndButtonImage()
    }
    
    /**
     This function will toggle Button image and tableview[show/hide] on selection/deselection
     */
    func toggleTableViewAndButtonImage() {
        tableViewGymList.hidden = !tableViewGymList.hidden
        (tableViewGymList.hidden) ?  buttonDropDownImage .setImage(UIImage(named:ImageAssets.DOWN_ARROW_IMAGE), forState: .Normal) :  buttonDropDownImage .setImage(UIImage(named:ImageAssets.UP_ARROW_IMAGE), forState: .Normal)
    }
    
    //MARK: Webservice callBack Delegate
    func onSuccess() {
        if postFeedBackViewModel.getGymArrayCount() == NumberConstant.ZERO {
            popVC()
            feedBackDelegate?.noGymMembership()
        } else {
            (postFeedBackViewModel.getGymArrayCount() > NumberConstant.ONE) ? showDropDownMenu() : hideDropDownTableMenu()
        }
    }
    
    //TO-DO: when error is received from Server
    func onFailure(error: String) {
    }
    
    /**
     FeedBack Posted Delegate
     */
    func feedBackPostedSuccessfully(response:AnyObject) {
        feedBackDelegate?.showToastMessage(response)
        popVC()
    }
    
    //TO-DO: Error Posting FeedBack
    func errorPostingFeedBack() {
        
    }
    
    //MARK: Show/Hide Function for tableview
    /**
     this func is used when user is subscribed to more than 1 gym
     */
    func showDropDownMenu() {
        hideDropDownMenuFromVC(false)
        tableViewGymList.reloadData()
    }
    
    /**
     this func is used when user is subscribed to only 1 gym
     */
    func hideDropDownTableMenu() {
        hideDropDownMenuFromVC(true)
        /// if no gyms are present [practically this should not happen]
        if (postFeedBackViewModel.getGymArrayCount() > 0){
            textViewGymName.text = postFeedBackViewModel.getGymName(0)
            selectedGymID = postFeedBackViewModel.getGymID(0)
            isGymSelected = true
        }
    }
}
