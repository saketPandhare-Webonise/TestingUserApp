//
//  MyMembershipVC.swift
//  GymShim


import UIKit

class MyMembershipVC: CustomNotificationController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnPast: UIButton!
    @IBOutlet weak var tableViewMyMemberships: UITableView!
    @IBOutlet weak var viewButtonBackground: UIView!
    var upcomingTabCliced:Bool = false
    var activityTabClicked:Bool = false
    var pastTabClicked:Bool = false
    var arrayMyMembership = [GymMembership]()
    var sortedArrayMembership = [GymMembership]()
    var upComingTab:String = "upcoming"
    var activeTab:String = "active"
    var pastTab:String = "past"
    var rowCount:Int = 0
    let lblShowErrorMessage = UILabel()
    let membershipCellHeight : CGFloat = 138
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNotificationButton()
        activityTabClicked = true
        self.title = NavigationBarTitle.MY_MEMBERSHIP
        self.configureTableView()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.clipsToBounds = true
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.ACTIVE_MEMBERSHIP_SCREEN)
    }

    /// func to add undelying layer using autolayout
    override func viewDidLayoutSubviews() {
        viewButtonBackground.backgroundColor = UIColor(hexValue:ColorHexValue.NAVIGATION_BAR)
    }
    
    /// changes done to show layer below BtnActive for default case
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(activityTabClicked) {
        btnActive.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnActive, isSelected: true))
        }
    }
    
    /// Configure Table view to display data
    func configureTableView() {
        tableViewMyMemberships.delegate = self
        tableViewMyMemberships.dataSource = self
        tableViewMyMemberships.registerNib(UINib(nibName: TableCellIdentifiers.MEMBERSHIPCELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.MEMBERSHIPCELL)
    }
    
    //MARK: Button Actions over methods
    @IBAction func buttonUpcoming(sender: AnyObject) {
        upcomingTabCliced = true
        activityTabClicked = false
        pastTabClicked = false
        btnUpcoming.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnUpcoming, isSelected: true))
        btnActive.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnActive, isSelected: false))
        btnPast.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnPast, isSelected: false))
        tableViewMyMemberships.reloadData()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.UPCOMING_MEMBERSHIP_SCREEN)
    }
    
    @IBAction func buttonActive(sender: AnyObject) {
        activityTabClicked = true
        upcomingTabCliced = false
        pastTabClicked = false
        btnActive.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnActive, isSelected: true))
        btnUpcoming.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnUpcoming, isSelected: false))
        btnPast.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnPast, isSelected: false));
        tableViewMyMemberships.reloadData()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.ACTIVE_MEMBERSHIP_SCREEN)
    }
    
    @IBAction func buttonPast(sender: AnyObject) {
        pastTabClicked = true
        upcomingTabCliced = false
        activityTabClicked = false
        btnPast.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnPast, isSelected: true))
        btnUpcoming.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnUpcoming, isSelected: false))
        btnActive.layer.addSublayer(CommonHelper.setCustomColorToButtonBelow(btnActive, isSelected: false));
        tableViewMyMemberships.reloadData()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.PAST_MEMBERSHIP_SCREEN)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
