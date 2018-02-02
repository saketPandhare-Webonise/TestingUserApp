//
//  ViewMoreVC.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions

class ViewMoreVC: CustomNotificationController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableViewMore: UITableView!
    
    var viewMoreViewModel:ViewMoreViewModel?
    var aboutGymExpandHeight: CGFloat = 0
    var initialAboutGymShimNumberOfLines: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        registerTableViewNibs()
        configureTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewMore.reloadData()
        self.tabBarController?.tabBar.hidden = false
        registerForNotificationToUpdateBadgeCount()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.MORE_SCREEN)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        aboutGymExpandHeight = 0
    }
    
    //Add observer to update Notification Badge
    func registerForNotificationToUpdateBadgeCount() {
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self,
                                 selector: #selector(checkForBadgeCount),
                                 name: NotificationConstant.UPDATE_BADGE_NOTIFICATION,
                                 object: nil)
    }
    
    /**
     UISetup for view more
     */
    func uiSetup() {
        hideBackButton()
        addLogoAsNavigationTitle()
        viewMoreViewModel = ViewMoreViewModel()
    }
    
    /**
     Sets delegate datasource of tablview
     */
    func configureTableView() {
        tableViewMore.delegate = self
        tableViewMore.dataSource = self
    }
    
    /**
     Registers nib of my profile table view
     */
    func registerTableViewNibs() {
        tableViewMore.registerNib(UINib(nibName: TableCellIdentifiers.MORE_DETAILS_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.MORE_DETAILS_TABLE_CELL)
        tableViewMore.registerNib(UINib(nibName: TableCellIdentifiers.PN_SETTING_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.PN_SETTING_TABLE_CELL)
    }
}
