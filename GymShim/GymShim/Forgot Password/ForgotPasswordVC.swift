//
//  ForgotPasswordVC.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions

protocol DelegateForgotPassword {
    func delegateForgotPassword(email: String)
}

class ForgotPasswordVC: UIViewController, ShowSuccessMessage, ShowErrorMessage, UITextFieldDelegate {
    @IBOutlet var textFieldEmail: UITextField!
    
    var delegateForGotPassword = DelegateForgotPassword?()
    let forgotPasswordAPI = ForgotPasswordAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldEmail.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.FORGOT_PASSWORD_SCREEN)
    }
    
    override func viewDidLayoutSubviews(){
        CommonHelper().drawLineBelowTextField(self.textFieldEmail)
    }

    //MARK: button handlers for send reset link
    @IBAction func buttonSendResetLinkTapped(sender: AnyObject) {
        validateForgotPasswordForm()
    }
    
    /// This func validate form data
    func validateForgotPasswordForm() {
         callForgotPasswordAPI()
    }
    
    /// API Call for Forgot password 
    func callForgotPasswordAPI() {
        if !isValidEmailAddress(self.textFieldEmail.text!.trim()) {
            CommonHelper().showToastMessageOn(view, message: ValidationConstants.ENTER_PROPER_EMAIL)
        } else {
            self.resetPassword(self.textFieldEmail.text!)
        }
    }
  
    @IBAction func buttonCancelTapped(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    /**
     reset password flow
     
     - parameter email: email
     */
    func resetPassword(email: String){
        forgotPasswordAPI.showSuccessMessageDelegate = self
        forgotPasswordAPI.errorMessageDelegate = self
        forgotPasswordAPI.forgotPassword(email, view:view)
    }
    
    /**
     delegate method from forgot password API Call
     */
    func resetPasswordMailSend(email: String) {
        delegateForGotPassword?.delegateForgotPassword(email)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func errorSendingMail() {
        self.view.makeToast(WebServiceErrors.ERROR_SENDING_MAIL, duration: ToastConstants.TOAST_TIME, position: .Center)
    }
    
    //MARK: Textfield delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        validateForgotPasswordForm()
        return false
    }
}
