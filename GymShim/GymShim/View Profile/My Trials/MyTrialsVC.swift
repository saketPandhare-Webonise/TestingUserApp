//
//  MyTrialsVC.swift
//  GymShim
//
import Foundation
import EZSwiftExtensions

class MyTrialsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var buttonUpcoming: UIButton!
    @IBOutlet var buttonPast: UIButton!
    @IBOutlet var tableViewMyTrials: UITableView!
    @IBOutlet var viewButtonBackground: UIView!
    
    var isUpcomingTapped: Bool = false
    var isPastTapped: Bool = false
    var arrayMyTrials = [GymTrials]()
    var sortedArrayMembership = [GymTrials]()
    var upComingTab: String = StringUtilsConstant.UPCOMING
    var pastTab: String = StringUtilsConstant.PAST
    var rowCount: Int = NumberConstant.ZERO
    let labelShowErrorMessage = UILabel()
    var trialID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.UPCOMING_TRIALS)
    }
    
    /**
     func to add undelying layer using autolayout
     */
    override func viewDidLayoutSubviews() {
        buttonUpcoming.layer.addSublayer(CommonHelper.setBorderToButtonBelow(buttonUpcoming, isSelected: true))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Setups view controller
     */
    func uiSetup() {
        isUpcomingTapped = true
        self.title = NavigationBarTitle.MY_TRIALS
        self.configureTableView()
        viewButtonBackground.backgroundColor = UIColor(hexValue:ColorHexValue.NAVIGATION_BAR)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.clipsToBounds = true
        addCustomiseBackButton()
        self.tabBarController?.tabBar.hidden = true
    }
    
    /**
     Configure Table view to display data
     */
    func configureTableView() {
        tableViewMyTrials.delegate = self
        tableViewMyTrials.dataSource = self
        tableViewMyTrials.registerNib(UINib(nibName: TableCellIdentifiers.TRIAL_TABLE_VIEW_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.TRIAL_TABLE_VIEW_CELL)
    }
    
    /**
     Pops to previous view controller
     */
    func popToPreviousVC() {
        popVC()
    }
    
    //MARK: Add back button
    /**
     Adds customise back button on the view controller
     */
    func addCustomiseBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: ImageAssets.BACK_ICON),  style: .Plain, target: self, action: #selector(MyTrialsVC.popToPreviousVC))
        navigationItem.leftBarButtonItem = backButton
    }
    
    //MARK: Button Actions over methods
    @IBAction func buttonUpcomingTapped(sender: UIButton) {
        isUpcomingTapped = true
        isPastTapped = false
        buttonPast.layer.addSublayer(CommonHelper.setBorderToButtonBelow(buttonPast, isSelected: false))
        buttonUpcoming.layer.addSublayer(CommonHelper.setBorderToButtonBelow(buttonUpcoming, isSelected: true))
        tableViewMyTrials.reloadData()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.UPCOMING_TRIALS)
    }
    
    @IBAction func buttonPastTapped(sender: UIButton) {
        isPastTapped = true
        isUpcomingTapped = false
        buttonUpcoming.layer.addSublayer(CommonHelper.setBorderToButtonBelow(buttonUpcoming, isSelected: false))
        buttonPast.layer.addSublayer(CommonHelper.setBorderToButtonBelow(buttonPast, isSelected: true))
        tableViewMyTrials.reloadData()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.PAST_TRIAL_SCREEN)
    }
}
