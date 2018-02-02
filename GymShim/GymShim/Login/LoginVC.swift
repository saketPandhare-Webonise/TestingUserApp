//
//  LoginVC.swift
//  GymShim

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate, DelegateForgotPassword {
    @IBOutlet weak var scrollViewLogin: UIScrollView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    var webserviceHandler = WebserviceHandler()
    var isTokenExpired = Bool()
    var isLogOutClicked = Bool()
    var buttonShowPassword = UIButton()
    var window: UIWindow?
    
    //MARK: View Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
        // Below condition to show proper error message coming from different scrrens
        if (isTokenExpired) {
            showToastForInvalidToken()
        }
        if (isLogOutClicked) {
            showToastForLogOut()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.LOGIN_SCREEN)
    }
    
    override func viewDidLayoutSubviews(){
        self.drawLineBelowTextFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawLineBelowTextFields (){
        CommonHelper().drawLineBelowTextField(textFieldPassword)
        CommonHelper().drawLineBelowTextField(textFieldEmail)
        constructToggleButton()
    }
    
    // toggle Button To show and Hide password
    func constructToggleButton (){
        buttonShowPassword.setImage(UIImage(named:ImageAssets.SHOW_PASSWORD), forState: UIControlState.Normal)
        buttonShowPassword.frame = CGRectMake(self.view.frame.size.width - CGFloat(UIButtonConstants.SHOW_PASSWORD_BUTTON_X), CGFloat(UIButtonConstants.SHOW_PASSWORD_BUTTON_Y),CGFloat (UIButtonConstants.SHOW_PASSWORD_WIDTH), CGFloat(UIButtonConstants.SHOW_PASSWORD_HEIGHT))
        buttonShowPassword.contentEdgeInsets = UIEdgeInsetsMake(CGFloat(NumberConstant.SHOWPASSWORD_INSETS),CGFloat(NumberConstant.SHOWPASSWORD_INSETS), 0.0,0.0);
        buttonShowPassword.addTarget(self, action: #selector(LoginVC.buttonTogglePasswordTapped(_:) as (LoginVC) -> (UIButton!) -> ()), forControlEvents: .TouchUpInside)
        textFieldPassword.rightViewMode = UITextFieldViewMode.Always
        textFieldPassword.rightView = buttonShowPassword
    }
    
    /**
     toggle button to see password
     
     - parameter sender: button
     */
    func buttonTogglePasswordTapped(sender: UIButton!) {
        textFieldPassword.secureTextEntry = !textFieldPassword.secureTextEntry
        buttonShowPassword.setImage(UIImage(named: (textFieldPassword.secureTextEntry) ? ImageAssets.SHOW_PASSWORD : ImageAssets.HIDE_PASSWORD), forState: UIControlState.Normal)
    }
    
    //MARK:Login Button Action
    @IBAction func buttonLogin(sender: AnyObject){
        validateLoginForm()
    }
    
    /// This func validated form data
    func validateLoginForm() {
        callLoginAPI()
    }
    
    /// This function validates data and call Login API
    func callLoginAPI() {
        if (!isValidString(textFieldEmail.text!) && !isValidString(textFieldPassword.text!)) {
            CommonHelper().showToastMessageOn(view, message: ValidationConstants.ENTER_ALL_CREDENTIALS)
        } else if (isValidEmailAddress(textFieldEmail.text!) || isValidatePhoneNo(textFieldEmail.text!)) && !isValidString(textFieldPassword.text!) {
            CommonHelper().showToastMessageOn(view, message: ValidationConstants.EMPTY_PASSWORD)
        } else if !isValidEmailAddress(textFieldEmail.text!) && !isValidatePhoneNo(textFieldEmail.text!) {
            CommonHelper().showToastMessageOn(view, message: ValidationConstants.ENTER_PROPER_EMAIL_PHONENO)
        } else {
            callloginAPI(textFieldEmail.text!, password:textFieldPassword.text!)
        }
    }
    
    func changeRootViewController() {
        let userInfo = NSUserDefaults.standardUserDefaults()
        ((userInfo[UserDefaultConstants.IS_REST_PASSWORD]?.boolValue) == false ) ? navigateToChangePasswordScreen(): NavigationHandler().changeRootViewToTabBarController(false)
    }
    
    //MARK: Textfield Delegates
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {  //delegate method
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == textFieldEmail {
            textFieldPassword.becomeFirstResponder()
        } else {
            validateLoginForm()
            textFieldPassword.resignFirstResponder()
        }
        return false
    }
    
    //MARK: Navigation From LoginVC To different Screens
    func navigateToChangePasswordScreen() {
        let changePassword = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.CHANGEPASSWORD) as! ChangePasswordVC
        changePassword.fromLogin = true
        self.navigationController?.pushViewController(changePassword, animated: true)
    }
    
    @IBAction func buttonForgotPasswordTapped(sender: UIButton) {
        let forgotPassword = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.FORGOT_PASSWORD_VC) as! ForgotPasswordVC
        forgotPassword.delegateForGotPassword = self
        presentVC(forgotPassword)
    }
    
    //MARK: Invalid Token delegate
    func showToastForInvalidToken(){
        isTokenExpired = false
        CommonHelper.clearSavedData()
        CommonHelper().showToastMessageOn(self.view, message: ToastMessages.WRONG_TOKEN)
    }
    
    /// this toast message is shown when user clicks logout
    func showToastForLogOut() {
        CommonHelper().showToastMessageOn(self.view, message: ToastMessages.LOGOUT_MESSAGE)
    }
    
    /// this toast message is shown when successful mail is send for forgot password
    func delegateForgotPassword(email: String) {
        self.view.makeToast(WebServiceErrors.FP_MAIL_SENT + email, duration: ToastConstants.TOAST_TIME, position: .Center)
    }
}
