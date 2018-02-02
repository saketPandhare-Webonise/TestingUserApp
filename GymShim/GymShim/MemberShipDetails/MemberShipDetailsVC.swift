//
//  MemberShipDetailsVC.swift
//  GymShim

import UIKit

class MemberShipDetailsVC: CustomNotificationController,UITableViewDelegate,UITableViewDataSource, MembershipDetailApiCallDelegate, CalendarSwipeDelegate{
    
    @IBOutlet weak var tableViewMembershipDetails: UITableView!
    var memberShipID:String = ""
    var memberShipDetailViewModel = MembershipDetailViewModel()
    var shouldCreateCalendar = Bool()
    var timerToShowLoader = NSTimer()
    var fromNotification: Bool = false
    var window: UIWindow?
    var notificationNumber: Int = 0
    var pooledViewSize: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shouldCreateCalendar = true
        hideNotificationButton()
        self.title = NavigationBarTitle.MY_MEMBERSHIP
        configureMembershipViewModel()
        callMemberShipDetailsWS()
        if (fromNotification) {
            memberShipDetailViewModel.notifyServerAboutNotificationViewed(notificationNumber)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.MEMBERSHIP_DETAILS_SCREEN)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// This method registers tablecell that needs to be dispalyed in tableview
    func configureTableViewCell() {
        tableViewMembershipDetails.delegate = self
        tableViewMembershipDetails.dataSource = self
        tableViewMembershipDetails.registerNib(UINib(nibName: TableCellIdentifiers.MEMBERSHIP_DETAILS_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.MEMBERSHIP_DETAILS_CELL)
        tableViewMembershipDetails.reloadData()
    }
    
    /// This func configures ViewModel for MembershipDetails
    func configureMembershipViewModel(){
        memberShipDetailViewModel.currentMonth(getCurrentMonth())
        memberShipDetailViewModel.currentYear(getCurrentYear())
        memberShipDetailViewModel.membershipDetailApiCallDelegate = self
    }
    
    /// This func is used to call WebSerive to display data in membershipdetails screen
    func callMemberShipDetailsWS() {
        memberShipDetailViewModel.getMemberShipDetails(self.memberShipID, month: memberShipDetailViewModel.getCurrentMonth(), year: memberShipDetailViewModel.getCurrentYear())
    }
    
    //MARK:Delegate Method
    
    /// Webservice Response received.When its for first time configure calendar ,when user swipes the calendar just reload tableView and calculate the count for attended,missed session
    func onSuccess() {
        (shouldCreateCalendar) ? configureTableViewCell() : tableViewMembershipDetails.reloadData()
    }
    
    //To-DO:
    /// Handle Error of webservice here
    func onFailure(error:String){
        print("Failure goes Here ")
    }
    
    /// This Delegate method is called when user Swipe or change the calendar month by click
    func relaodTableData() {
        self.callMemberShipDetailsWS()
    }
    
    /// func to show loader when user comes for the first time
    func showLoader() {
        WebserviceHandler().showActivityIndicator()
    }
    
    /// Currently in Testing
    override func goBack(){
        (fromNotification) ? navigateToHomeScreen() : popVC()
    }
    
    /// This function will navigate user back to feedback screen when user comes from notification screen ,this will set the navigation stack
    func navigateToHomeScreen() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let initialViewController = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TABBAR) as! TabbarViewController
        initialViewController.selectedIndex = TagBarTagConstants.HOMESCREEN
        initialViewController.tabBarItem.tag = TagBarTagConstants.HOMESCREEN
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        initialViewController.tabBar(initialViewController.tabBar, didSelectItem: initialViewController.tabBarItem)
        initialViewController.view .layoutIfNeeded()
    }
    
}
