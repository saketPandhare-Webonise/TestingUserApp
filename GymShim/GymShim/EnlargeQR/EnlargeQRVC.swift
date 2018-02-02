//
//  EnlargeQRVC.swift
//  GymShim

import Foundation
import EZSwiftExtensions

class EnlargeQRVC: UIViewController {
    @IBOutlet weak var imageViewQRCode: UIImageView!
    
    var membershipNumber: String = ""
    
    //MARK: View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUiSetup()
    }
    
    /// changes done to show layer below BtnActive for default case
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageViewQRCode.image = CommonHelper().generateQRCodeForText(membershipNumber)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let backButton = UIBarButtonItem(image: UIImage(named: ImageAssets.BACK_ICON),  style: .Plain, target: self, action: #selector(EnlargeQRVC.popToPreviousVC))
        navigationItem.leftBarButtonItem = backButton
    }
    
    /**
     Sets navigation bar, tabbar fields and delegates
     */
    func initialUiSetup() {
        self.navigationController?.navigationBar.tintColor = UIColor(hexValue: ColorHexValue.QR_CODE_TITLE_COLOR)
        self.navigationItem.title = NavigationBarTitle.QR_CODE
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.clipsToBounds = true
        addCustomiseBackButton()
    }
}
