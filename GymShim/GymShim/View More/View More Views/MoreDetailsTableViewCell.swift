//
//  MoreDetailsTableViewCell.swift
//  GymShim
//

import UIKit
import ResponsiveLabel
import EZSwiftExtensions

class MoreDetailsTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableViewMoreDetails: UITableView!
    @IBOutlet var viewMoreDetails: UIView!
    
    var viewMoreVC: ViewMoreVC?
    var labelAboutGymNumberofLines: Int = 2
    var aboutGymHeightIphone5: CGFloat = 220
    var aboutGymHeightIphone6: CGFloat = 150
    
    
    enum MoreDetailsTableCells: Int {
        case aboutGS = 0
        case privacyPolicy
        case termsAndConditions
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerTableViewNibs()
        configureTableView()
        CommonHelper.addShadowToView(viewMoreDetails)
    }
    
    /**
     Sets delegate datasource of tablview
     */
    func configureTableView() {
        tableViewMoreDetails.delegate = self
        tableViewMoreDetails.dataSource = self
    }
    
    /**
     Registers nib of my profile table view
     */
    func registerTableViewNibs() {
        tableViewMoreDetails.registerNib(UINib(nibName: TableCellIdentifiers.ABOUT_GYMSHIM_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.ABOUT_GYMSHIM_TABLE_CELL)
        tableViewMoreDetails.registerNib(UINib(nibName: TableCellIdentifiers.PRIVACY_POLICY_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.PRIVACY_POLICY_TABLE_CELL)
    }
    
    //MARK:TableViewDelegate Delegate Method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumberConstant.THREE
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case MoreDetailsTableCells.aboutGS.rawValue:
            return CGFloat(TableCellHeight.ABOUT_US_HEIGHT) + viewMoreVC!.aboutGymExpandHeight
        case MoreDetailsTableCells.privacyPolicy.rawValue:
            return UITableViewAutomaticDimension
        case MoreDetailsTableCells.termsAndConditions.rawValue:
            return UITableViewAutomaticDimension
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case MoreDetailsTableCells.aboutGS.rawValue:
            return constructAboutGSTableCell(tableViewMoreDetails, indexPath: indexPath)
        case MoreDetailsTableCells.privacyPolicy.rawValue:
            return constructPrivacyPolicyTableCell(tableViewMoreDetails, indexPath: indexPath)
        case MoreDetailsTableCells.termsAndConditions.rawValue:
            return constructTermsOfServiceTableCell(tableViewMoreDetails, indexPath: indexPath)
        default:
            return constructTermsOfServiceTableCell(tableViewMoreDetails, indexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case MoreDetailsTableCells.aboutGS.rawValue: break
    
        case MoreDetailsTableCells.privacyPolicy.rawValue:
            Analytics.trackScreenByGoogleAnalytic(ScreenNames.PRIVACY_POLICY_SCREEN)
            pushWebViewVC(NavigationBarTitle.PRIVACY_POLICY, url: WebServiceUrls.PRIVACY_POLICY())
        case MoreDetailsTableCells.termsAndConditions.rawValue:
            Analytics.trackScreenByGoogleAnalytic(ScreenNames.TERMS_OF_USE_SCREEN)
            pushWebViewVC(NavigationBarTitle.TERMS_OF_SERVICE, url: WebServiceUrls.TERMS_OF_USE())
        default:
            pushWebViewVC(NavigationBarTitle.PRIVACY_POLICY, url: StringUtilsConstant.TEMPORARY_URL)
        }
    }
    
    /// Construct About us That needs to be diaplyed on FeedbackTable View
    ///
    /// - parameter tableView: tableView on which cell is to be constructed
    /// - parameter indexPath: indeXpath of tableview
    ///
    /// - returns: constructed cell
    func constructAboutGSTableCell(tableView: UITableView, indexPath:NSIndexPath) -> UITableViewCell {
        let aboutGymshimTableViewCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.ABOUT_GYMSHIM_TABLE_CELL) as! AboutGymshimTableViewCell
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(aboutGymShimClicked(_:)))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        aboutGymshimTableViewCell.labelAboutGymShim.userInteractionEnabled = true
        aboutGymshimTableViewCell.labelAboutGymShim.tag = indexPath.row
        aboutGymshimTableViewCell.labelAboutGymShim.addGestureRecognizer(tapGesture)
        aboutGymshimTableViewCell.labelAboutGymShim.numberOfLines = labelAboutGymNumberofLines
        return aboutGymshimTableViewCell
    }
    
    /// This function will decide height for cell in AboutGymShim section depending on device width,UITableViewAutomaticDimension is not used because for the first time we have to show 2 lines and if we used so it will increase looping in heightForRowAtIndexPath ,so cell height is calculated depending on device type
    ///
    /// - parameter tapGesture: tapGesture
    func aboutGymShimClicked(tapGesture:UITapGestureRecognizer) {
        if (self.window?.frame.width == CGFloat(Devicetype.iPhone5)) {
            viewMoreVC!.aboutGymExpandHeight = aboutGymHeightIphone5
        }
        else if (self.window?.frame.width == CGFloat(Devicetype.iPhone6)){
            viewMoreVC!.aboutGymExpandHeight = aboutGymHeightIphone6
        }
        else {
             viewMoreVC!.aboutGymExpandHeight = aboutGymHeightIphone6
        }
        labelAboutGymNumberofLines = 0
        viewMoreVC?.tableViewMore.reloadData()
        tableViewMoreDetails.reloadData()
    }
    
    
    /// Constructs privacy policy cell
    ///
    /// - parameter tableView: tableview for which cell is to be constructed
    /// - parameter indexPath: indexpath of the cell
    ///
    /// - returns: constructed cell for privacy policy
    func constructPrivacyPolicyTableCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let privacyPolicyTableViewCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.PRIVACY_POLICY_TABLE_CELL) as! PrivacyPolicyTableViewCell
        return privacyPolicyTableViewCell
    }
    
    /// Constructs terms of service cell
    ///
    /// - parameter tableView: tableview on which terms of service is to be constructed
    /// - parameter indexPath: indexpath of the cell
    ///
    /// - returns: constructed cell
    func constructTermsOfServiceTableCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let privacyPolicyTableViewCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.PRIVACY_POLICY_TABLE_CELL) as! PrivacyPolicyTableViewCell
        privacyPolicyTableViewCell.labelPrivacyPolicy.text = StringUtilsConstant.TERMS_OF_SERVICE
        privacyPolicyTableViewCell.imageViewMore.image = UIImage(named: ImageAssets.TERMS_OF_SERVICE)
        return privacyPolicyTableViewCell
    }
    
    /// Push Web View controller and passes title and url to it.
    ///
    /// - parameter title: title of navigation bar of web View VC
    /// - parameter url:   url to be loaded on webview
    func pushWebViewVC(title: String, url: String) {
        let storyboard = UIStoryboard.mainStoryboard
        let webViewVC = storyboard!.instantiateVC(WebViewVC)
        webViewVC?.navigationTitle = title
        webViewVC?.webViewUrl = url
        viewMoreVC?.navigationController?.pushViewController(webViewVC!, animated: false)
    }
}
