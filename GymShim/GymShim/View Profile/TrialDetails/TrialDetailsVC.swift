//
//  TrialDetailsVC.swift
//  GymShim

import UIKit

class TrialDetailsVC: CustomNotificationController, UITableViewDelegate, UITableViewDataSource, ShowTrialData{
    
    @IBOutlet weak var tableViewTrialDetails: UITableView!
    var trialDetailViewModel = TrialDetailsViewModel()
    var window: UIWindow?
    var trialID: Int = 0
    var notificationNumber: Int = 0
    var fromNotification: Bool = false
    var fromNotificationListingScreen: Bool = false 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetUp()
    }
    
    override func viewWillAppear(animated: Bool) {
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.TRIAL_DETAILS_SCREEN)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///UI Setup of view and webservice Call to get trial data
    func uiSetUp() {
        trialDetailViewModel.getTrialInfoFromNotification(trialID)
        trialDetailViewModel.notifyServerAboutNotificationViewed(notificationNumber)
        trialDetailViewModel.showTrialDataDelegate = self
        self.title = NavigationBarTitle.UPCOMING_TRIALS
        hideNotificationButton()
    }
    
    /**
     Configure Table view to display data
     */
    func configureTableView() {
        tableViewTrialDetails.delegate = self
        tableViewTrialDetails.dataSource = self
        tableViewTrialDetails.registerNib(UINib(nibName: TableCellIdentifiers.TRIAL_TABLE_VIEW_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.TRIAL_TABLE_VIEW_CELL)
    }
    
    /// method overridden to go back to profile screen
    override func goBack() {
        (fromNotificationListingScreen) ? popVC() : navigateToProfileScreen()
    }
    
    /// This function will navigate user back to feedback screen when user comes from notification screen ,this will set the navigation stack
    func navigateToProfileScreen() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard.mainStoryboard
        let initialViewController = storyboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.TABBAR) as! TabbarViewController
        initialViewController.selectedIndex = TagBarTagConstants.PROFILE
        initialViewController.tabBarItem.tag = TagBarTagConstants.PROFILE
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        initialViewController.tabBar(initialViewController.tabBar, didSelectItem: initialViewController.tabBarItem)
        initialViewController.view .layoutIfNeeded()
    }
    
    /// delegate method after receiving data from webservice
    func relaodTrailTableViewAndNotifyServer() {
        configureTableView()
        tableViewTrialDetails.reloadData()
        WebserviceHandler().notifyServerNotificationViewed(notificationNumber)
    }
}
