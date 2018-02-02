//
//  EditProfileVC.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions
import IQKeyboardManagerSwift

// delegate to clear cache for profile image
protocol EditApiCallDelegate {
    func editImageAPI()
}

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, NavigateToProfileDelegate, RemovePhotoDelegate {
    @IBOutlet var scrollViewEditProfile: UIScrollView!
    @IBOutlet var imageViewUserProfile: UIImageView!
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldMobile: UITextField!
    @IBOutlet var textFieldAnniversaryDate: UITextField!
    @IBOutlet var textFieldBirthDate: UITextField!
    @IBOutlet var buttonEditPhoto: UIButton!
    
    var userDetails: UserDetails?
    var isProfilePicUpdated: Bool = false
    var imagePicker = UIImagePickerController()
    var editProfileApi = EditProfileApi()
    var editApiCallDelegate: EditApiCallDelegate?
    var addPhoto: Bool = false
    var datePicker: UIDatePicker?
    var toolBar : UIToolbar?
    var fromEditProfile: Bool = true
    
    //MARK: View Controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        initialUiSetup()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if fromEditProfile {
            fromEditProfile = false
            let title: String = userDetails?.avatar?.characters.count > NumberConstant.ZERO ? StringUtilsConstant.EDIT_PHOTO : StringUtilsConstant.ADD_PHOTO
            buttonEditPhoto.setTitle(title, forState: .Normal)
        } else {
            let title: String = isAvatarPresent ? StringUtilsConstant.EDIT_PHOTO : StringUtilsConstant.ADD_PHOTO
            buttonEditPhoto.setTitle(title, forState: .Normal)
        }
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.EDIT_PROFILE_SCREEN)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        self.drawLineBelowTextFields()
        CommonHelper().makeImageRound(imageViewUserProfile)
    }
    
    /**
     Sets navigation bar, tabbar fields and delegates
     */
    func initialUiSetup() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = NavigationBarTitle.EDIT_PROFILE
        self.tabBarController?.tabBar.hidden = true
        addCustomiseBackButton()
        isProfilePicUpdated = false
        imagePicker.delegate = self
        setUserInformation()
        setTextFieldTags()
        setTextFieldDelegates()
        self.navigationController?.navigationBar.barTintColor = UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
        view.backgroundColor = UIColor(hexValue:ColorHexValue.NAVIGATION_BAR)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    
    /**
     Draw line below textfields
     */
    func drawLineBelowTextFields() {
        CommonHelper().drawLineBelowTextField(textFieldEmail)
        CommonHelper().drawLineBelowTextField(textFieldMobile)
        CommonHelper().drawLineBelowTextField(textFieldBirthDate)
        CommonHelper().drawLineBelowTextField(textFieldAnniversaryDate)
    }
    
    /**
     On Button add photo it opens action sheet with displayed options of adding photo through gallery,camera
     */
    @IBAction func buttonAddPhotoClicked(sender: AnyObject) {
        let actionSheetChangePhoto = UIAlertController(title: nil, message: ActionSheetConstant.CHOOSE_OPTIONS, preferredStyle: .ActionSheet)
        let deleteAction = UIAlertAction(title:ActionSheetConstant.GALLERY, style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openGallery()
        })
        let saveAction = UIAlertAction(title:ActionSheetConstant.CAMERA, style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openCamera()
        })
        let removePhoto = UIAlertAction(title:ActionSheetConstant.REMOVE_PHOTO, style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            self.removePhoto()
        })
        let cancelAction = UIAlertAction(title:ActionSheetConstant.CANCEL, style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        actionSheetChangePhoto.addAction(removePhoto)
        actionSheetChangePhoto.addAction(deleteAction)
        actionSheetChangePhoto.addAction(saveAction)
        actionSheetChangePhoto.addAction(cancelAction)
        self.presentViewController(actionSheetChangePhoto, animated: true, completion: nil)
    }
    
    @IBAction func buttonSaveChangesClicked(sender: UIButton) {
        if isValidUserProfile() {
            editProfileApi.navigationDelegate = self
            callEditProfileWebService()
        }
    }
    
    /**
     Cals edit profile web service
     */
    func callEditProfileWebService() {
        if isProfilePicUpdated {
            let image = imageViewUserProfile.image
            isProfilePicUpdated = false
            editProfileApi.callWebServiceForEditProfileWithImage(textFieldEmail.text!.trim(), mobile: textFieldMobile.text!.trim(), dob: textFieldBirthDate.text!.trim(), doa: textFieldAnniversaryDate.text!.trim(), id: (userDetails?.profileId)!, image: image!)
        } else {
            editProfileApi.callEditProfileApiWithoutImage(textFieldEmail.text!.trim(), mobile: textFieldMobile.text!.trim(), dob: textFieldBirthDate.text!.trim(), doa: textFieldAnniversaryDate.text!.trim(), id: (userDetails?.profileId)!)
        }
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
        let backButton = UIBarButtonItem(image: UIImage(named: ImageAssets.BACK_ICON),  style: .Plain, target: self, action: #selector(EditProfileVC.popToPreviousVC))
        navigationItem.leftBarButtonItem = backButton
    }
    
    /**
     Sets user default information and assigns textfield delegates
     */
    func setUserInformation() {
        textFieldEmail.text = self.userDetails?.email
        textFieldMobile.text = self.userDetails?.mobileNo
        textFieldBirthDate.text = self.userDetails?.dob
        textFieldAnniversaryDate.text = self.userDetails?.anniversaryDate
        ImageUtility.setAsyncImage(imageViewUserProfile!, imageUrl: (userDetails?.avatar)!, defaultImageName: ImageAssets.USERDEFAULT_IMAGE, completionBlock: nil)
    }
    
    /**
     Sets textfield delegates
     */
    func setTextFieldDelegates() {
        textFieldMobile.delegate = self
        textFieldEmail.delegate = self
        textFieldBirthDate.delegate = self
        textFieldAnniversaryDate.delegate = self
    }
    
    /**
     assigns tags to textfields
     */
    func setTextFieldTags() {
        textFieldEmail.tag = NumberConstant.ONE
        textFieldMobile.tag = NumberConstant.TWO
        textFieldBirthDate.tag = NumberConstant.THREE
        textFieldAnniversaryDate.tag = NumberConstant.FOUR
    }
    
    /**
     Removes profile photo of user from his profile details.
     */
    func removePhoto() {
        self.addPhoto = false
        editProfileApi.removePhotoDelegate = self
        self.imageViewUserProfile.image = UIImage(named: ImageAssets.USERDEFAULT_IMAGE)
        self.editProfileApi.callApiForRemoveProfilePhoto()
    }

    /**
     Opens gallery of phone
     */
    func openGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    /**
     Opens camera of phone
     */
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
            isProfilePicUpdated = true
            addPhoto = true
            isAvatarPresent = true
        } else {
            let alert = UIAlertController(title:ActionSheetConstant.NO_CAMERA, message: ActionSheetConstant.NO_CAMERA_FOR_DEVICE, preferredStyle: .Alert)
            let ok = UIAlertAction(title: ActionSheetConstant.OK
                , style:.Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: Image picker delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            isProfilePicUpdated = true
            addPhoto = true
            isAvatarPresent = true
            imageViewUserProfile.image = ImageUtility.getFlipImage((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
        } else {
            print("Something went wrong")
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Text Field Delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField {
        case textFieldBirthDate:
            pickUpDate(textFieldBirthDate)
            toolBarSetUp(textField)
            datePickerActionButtonSetup(textField)
            textField.inputAccessoryView = toolBar
        case textFieldAnniversaryDate:
            pickUpDate(textFieldAnniversaryDate)
            toolBarSetUp(textField)
            datePickerActionButtonSetup(textField)
            textField.inputAccessoryView = toolBar
        case textFieldMobile:
            textFieldMobile.becomeFirstResponder()
            toolBarSetUp(textField)
            mobileNumberToolbarSetup()
            textField.inputAccessoryView = toolBar
        default:
            textField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    //MARK: Edit Profile Api Delegate
    func navigateToProfile() {
        editApiCallDelegate?.editImageAPI()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func onFailToUpdate(error: AnyObject) {
        if (try? NSJSONSerialization.JSONObjectWithData(error as! NSData, options: []) as! NSDictionary) != nil {
            CommonHelper().showToastMessageOn(self.view, message: ResponseParameters.NESTED_ERROR_EDITPROFILE)
        }
    }
    
    /**
     Validates all textfields
     
     - returns: returns true if the textfields of email, mobile, birthdate and anniversary date are true else false
     */
    func isValidUserProfile() -> Bool {
        if !isValidString(textFieldEmail.text!) || !isValidEmailAddress((textFieldEmail.text)!) {
            CommonHelper().showToastMessageOn(self.view, message: ValidationConstants.ENTER_PROPER_EMAIL)
            return false
        } else if !isValidString(textFieldMobile.text!) || !isValidatePhoneNo((textFieldMobile.text)!) {
            CommonHelper().showToastMessageOn(self.view, message: ValidationConstants.INVALID_MOBILE_NUMBER)
            return false
        }
        return true
    }
    
    //MARK: Pick date
    /**
     Creates datepicker,toolbar and ok and cancel button and allows user to select date
     
     - parameter textField: textfield on which date picker view is to be added
     */
    func pickUpDate(textField: UITextField) {
        datePickerSetup(textField)
    }
    
    //MARK: Methods of date picker
    /**
     Executes the method if ok button date picker is clicked and sets the date selected
     
     - parameter sender: button
     */
    func okClicked(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = StringUtilsConstant.DATE_FORMAT
        if sender.tag == NumberConstant.ONE {
            textFieldBirthDate.text = dateFormatter.stringFromDate(datePicker!.date)
            textFieldBirthDate.resignFirstResponder()
        } else {
            textFieldAnniversaryDate.text = dateFormatter.stringFromDate(datePicker!.date)
            textFieldAnniversaryDate.resignFirstResponder()
        }
        cancelClicked()
    }
    
    /**
     Executes if cancel button is clicked
     */
    func cancelClicked() {
        textFieldBirthDate.resignFirstResponder()
        textFieldAnniversaryDate.resignFirstResponder()
        datePicker?.removeFromSuperview()
    }
    
    /**
     Setups date picker and sets it with default date
     
     - parameter textField: textfield on which date is to be placed
     */
    func datePickerSetup(textField: UITextField) {
        datePicker = UIDatePicker()
        datePicker!.setValue(UIColor.whiteColor(), forKeyPath: StringUtilsConstant.TEXT_COLOR)
        datePicker?.backgroundColor = UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
        datePicker?.datePickerMode = UIDatePickerMode.Date
        textField.inputView = datePicker
        setDefaultDate(textField)
    }
    
    /**
     select today's date if no date is selected else select the date present on textfield
     
     - parameter textField: textfield on which date is to be placed
     */
    func setDefaultDate(textField: UITextField) {
        let todaysDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = StringUtilsConstant.DATE_FORMAT
        let minimumDate = dateFormatter.dateFromString(StringUtilsConstant.DEFAULT_DATE)
        datePicker!.maximumDate = todaysDate
        datePicker?.minimumDate = minimumDate
        if textField.text != nil {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = StringUtilsConstant.DATE_FORMAT
            let date = dateFormatter.dateFromString(textField.text!)
            if let birthDate = date {
                datePicker?.setDate(birthDate, animated: false)
            }
        }
    }
    
    /**
     Toolbar setup for date picker
     */
    func toolBarSetUp(textField: UITextField) {
        toolBar = UIToolbar()
        toolBar!.barStyle = .Default
        toolBar!.translucent = true
        toolBar!.barTintColor = UIColor.whiteColor()
        toolBar!.tintColor = UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
        toolBar!.sizeToFit()
        toolBar!.userInteractionEnabled = true
    }
    
    /**
     Setups ok and cancel button on date picker to choose or cancel date
     
     - parameter textField: textfield on which date is to be placed
     */
    func datePickerActionButtonSetup(textField: UITextField) {
        let doneButton = UIBarButtonItem(title: StringUtilsConstant.OK,style: .Plain,target: self,action: #selector(okClicked))
        doneButton.tag = textField == textFieldBirthDate ? NumberConstant.ONE : NumberConstant.TWO
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: StringUtilsConstant.CANCEL,style: .Plain,target: self,action: #selector(cancelClicked))
        toolBar!.setItems([cancelButton, flexSpace, doneButton], animated: false)
    }
    
    /**
     Setups done button on toolbar to hide keyboard after the user has typed mobile number
     */
    func mobileNumberToolbarSetup() {
        let doneButton = UIBarButtonItem(title: StringUtilsConstant.OK,style: .Plain,target: self,action: #selector(buttonDoneTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar!.setItems([flexSpace, flexSpace, doneButton], animated: false)
    }
    
    /**
     Button done tapped user types mobile number
     */
    func buttonDoneTapped() {
        textFieldMobile.resignFirstResponder()
    }
    
    //MARK: Remove Profile Photo delegate
    func successfulRemovalOfProfilePhoto() {
        isAvatarPresent = false
        self.buttonEditPhoto.setTitle(StringUtilsConstant.ADD_PHOTO, forState: .Normal)
        self.view.makeToast(ToastMessages.PROFILE_PHOTO_REMOVED_SUCCESSFULLY, duration: ToastConstants.TOAST_TIME, position: .Center)
    }
    
    func failedToRemoveProfilePhoto(error: AnyObject) {
        if (try? NSJSONSerialization.JSONObjectWithData(error as! NSData, options: []) as! NSDictionary) != nil {
            CommonHelper().showToastMessageOn(self.view, message: ResponseParameters.NESTED_ERROR_EDITPROFILE)
        }
    }
}
