//
//  HomeScreenVC.swift
//  GymShim


import UIKit


class HomeScreenVC: CustomNotificationController,UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var tableViewActiveMemberships: UITableView!
   
    var errorLableHeight: CGFloat = 75 
    var userNameCellHeight: CGFloat = 65
    var membershipCellHeight: CGFloat = 230
    var qrCodeImage = UIImage()
    var overlay = UIView()
    var homeScreenDataModel: HomeScreenModel = HomeScreenModel()
    
    let lblShowErrorMessage = UILabel()
    let tableViewSectionCount: Int = 3
    let SECTION_HEADER_HEIGHT_MEMEBRSHIP : CGFloat = 30
    let MINIMUM_SECTION_HEADER_FOOTER_HEIGHT : CGFloat = 1
    let FOOTER_HEIGHT_FOR_LAST_SECTION :CGFloat = 20
    let HEADER_TITLE_ACTIVE_MEMBERSHIPS = "ACTIVE MEMBERSHIPS"
    let HEADER_TITLE_TRIALS = "TRIALS"
    let NUMBER_OF_USER_CELL = 1
    let ERROR_LABEL_HEIGHT = 100
    let ERROR_LABEL_LINES = 2
    let MULTYPING_CONSTANT_INDEXPATH = 1000
    
    enum HomeScreenTableCells : Int {
        case userNameCell = 0,memberShipCell = 1,trialsCell = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBackButton()
        lblShowErrorMessage.hidden = true
        addLogoAsNavigationTitle()
        configureTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
        registerForNotificationToUpdateBadgeCount()
        getUserActiveMemberShips()
        /// if device is not registered to recieve Notification ,check here and register the same
        if (!isDeviceTokenRegistered && !deviceToken.isEmpty){
            registerUserForNotification(userLoginToken)
        }
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.HOME_SCREEN)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Add observer to update Notification Badge
    func registerForNotificationToUpdateBadgeCount() {
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self,
                                 selector: #selector(checkForBadgeCount),
                                 name: NotificationConstant.UPDATE_BADGE_NOTIFICATION,
                                 object: nil)
    }
    
    /// Configure Table view to display data
    func configureTableView() {
        tableViewActiveMemberships.delegate = self
        tableViewActiveMemberships.dataSource = self
        tableViewActiveMemberships.registerNib(UINib(nibName: TableCellIdentifiers.HOME_MEMBERSHIP_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.HOME_MEMBERSHIP_CELL)
        tableViewActiveMemberships.registerNib(UINib(nibName: TableCellIdentifiers.USERNAME_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.USERNAME_CELL)
         tableViewActiveMemberships.registerNib(UINib(nibName: TableCellIdentifiers.UPCOMING_TRAIL_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.UPCOMING_TRAIL_TABLE_CELL)
    }
    
    //MARK:- UIPopoverPresentationControllerDelegate method
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        removeOverLay()
        return true
    }
}
