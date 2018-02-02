//
//  ChangePasswordVC.swift
//  GymShim

import UIKit
import EZSwiftExtensions
protocol PasswordChangedSuccessfullyDelegate {
    func passwordChangedSuccessfully()
}

class ChangePasswordVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textFieldCurrentPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var skipButton: UIButton!
    
    var buttonShowPassword = UIButton()
    var fromLogin: Bool = false
    var buttonShowCurrentPassword = UIButton()
    var passwordChangedSuccessfullyDelegate: PasswordChangedSuccessfullyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        customiseChangePasswordScreen()
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.CHANGE_PASSWORD_SCREEN)
    }
    
    override func viewDidLayoutSubviews() {
        self.drawLineBelowTextFields()
    }
    
    /**
     If change password screen has appeared from login screen then remove back button and display toast successful else add back button
     */
    func customiseChangePasswordScreen() {
        if fromLogin {
            removeNavigationBackButton()
            CommonHelper().showToastMessageOn(self.view, message: ToastMessages.LOGIN_SUCCESSFUL)
        } else {
            addCustomiseBackButton()
        }
    }
    
    func configureNavigationBar() {
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBarHidden = false
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.hidesBackButton = fromLogin
        self.navigationItem.title = NavigationBarTitle.CHANGEPASSWORD
        view.backgroundColor = UIColor(hexValue:ColorHexValue.NAVIGATION_BAR)
        (fromLogin) ? (skipButton.hidden = false) : (skipButton.hidden = true)
    }
    
    // Draw line below text field
    func drawLineBelowTextFields() {
        CommonHelper().drawLineBelowTextField(textFieldCurrentPassword)
        CommonHelper().drawLineBelowTextField(textFieldNewPassword)
        constructToggleButton()
        constructToggleCurrentPasswordButton()
        
    }
    
    // Toggle button to show and hide password below function needs to be restructured and made in one common function
    func constructToggleButton() {
        buttonShowPassword.setImage(UIImage(named:ImageAssets.SHOW_PASSWORD), forState: UIControlState.Normal)
        buttonShowPassword.frame = CGRectMake(self.view.frame.size.width - 30, 0,CGFloat (UIButtonConstants.SHOW_PASSWORD_WIDTH), CGFloat(UIButtonConstants.SHOW_PASSWORD_HEIGHT))
        buttonShowPassword.contentEdgeInsets = UIEdgeInsetsMake(CGFloat(NumberConstant.SHOWPASSWORD_INSETS),CGFloat(NumberConstant.SHOWPASSWORD_INSETS), 0.0,0.0);
        buttonShowPassword.addTarget(self, action: #selector(ChangePasswordVC.buttonTogglePasswordTapped(_:) as (ChangePasswordVC) -> (UIButton!) -> ()), forControlEvents: .TouchUpInside)
        textFieldNewPassword.rightViewMode = UITextFieldViewMode.Always
        textFieldNewPassword.rightView = buttonShowPassword
    }
    
    // Toggle button to show and hide current password below function needs to be restructured and made in one common function
    func constructToggleCurrentPasswordButton() {
        buttonShowCurrentPassword.setImage(UIImage(named:ImageAssets.SHOW_PASSWORD), forState: UIControlState.Normal)
        buttonShowCurrentPassword.frame = CGRectMake(self.view.frame.size.width - 30, 0,CGFloat (UIButtonConstants.SHOW_PASSWORD_WIDTH), CGFloat(UIButtonConstants.SHOW_PASSWORD_HEIGHT))
        buttonShowCurrentPassword.contentEdgeInsets = UIEdgeInsetsMake(CGFloat(NumberConstant.SHOWPASSWORD_INSETS),CGFloat(NumberConstant.SHOWPASSWORD_INSETS), 0.0,0.0);
        buttonShowCurrentPassword.addTarget(self, action: #selector(ChangePasswordVC.buttonToggleCurrentPasswordTapped(_:) as (ChangePasswordVC) -> (UIButton!) -> ()), forControlEvents: .TouchUpInside)
        textFieldCurrentPassword.rightViewMode = UITextFieldViewMode.Always
        textFieldCurrentPassword.rightView = buttonShowCurrentPassword
    }
    
    //MARK:TextField Delegate Methods
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == textFieldCurrentPassword){
            textFieldNewPassword.becomeFirstResponder()
        } else {
            validateChangePasswordForm()
            textFieldNewPassword.resignFirstResponder()
        }
        return false
    }
    
    //MARK: Button click event
    /**
     toggle button to see password
     
     - parameter sender: button
     */
    func buttonTogglePasswordTapped(sender: UIButton!) {
        textFieldNewPassword.secureTextEntry = !textFieldNewPassword.secureTextEntry
        buttonShowPassword.setImage(UIImage(named: (textFieldNewPassword.secureTextEntry) ? ImageAssets.SHOW_PASSWORD : ImageAssets.HIDE_PASSWORD), forState: UIControlState.Normal)
    }
    
    //MARK: Button click event
    /**
     toggle button to see password for current password
     
     - parameter sender: button
     */
    func buttonToggleCurrentPasswordTapped(sender: UIButton!) {
        textFieldCurrentPassword.secureTextEntry = !textFieldCurrentPassword.secureTextEntry
        buttonShowCurrentPassword.setImage(UIImage(named: (textFieldCurrentPassword.secureTextEntry ) ? ImageAssets.SHOW_PASSWORD : ImageAssets.HIDE_PASSWORD), forState: UIControlState.Normal)
    }
    
    @IBAction func buttonSkip(sender: AnyObject) {
        NavigationHandler().changeRootViewToTabBarController(false)
    }
    
    @IBAction func buttonChangePassword(sender: AnyObject) {
        validateChangePasswordForm()
    }
    
    func validateChangePasswordForm() {
        callChangePasswordAPI()
    }
    
    func callChangePasswordAPI() {
        if !isValidString(textFieldCurrentPassword.text!) {
            CommonHelper().showToastMessageOn(view, message: ValidationConstants.ENTER_CURRENT_PASSWORD)
        } else if !isValidString(textFieldNewPassword.text!) {
            CommonHelper().showToastMessageOn(view, message: ValidationConstants.ENTER_NEW_PASSWORD)
        } else if (textFieldNewPassword.text?.characters.count < ValidationConstants.PASSWORD_LENGTH){
            CommonHelper().showToastMessageOn(view, message: ValidationConstants.ENTER_PASSWORD)
        }
        else{
            textFieldNewPassword.resignFirstResponder()
            callChangePasswordAPI(textFieldCurrentPassword.text!, newPassword: textFieldNewPassword.text!)
        }
    }
    
    //MARK: Navigation from ChangePassword VC
    func passwordChangedSuccessfully() {
        self.view.makeToast(ValidationConstants.PASSWORD_CHANGED, duration: ToastConstants.TOAST_TIME, position: .Center)
        NSThread.sleepForTimeInterval(NSTimeInterval(NumberConstant.FIVE))
        fromLogin ? changeRootViewAsTabbarController(fromLogin) : popToPreviousVC()
    }
    
    /**
     Change Root view controller to tabbar controller
     */
    func changeRootViewAsTabbarController(fromChangePassword: Bool) {
        NavigationHandler().changeRootViewToTabBarController(fromChangePassword)
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
        let backButton = UIBarButtonItem(image: UIImage(named: ImageAssets.BACK_ICON),  style: .Plain, target: self, action: #selector(ChangePasswordVC.popToPreviousVC))
        navigationItem.leftBarButtonItem = backButton
    }
    
    /// Remove BackButton from ChangePassword if Its From Login
    func removeNavigationBackButton() {
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
}
