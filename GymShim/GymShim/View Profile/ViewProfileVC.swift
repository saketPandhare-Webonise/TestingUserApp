//
//  ViewProfileVC.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions

class ViewProfileVC: CustomNotificationController, ApiCallDelegate, EditApiCallDelegate,UITabBarDelegate,UITabBarControllerDelegate, LogoutDelegate, PasswordChangedSuccessfullyDelegate  {
    @IBOutlet var tableViewMyProfile: UITableView!
    
    var viewProfileViewModel: ViewProfileViewModel?
    var userDetails: UserDetails = UserDetails()
    var arrayGymMembership = [GymMembership]()
    var isEditCalled: Bool = false
    var arrayGymTrials = [GymTrials]()
    var tabbarController = UITabBarController()

    //MARK: View cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbarController.delegate = self
        hideBackButton()
        registerTableViewNibs()
        configureTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        customiseNavigationBar()
        addLogoAsNavigationTitle()
        viewProfileViewModel = ViewProfileViewModel()
        viewProfileViewModel?.apiCallDelegate = self
        viewProfileViewModel?.viewProfileApiCall(userLoginToken)
        viewProfileViewModel?.logoutDelegate = self
        registerForNotificationToUpdateBadgeCount()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.PROFILE_SCREEN)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBarHidden = false
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

     /**
     Customises navigation bar
     */
    func customiseNavigationBar() {
        self.navigationController!.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(hexValue:ColorHexValue.NAVIGATION_BAR)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = false
    }
    
    /**
     Registers nib of my profile table view
     */
    func registerTableViewNibs() {
        tableViewMyProfile.registerNib(UINib(nibName: TableCellIdentifiers.USER_DETAILS_TABLE_VIEW_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.USER_DETAILS_TABLE_VIEW_CELL)
        tableViewMyProfile.registerNib(UINib(nibName: TableCellIdentifiers.LOGOUT_TABLE_VIEW_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.LOGOUT_TABLE_VIEW_CELL)
        tableViewMyProfile.registerNib(UINib(nibName: TableCellIdentifiers.MEMBERSHIP_TABLE_VIEW_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.MEMBERSHIP_TABLE_VIEW_CELL)
        tableViewMyProfile.registerNib(UINib(nibName: TableCellIdentifiers.MY_TRIALS_VIEW_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.MY_TRIALS_VIEW_CELL)
    }
    
    /*
     Sets delegate and data source objects of tableview
     */
    func configureTableView() {
        tableViewMyProfile.estimatedRowHeight = CGFloat(NumberConstant.ESTIMATED_ROW_HEIGHT)
    }
    
    //MARK: Delegate methods of ApiCAllDelegate
    func onSuccess() {
        userDetails = (viewProfileViewModel?.getUserDetailsObject())!
        
        arrayGymMembership = (viewProfileViewModel?.userProfileModel.user.arrayMyMembership)!
        arrayGymTrials = (viewProfileViewModel?.getMyTrialsArray())!
        tableViewMyProfile.delegate = self
        tableViewMyProfile.dataSource = self
        dispatch_async(dispatch_get_main_queue()) {
            self.tableViewMyProfile.reloadData()
        }
    }
    
    func onFailure(error : String){
        CommonHelper().showToastMessageOn(self.view, message: error)
    }
    
    /**
     clear userSaved data
     */
    func clearSavedData() {
        self.tableViewMyProfile.reloadData()
        // clears authentication token of user
        let savedToken = NSUserDefaults.standardUserDefaults()
        savedToken.removeObjectForKey(UserDefaultConstants.TOKEN)
        isDeviceTokenRegistered = false
        userRegistrationID = StringUtilsConstant.EMPTY_STRING
        NavigationHandler().changeRootToLoginVC(false, islogOutClicked: true)
    }
    
    //MARK: Edit Image Api delegate
    func editImageAPI() {
        CommonHelper().showToastMessageOn(self.view, message: ToastMessages.PROFILE_UPDATED_SUCCESSFULLY)
        isEditCalled = true
    }
    
    func passwordChangedSuccessfully() {
        CommonHelper().showToastMessageOn(self.view, message: ToastMessages.CHANGE_PASSWORD_SUCCESSFUL_MESSAGE)
    }
}
