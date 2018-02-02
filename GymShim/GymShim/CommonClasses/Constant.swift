//
//  Constant.swift
//  GymShim

typealias WebServiceType = Constant.WebServiceMethodTypes
typealias FontType = Constant.FontType
typealias FontSize = Constant.FontSize
typealias StoryBoardIdentifires = Constant.StoryBoardIdentifier
typealias RequestParameters = Constant.RequestParameters
typealias WebServiceUrls = Constant.WebServiceURL
typealias ImageAssets = Constant.ImageAsset
typealias UIButtonConstants = Constant.ButtonConstants
typealias ValidationConstants = Constant.ValidationConstant
typealias ToastConstants = Constant.ToastConstants
typealias UserDefaultConstants = Constant.UserDefaultConstant
typealias ResponseParameters = Constant.ResponseParameters
typealias ColorHexValue = Constant.ColorHexValue
typealias NavigationBarTitle = Constant.NavigationBarTitle
typealias WebServiceErrors = Constant.WebServiceError
typealias TableCellIdentifiers = Constant.TableCellIdentifiers
typealias FontFamilies = Constant.FontFamilies
typealias NumberConstant = Constant.NumberConstants
typealias NavigationBarTitles = Constant.NavigationBarTitles
typealias ProfileMappableParsingConstant = Constant.ProfileMappableParsingConstant
typealias GymDetailsMappableConstant = Constant.GymDetailsMappableConstant
typealias ImageIconSize = Constant.ImageIconSize
typealias StringUtilsConstant = Constant.StringUtilsConstant
typealias DeviceWidth = Constant.DeviceWidth
typealias CalendarStripWidth = Constant.CalendarStripWidth
typealias ToastMessages = Constant.ToastMessages
typealias ActionSheetConstant = Constant.ActionSheetConstant
typealias GooglePlacesConstant = Constant.GooglePlacesConstant
typealias HomeScreenMappableConstants = Constant.HomeScreenMappableConstant
typealias TableCellHeight = Constant.TableCellHeight
typealias DateFormatterConstant = Constant.DateFormatterConstant
typealias AttendanceConstant = Constant.AttendanceConstant
typealias BracketConstant = Constant.BracketConstant
typealias TagBarTagConstants = Constant.TabBarTagConstant
typealias FeedBackMappableConstant = Constant.FeedBackMappableConstant
typealias TimeAgo = Constant.Time_Ago
typealias TimeConversition = Constant.TimeConversition
typealias NotificationConstant = Constant.NotificationConstant
typealias AlertViewConstants = Constant.AlertViewConstants
typealias MonthConstant = Constant.MonthConstant
typealias StatusBarConstants = Constant.StatusBarConstants
typealias ScheduleParsingConstant = Constant.ScheduleParsingConstant
typealias MonthConstantAsNumber = Constant.MonthConstantAsNumber
typealias SelectedDay = Constant.SelectedDay
typealias Devicetype = Constant.IphoneWidth
typealias PooledMemberships = Constant.PooledMembership
typealias ScreenNames = Constant.ScreenName
typealias UrlTypes = Constant.UrlTypes
typealias AppUrls = Constant.AppUrls
typealias ApiVersions = Constant.ApiVersions
typealias PaymentParsingConstant = Constant.PaymentParsingConstant

class Constant {
    
    class WebServiceMethodTypes{
        static let GET = "GET"
        static let POST = "POST"
        static let DELETE = "DELETE"
        static let HEADER = "HEADER"
        static let PUT = "PUT"
    }
    
    class FontType{
        static let HELVITICA = "Helvetica"
        static let HELVITICA_MEDIUM = "Helvetica Medium"
        static let HELVITICA_BOLD = "Helvetica Bold"
    }
    
    class FontSize {
        static let ELEVEN = 11
        static let TWELVE = 12
        static let FOURTEEN = 14
        static let TWENTYONE = 21
        static let THIRTEEN = 13
        static let SIXTEEN = 16
    }
    
    class StoryBoardIdentifier {
        static let LOGIN = "Login"
        static let TABBAR = "Tabbar"
        static let CHANGEPASSWORD = "ChangePasswordVC"
        static let VIEW_PROFILE_VC = "ViewProfileVC"
        static let HOME_SCREEN = "HomeScreen"
        static let MAIN = "Main"
        static let EDIT_PROFILE_VC = "EditProfileVC"
        static let POP_OVER_QRCODE = "PopOverQR"
        static let MEMBERSHIP_DETAILS = "MemberShipDetailsVC"
        static let MY_TRIALS_VC = "MyTrialsVC"
        static let FORGOT_PASSWORD_VC = "ForgotPasswordVC"
        static let POST_FEEDBACK_VC = "PostFeedBackVC"
        static let FEEDBACK_VC = "FeedBackVC"
        static let FEEDBACK_DEATILS = "FeedBackDetailsVC"
        static let ENLARGE_QR_VC = "EnlargeQRVC"
        static let GYM_SCHEDULE_VC = "GymScheduleVC"
        static let VIEW_MORE_VC = "ViewMoreVC"
        static let TRIAL_DETAILS_VC = "TrialDetailsVC"
        static let WEB_VIEW_VC = "WebViewVC"
        static let NOTIFICATION_VC  = "NotificationVC"
        static let BIRTHDAYVC = "BirthdayVC"
        static let BULK_NOTIFICATION_VC = "BulkNotificationDetailVC"
    }
    
    class TableCellIdentifiers {
        static let USER_DETAILS_TABLE_VIEW_CELL = "UserDetailsTableViewCell"
        static let LOGOUT_TABLE_VIEW_CELL = "LogoutTableViewCell"
        static let HOME_MEMBERSHIP_CELL = "HomeMembershipCell"
        static let USERNAME_CELL = "UserNameCell"
        static let MEMBERSHIPCELL = "MembershipCell"
        static let MEMBERSHIP_TABLE_VIEW_CELL = "MyMembershipsTableViewCell"
        static let MY_TRIALS_VIEW_CELL = "MyTrialsTableViewCell"
        static let MEMBERSHIP_DETAILS_CELL = "MembershipDetailCell"
        static let SCHEDULE_CELL = "ScheduleTableCell"
        static let TRIAL_TABLE_VIEW_CELL = "TrialTableViewCell"
        static let GYM_NAME_TABLE_CELL = "GymNameTableCell"
        static let FEEDBACK_TABLE_CELL  = "FeedBackTableCell"
        static let MORE_DETAILS_TABLE_CELL  = "MoreDetailsTableViewCell"
        static let ABOUT_GYMSHIM_TABLE_CELL  = "AboutGymshimTableViewCell"
        static let PRIVACY_POLICY_TABLE_CELL  = "PrivacyPolicyTableViewCell"
        static let PN_SETTING_TABLE_CELL  = "PNSettingTableViewCell"
        static let GYM_SCHEDULE_TABLE_CELL =  "GymScheduleTableCell"
        static let NOTIFICATION_TABLE_CELL = "NotificationTableCell"
        static let UPCOMING_TRAIL_TABLE_CELL  = "UpcomingTrialCell"
        static let PAYMENT_TABLE_CELL = "PaymentTableCell"
    }
    
    class RequestParameters {
        static let LOGIN = "login"
        static let PASSWORD = "password"
        static let USER = "user"
        static let CURRENT_PASSWORD = "current_password"
        static let CONFIRM_PASSWORD = "password_confirmation"
        static let AUTH_TOKEN = "auth_token"
        static let IMAGE_SIZE = "image_sizes"
        static let TMP_TOKEN = "xGYfQFy9vSJRnYZkAV11"
        static let EDIT_USER_NAME = "user[name]"
        static let EDIT_USER_IMAGE = "user[avatar]"
        static let EDIT_ANNIVERSARY_DATE = "user[anniversary_date]"
        static let EDIT_DOB = "user[dob]"
        static let EDIT_EMAIL = "user[email]"
        static let EDIT_MOBILE_NUMBER = "user[mobile_number]"
        static let IMAGE_PNG = "image/png"
        static let DOB = "dob"
        static let ANNIVERSARY_DATE = "anniversary_date"
        static let AVATAR = "avatar"
        static let PROFILE_ATTRIBUTES = "profile_attributes"
        static let MOBILE_NUMBER = "mobile_number"
        static let EMAIL = "email"
        static let ID = "id"
        static let MONTH = "month"
        static let YEAR = "year"
        static let FEEDBACK_GYM_ID = "gym_id"
        static let FEEDBACK_TITLE = "title"
        static let FEEDBACK_COMMENT = "comment"
        static let FEED_BACK = "feedback"
        static let PAGE = "page"
        static let PER_PAGE = "per_page"
        static let NOTIFICATION = "notification"
        static let OS = "os"
        static let REG_ID = "reg_id"
    }
    
    
    struct UrlTypes {
        static let TESTING = "TESTING"
        static let STAGING = "STAGING"
        static let PRODUCTION = "PRODUCTION"
    }
    
    struct AppUrls {
        static let baseURL = getBaseUrl()
        static let TESTING_URL = "https://api-testing.gymshim.com/"
        static let STAGING_URL = "https://api-staging.gymshim.com/"
        static let PRODUCTION_URL = "https://api.gymshim.com/"
    }
    
    struct ApiVersions {
        static let V2 = "api/v2"
    }
    
    class WebServiceURL {
        
        // Production URL :
        static let BASE_URL =  getBaseUrl()//WebServiceURL.getBaseUrl(UrlTypes.TESTING)
        
        /*
         This method is used to get BaseURL dependent upon instance type passed
         Parameter: Instance type selected [Test/Stage/Prod]
           */
        static func getBaseUrl(instanceType: String) -> String {
            
            switch instanceType {
                
                case UrlTypes.TESTING:
                return AppUrls.TESTING_URL
                
                case UrlTypes.STAGING:
                return AppUrls.STAGING_URL
                
                case UrlTypes.PRODUCTION:
                return AppUrls.PRODUCTION_URL
                
            default:
                return ""
                
            }
        }
        
        static func LOGIN_URL() -> String{
            return BASE_URL + "users/sign_in.json"
        }
        
        static func CHANGE_PASSWORD() -> String{
            return BASE_URL + "users.json"
        }
        
        static func USER_PROFILE_URL() -> String {
            return  BASE_URL + "users/profile.json"
        }
        
        static func LOG_OUT() -> String {
            return BASE_URL + "users/sign_out.json"
        }
        
        static func USER_ACTIVE_MEMBERSHIPS() -> String{
            return BASE_URL +  ApiVersions.V2 + "/memberships.json"
        }
        
        static func RESET_PASSWORD() -> String{
            return BASE_URL + "users/reset.json"
        }
        
        static func MEMBERSHIP_DETAILS(membershipID: String) -> String {
            return BASE_URL + "memberships/" + membershipID  + ".json"
        }
        
        static func GYMLIST_FOR_FEEDBACK() -> String{
            return BASE_URL + "feedbacks/gyms.json"
        }
        
        static func USER_FEEDBACK() -> String{
            return BASE_URL + "feedbacks.json"
        }
        
        static func FEEDBACK_REVIWED(feedBackID: Int) -> String{
            return BASE_URL + "feedbacks/" + String(feedBackID)  + "/viewed" + ".json"
        }
        
        static func REMOVE_IMAGE() -> String{
            return BASE_URL + "users/remove_image.json"
        }
        
        static func USER_NOTIFICATION() -> String{
            return BASE_URL + "notifications.json"
        }
        
        static func GET_FEEDBACK_DETAIL(feedBackID: Int) -> String {
            return BASE_URL + "feedbacks/" + String(feedBackID) + ".json"
        }
        
        static func GET_TRIAL_INFO(trialID: Int) -> String {
            return BASE_URL + "trials/" + String(trialID) + ".json"
        }
        
        static func NOTIFICATION_VIEWED(notificationID: Int) -> String {
            return BASE_URL + "notifications/" + String(notificationID) + "/viewed.json"
        }
        
        static func GYM_SCHEDULE(membershipID: String) -> String {
            return BASE_URL + "memberships/" + membershipID  + "/schedule.json"
        }
        
        static func NOTIFICATION_VIEW_ALL() ->String {
            return BASE_URL + "notifications/viewed_all.json"
        }
        
        static func ABOUT_GS() ->String {
            return BASE_URL + "/about_us"
        }
        
        static func PRIVACY_POLICY() -> String {
            return BASE_URL + "privacy_policy"
        }
        
        static func TERMS_OF_USE() -> String {
            return BASE_URL + "terms_of_service"
        }
        
        static func PAYMENT_INFO() -> String {
            return BASE_URL + "/payments.json"
        }
    }
    
    class ImageAsset {
        static let SHOW_PASSWORD = "Password-Show"
        static let HIDE_PASSWORD = "Password-Hide"
        static let USERDEFAULT_IMAGE = "UserDefault"
        static let LOADER_GIF = "SB_Loader@3x"
        static let BACK_ICON = "iconBack"
        static let NOTIFICATION = "Notification"
        static let APPLOGO = "Logo"
        static let BACK_BUTTON = "imageBackButton"
        static let CALENDAR_MISSED = "Calendar_Missed"
        static let CALENDAR_ATTENDED = "Calendar_Attended"
        static let HOME_SELECTED = "imageTabBarSelectedHome"
        static let PROFILE_SELECTED = "imageTabBarProfileSelected"
        static let FEEDBACK_SELECTED = "imageTabbarSelectedFeedBack"
        static let MORE_SELECTED   = "imageTabBarSelectedMore"
        static let ADD_FEEDBACK  = "imageAddFeedBack"
        static let DOWN_ARROW_IMAGE =  "imageDownArrow"
        static let UP_ARROW_IMAGE = "imageUpArrow"
        static let GYM_ICON = "imageGymIcon"
        static let TERMS_OF_SERVICE = "more_termsofservices@1x"
        static let LOGOUT_IMAGE = "imageProfileLogOut"
        static let RIGHT_ARROW_ICON = "iconBlueArrow"
        static let BIRTHDAY_IMAGE = "imageBirthday"
        static let ANNIVERSARY_IMAGE = "imageAnniversary"
    }
    
    class ButtonConstants{
        static let SHOW_PASSWORD_WIDTH = 22
        static let SHOW_PASSWORD_HEIGHT = 16
        static let BUTTON_UNDERLYING_CONSTANT = 5
        static let BOTTOM_SPACE = 10
        static let LEFT_SPACE = 15
        static let UPCOMING_ACTIVE_PAST = 60
        static let SHOW_PASSWORD_BUTTON_X = 30
        static let SHOW_PASSWORD_BUTTON_Y = 40
    }
    
    class ValidationConstant{
        static let ENTER_EMAIL = "Please enter your email!"
        static let ENTER_PASSWORD = "Password cannot be less than 8 characters!"
        static let ENTER_PROPER_EMAIL_PHONENO = "Please enter a valid email address or phone no!"
        static let INVALID_CREDENTIALS = "Invalid Credentials!"
        static let ENTER_YOUR_NAME = "Please enter your name!"
        static let ENTER_YOUR_PHONENO = "Please enter valid phone number!"
        static let PASSWORD_LENGTH = 8
        static let ENTER_ALL_DETAILS = "Please enter a valid email address or phone no!"
        static let NO_ACTIVEMEMBERSHIP_FOUND = "Oops! You don't have any active memberships!"
        static let NO_UPCOMING_MEMBERSHIP = "Oops! You don't have any upcoming memberships!"
        static let NO_PAST_TRIALS = "Oops! You don't have any past trials!"
        static let NO_UPCOMING_TRIALS = "Oops! You don't have any upcoming trials!"
        static let NO_PAST_MEMBERSHIP = "Oops! You don't have any past memberships!"
        static let INVALID_EMAIL_ADDRESS = "Please enter a valid email address!"
        static let ENTER_MOBILE = "Please enter your mobile!"
        static let INVALID_MOBILE_NUMBER = "Enter valid 10 digit mobile number!"
        static let ENTER_PROPER_EMAIL = "Please enter a valid email address! "
        static let PASSWORD_CHANGED = "You have successfully changed your password!"
        static let ENTER_ALL_FIELDS = "Please provide all details!"
        static let NO_FEEDBACK_YET = "You have not submitted any feedback yet!"
        static let ENTER_ALL_CREDENTIALS = "Please enter your credentials!"
        static let EMPTY_PASSWORD = "Please enter a valid password!"
        static let ENTER_CURRENT_PASSWORD = "Please enter the Current Password!"
        static let ENTER_NEW_PASSWORD = "Please enter the New Password!"
        static let NO_NOTIFICATIONS = "No notifications."
        static let NO_ACTIVEMEMBERSHIP_OR_TRIALS = "Oops! You don't have any active memberships or upcoming trials!"
        static let NO_PAYMENT = "There is no payment information to display."
    }
    
    class ToastConstants {
        static let TOAST_TIME = 3.0
        static let FEEDBACK_SUBMITTED_TOST = "Thank you for submitting your feedback! The gym will get back to you shortly!"
    }
    
    class UserDefaultConstant {
        static let TOKEN = "authentication_token"
        static let IS_REST_PASSWORD = "is_reset_password"
        static let INFO = "info"
        static let USERNAME = "username"
        static let USERINFO = "userInfo"
        static let SIGN_IN_COUNT = "sign_in_count"
        static let PROFILE_PIC_UPDATED = "profile_pic_updated"
        static let IS_AVATAR_PRESENT = "is_avatar_present"
        static let IS_DEVICETOKEN_REGISTERED = "is_devicetoken_registered"
        static let USER_UNIQUE_NUMBER = "userID"
        static let NOTIFICATION_COUNT = "notificationCount"
    }
    
    class ResponseParameters {
        static let USER = "user"
        static let INFO = "info"
        static let AUTH_TOKEN = "authentication_token"
        static let IS_RESET_PASSWORD = "is_reset_password"
        static let ERROR = "error"
        static let MESSAGE = "message"
        static let NAME = "name"
        static let SIGN_IN_COUNT = "sign_in_count"
        static let NESTED_AUTHTOKEN = "info.authentication_token"
        static let NESTED_ISRESETPASSWORD = "user.is_reset_password"
        static let NESTED_USERNAME = "user.name"
        static let NESTED_ERROR_EDITPROFILE = "An account is already associated with this email address/mobile no!"
        static let STATUSCODE = "StatusCode"
        static let NOT_FOUND = 401
        static let IS_AVATAR_PRESENT = "is_avatar_present"
        static let STATUS_CODE = 200
        static let AUTHENTICATION = "authentication"
        static let USERID = "id"
        static let NUMBER = "number"
    }
    
    class ColorHexValue {
        static let TEXTFIELD_BOTTOM_BORDER = "#425A6A"   //dark brown color
        static let NAVIGATION_BAR = 0x01334E
        static let NAVIGATION_BAR_TITLE = 0xeeeeee
        static let RED_COLOR = 0xf03f35
        static let CALENDAR_DAY_COLOR = 0xbbbbbb
        static let ABSENT_COLOR = 0xD32F2F
        static let ATTENDED_COLOR = 0x398E3C
        static let GRAY_COLOR = 0x888888
        static let VIEW_BACKGROUND_COLOR = 0xF4F4F4
        static let FEEDBACK_BACKGROUND_COLOR =  0xFFF8E4
        static let QR_CODE_TITLE_COLOR = 0xFFEEEE
        static let DIVIDER_COLOR = 0xDDDDDD
        static let FEEDBACK_REPLY_BGCOLOR = 0xFFF9E5
        static let MORE_COLOR =  0x0ef4035
        static let TRIAL_ATTENDED = 0x388e3c
        static let TRIAL_NOT_ATTENDED = 0xd32f2f
        static let HYPERLINK_COLOR = 0x0000FF
    }
    
    class NavigationBarTitle {
        static let CHANGEPASSWORD = "Change Password"
        static let EDIT_PROFILE = "Edit Profile"
        static let MY_MEMBERSHIP = "My Memberships"
        static let MY_TRIALS = "My Trials"
        static let FORGOT_PASSWORD = "Forgot Password"
        static let FEEDBACK = "Feedback"
        static let QR_CODE = "QR Code"
        static let UPCOMING_TRIALS = "Upcoming Trials"
        static let PRIVACY_POLICY = "Privacy Policy"
        static let TERMS_OF_SERVICE = "Terms of Service"
        static let ABOUT_GS = "About Gymshim"
        static let NOTIFICATION = "Notification"
    }
    
    class WebServiceError {
        static let INTERNET_FAILURE_MESSAGE = "Problem Loading. Please try again!"
        static let UPDATE_FAILED = "Failed to update profile picture!"
        static let FP_MAIL_SENT = "Reset Link has been sent to "
        static let ERROR_SENDING_MAIL = "Some problem sending mail"
    }
    
    class NumberConstants {
        static let FOURTY_FOUR = 44
        static let ZERO = 0
        static let ESTIMATED_ROW_HEIGHT = 200
        static let ONE = 1
        static let TWO = 2
        static let THREE = 3
        static let FOUR = 4
        static let FIVE = 5
        static let SIZE = 0.5
        static let DOES_NOT_EXIST = -1
        static let VIEW_ALL_HEIGHT = 45
        static let FOURTY = 40
        static let TWO_HUNDRED = 200
        static let TRIAL_CELL_HEIGHT = 108
        static let STATUS_CODE = 401
        static let THIRTY = 30
        static let FIFTEEN = 15
        static let FIFTY = 50
        static let SWITCH_SCALING_FACTOR = 0.6
        static let TEXT_SPACING_CONSTANT = 15
        static let TEXT_SPACING = 24
        static let SHOWPASSWORD_INSETS  = -20
        static let NINE = 9
    }
    
    class FontFamilies {
        static let FONTFAMILY_HELVETICA_MEDIUM = "Helvetica Medium"
    }
    
    class NavigationBarTitles {
        static let PROFILE = "Profile"
    }
    
    class ProfileMappableParsingConstant {
        static let USER = "user"
        static let USER_ID = "id"
        static let MOBILE_NUMBER = "mobile_number"
        static let EMAIL = "email"
        static let VERIFIED = "verified"
        static let SHORTLISTED_GYMS = "shortlisted_gyms"
        static let PROFILE = "profile"
        static let USER_NAME = "name"
        static let GENDER = "gender"
        static let DOB = "dob"
        static let ANNIVERSARY_DATE = "anniversary_date"
        static let AVATAR = "avatar"
        static let REVIEW = "reviews"
        static let NAME = "name"
        static let MY_MEMBERSHIP = "my_memberships"
        static let MEMBERSHIP_NO = "number"
        static let MEMBERSHIP_GYMNAME = "gym_name"
        static let MEMBERSHIP_START_TIME = "starts_at"
        static let MEMBERSHIP_END_TIME = "ends_at"
        static let MEMBERSHIP_PURCHASED_TYPE = "purchased_type"
        static let MEMBERSHIP_SESSIONS = "sessions"
        static let MEMBERSHIP_USED_SESSION = "used_sessions"
        static let MEMBERSHIP_BURNED_SESSION = "burned_session"
        static let MEMBERS = "members"
        static let MEMBER_FULL_NAME = "full_name"
        static let MEMBER_MOBILE_NO = "mobile_number"
        static let MEMBERSHIP_EMAIL = "email"
        static let MEMBERSHIP_PLAN_DETAIL = "plan_detail"
        static let MEMBERSHIP_PLAN_TYPE = "plan_type"
        static let MEMBERSHIP_PLAN_MONTHS = "plan_months"
        static let MEMBERSHIP_PLAN_BASEPRICE = "base_price"
        static let MEMBERSHIP_PLAN_DISCOUNTED_PRICE = "discounted_price"
        static let MEMBERSHIP_PLAN_SPONSORED = "sponsored"
        static let MEMBERSHIP_PLAN_SOLD = "sold_price"
        static let MEMBERSHIP_PLAN_ALLOW_POOLING = "allow_pooling"
        static let MEMBERSHIP_STATUS = "status"
        static let GYM_ACTIVITY_NAME = "name"
        static let GYM_ACTIVITY_ICON = "icon"
        static let REMAINING_SESSIONS = "remaining_session"
        static let ACTIVITY_IMAGES = "activity_images"
        static let COMMENT = "comment"
        static let REVIEWER_NAME = "reviewer_name"
        static let REVIEWABLE_NAME = "reviewable_name"
        static let REVIEWER_ICON = "reviewer_name"
        static let REVIEWABLE_ICON = "reviewable_name"
        static let TRIAL_DATE = "trial_date"
        static let TRIAL_TIME = "trial_time"
        static let TRIAL_STATUS = "trial_status"
        static let MEMBERSHIP_PLAN = "membership_plan"
        static let MY_TRIALS = "my_trials"
        static let MEMBERSHIP = "membership"
        static let TRIALS_AND_MEMBERSHIPS = "trials_and_memberships"
        static let TRIALS = "trials"
        static let TRIAL_ATTENDANCE_STATUS = "attendance_status"
    }
    
    class GymDetailsMappableConstant {
        static let NAME = "name"
        static let ACTIVITIES = "activities"
        static let ID = "id"
        static let PRICE = "price"
        static let IMAGE = "image"
        static let PLANTYPE = "plan_type"
        static let SPONSERED = "sponsored"
        static let RATING = "rating"
        static let FULL_ADDRESS = "full_address"
        static let FEATURED = "featured"
        static let SPONSORED = "sponsored"
        static let OFFERED_PRICE = "offered_price"
        static let LOCATION = "location"
        static let LATITUDE = "lat"
        static let LONGITUDE = "lng"
        static let REMAINING_SLOT = "remaining_slot"
        static let ACTIVE = "active"
    }
    
    class ImageIconSize {
        static let SMALL = "small"
        static let MEDIUM = "medium"
        static let LARGE = "large"
    }
    
    class StringUtilsConstant {
        static let EMPTY_STRING = ""
        static let CHANGE_PASSWORD = "CHANGE PASSWORD"
        static let NO_CLASS_TODAY = "No class today"
        static let WELCOME = "Welcome "
        static let COMMA = ","
        static let FILE = "file.png"
        static let ADD_ANNIVERSARY = "Add Anniversary Date"
        static let ADD_DATE_OF_BIRTH = "Add Birth Date"
        static let ANNIVERSARY = "Anniversary Date "
        static let BIRTHDAY = "Birth Date "
        static let ACTIVE = "active"
        static let PAST = "past"
        static let UPCOMING = "upcoming"
        static let OPENING_BRACKETS = "("
        static let CLOSING_BRACKETS = ")"
        static let TWO_DIGIT_FORMAT = "%02d"
        static let MY_MEMBERSHIPS = "MY MEMBERSHIPS "
        static let MY_TRIALS = "MY TRIALS "
        static let DATE_FORMAT = "dd-MM-yyyy"
        static let OK = "Done"
        static let CANCEL = "Cancel"
        static let TEXT_COLOR = "textColor"
        static let SESSIONS = " Sessions"
        static let SESSION = " Session"
        static let MISSED = "Missed "
        static let ATTENDED = "Attended "
        static let DEFAULT_DATE = "01-01-1950"
        static let ADD_PHOTO = "Add Photo"
        static let EDIT_PHOTO = "Edit Photo"
        static let SUBJECT = "Subject"
        static let WRITE_YOUR_FEED_BACK = "Write your feedback"
        static let YESTERDAY = "Yesterday"
        static let REPLIED =  " replied"
        static let REPLY_BY = "Reply by "
        static let DEVICE_TOKEN = "deviceToken"
        static let OS = "ios"
        static let NOTIFICATION_REG_ID = "reg_id"
        static let APS = "aps"
        static let ALERT = "alert"
        static let MESSAGE = "message"
        static let DESTRUCTIVE = "Destructive"
        static let TERMS_OF_SERVICE = "Terms of Service"
        static let TEMPORARY_URL = "https://www.google.com"
        static let NO_SCHEDULE_FOUND = "There are no activities scheduled on this day!"
        static let CURRENT_MONTH_COMPONENT = "MMMM "
        static let CLEAR_ALL = "CLEAR ALL"
        static let TRUNCATED_MORE = " ...more"
        static let COMMA_SEPERATOR = ", "
        static let GYM_TRIAL = "Gym Trial"
        static let VIEW_MORE = "...View More"
        static let ABOUT_GYM = "Gymshim is a unique fitness technology app designed to help customer’s stream line day to day gym activities & processes. The main aim of Gymshim is to revolutionize the way the fitness industry operates. This app will be your perfect aide in marking your attendance, increase your gym regularity, being notified about group classes, sending timely feedback and even checking on the no. of sessions remaining"
        static let VIEW_LESS = "View Less"
        static let NOTIFICATION_DISABLE_TEXT = "Notifications have been disabled for this application. Please go to Settings > Gymshim > Allow Notifications to enable them."
        static let DEFAULT_TEXT_NOTIFICATION = "Receive important remainders,updates,feedback and more."
        static let TRIAL_ATTENDED = "Attended"
        static let TRIA_NOT_ATTENDED = "Not Attended"
        static let PAST_TRIAL = "Past"
        static let PAID_AMOUNT = "Paid Amount"
        static let PAID_ON = "Paid On"
        static let TRUNCATE_TAIL_CONSTANT = "..."
        static let UNDERSCORE = "_"
        static let BASE_URL = "BASE_URL"
        static let INFO = "Info"
        static let PLIST = "plist"
    }
    
    class DeviceWidth {
        static let IPHONE_5 = 320
        static let IPHONE_6_7 = 375
        static let IPHONE_6PLUS_7PLUS = 414
    }
    
    class CalendarStripWidth {
        static let MINIMUM_WIDTH = 274
        static let NORMAL_WIDTH = 320
        static let MAXIMUM_WIDTH = 355
    }
    
    class ToastMessages {
        static let LOGOUT_MESSAGE = "You have successfully logged out of Gymshim!"
        static let DATE_USED_MESSAGE = "This number has already been taken"
        static let CHANGE_PASSWORD_SUCCESSFUL_MESSAGE = "You have successfully changed your password!"
        static let WRONG_TOKEN = "Oops! Something went wrong. Please login again"
        static let PROFILE_UPDATED_SUCCESSFULLY = "Your Profile has been updated successfully!"
        static let LOGIN_SUCCESSFUL = "You have successfully logged in!"
        static let NO_MEMBERSHIP_POST_FEEDBACK = "You will be able to submit feedback once you have purchased a fitness membership!"
        static let PROFILE_PHOTO_REMOVED_SUCCESSFULLY = "Profile picture has been removed successfully!"
    }
    
    class ActionSheetConstant {
        static let CHOOSE_OPTIONS = "Choose Option"
        static let GALLERY = "Gallery"
        static let CAMERA = "Camera"
        static let REMOVE_PHOTO = "Remove Photo"
        static let CANCEL = "Cancel"
        static let NO_CAMERA = "Camera Not Found"
        static let NO_CAMERA_FOR_DEVICE = "This device has no Camera"
        static let OK = "OK"
    }
    
    class GooglePlacesConstant {
        static let GOOGLE_BASE_URL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
    }
    
    class HomeScreenMappableConstant {
        static let MYMEMBERSHIPS = "memberships"
        static let MEMBERSHIP_ID = "id"
        static let MEMBERSHIP_NUMBER = "number"
        static let MEMBERSHIP_START_DATE = "starts_at"
        static let MEMBERSHIP_END_DATE = "ends_at"
        static let MEMBERSHIP_TOTAL_SESSIONS = "sessions"
        static let MEMBERSHIP_REMAINING_SESSIONS = "remaining_sessions"
        static let GYM_NAME = "gym_name"
        static let GYM_PLANNAME = "plan_name"
        static let SCHEDULE = "schedule"
        static let SESSION_DAY = "day"
        static let SESSION_TIME = "time"
        static let DATE = "date"
        static let STATUS = "status"
        static let ATTENDANCE_DATES = "attendance_dates"
        static let MEMBERSHIP_TIMINGS = "membership_timings"
        static let IS_POOLED_MEMBERSHIP = "is_pooled"
        static let POOLED_MEMBERSHIP = "pool_members"
        static let POOLED_NAME = "name"
        static let POOLED_REMAINING_SESSION = "attended_count"
        static let UNREAD_COUNT = "unread_count"
        static let META = "meta"
    }
    
    class TableCellHeight {
        static let SCHEDULE_CELL_HEIGHT = 20
        static let MEMBERSHIP_DETAIL_HEIGHT = 550
        static let ABOUT_US_HEIGHT = 100
        static let MORE_DETAILS_HEIGHT = 200
        static let PN_SETTING_HEIGHT = 125
        static let UPCOMING_TRIAL_HEIGHT = 185
    }
    
    class DateFormatterConstant {
        static let CALENDAR_FORMAT = "yyyy/MM/dd"
    }
    
    class AttendanceConstant {
        static let UPCOMING = 0
        static let ABSENT = 1
        static let PRESENT = 2
        static let NOSESSION = 3
        static let TODAY = 4
    }
    
    class BracketConstant {
        static let OPENING_BRACKET = " ( "
        static let CLOSING_BRACKET = " )"
        static let ZERO = "0"
        static let SPACE = " "
    }
    
    class TabBarTagConstant {
        static let HOMESCREEN = 0
        static let PROFILE = 1
        static let FEEDBACK = 2
        static let MORE = 3
    }
    
    class FeedBackMappableConstant {
        static let GYMS = "gyms"
        static let GYM_NAME = "name"
        static let GYM_SLUG = "slug"
        static let ID = "id"
        static let FEEDBACKS = "feedbacks"
        static let COMMENT = "comment"
        static let REVIEW_CREATED_TIME = "created_at"
        static let REVIEW_UPDATED_TIME = "updated_at"
        static let REVIEW_TITLE = "title"
        static let REVIEWER_NAME = "reviewer_name"
        static let REVIVED_GYMNAME = "reviewable_name"
        static let REVIEWER_ICON = "reviewer_icon"
        static let REVIVED_GYM_ICON = "reviewable_icon"
        static let GYMFEED_BACK = "feedback_comment"
        static let FEEDBACK_VIEWED = "viewed"
        static let DATA = "data"
        static let META = "meta"
        static let TOTAL = "total"
        static let FEEDBACK = "feedback"
        static let TRIAL = "trial_membership"
    }
    
    class Time_Ago {
        static let FEW_MIN_AGO = 0
        static let TODAY = 1
        static let IN_CURRENT_WEEK = 2 ... 7
        static let MORE_THAN_WEEK = 8 ... 1000000
        static let PREVIOUS_MONTHS = 61 ... 365
        static let PREVIOUS_YEAR = 366 ... 732
    }
    
    class TimeConversition {
        static let MINIUTE_AGO = " miniute ago"
        static let MINUTES_AGO = " minutes ago"
        static let HOUR_AGO = " hour ago"
        static let HOURS_AGO = " hours ago"
        static let DAY_AGO = " day ago"
        static let DAYS_AGO = " days ago"
        static let MONTH_AGO = " month ago"
        static let MONTHS_AGO = " months ago"
        static let YEAR_AGO = " year ago"
        static let YEARS_AGO = " years ago"
        static let DATE_FORMAT = "dd/MM/yyyy"
        static let DATE = "dd"
        static let HOUR = "hh:mm a"
        static let PREVIOUS_DATE = "dd-MM-yyyy"
        static let TODAY = 0
        static let YESTERDAY = 1
    }
    
    class NotificationConstant {
        static let FEEDBACK = "FeedbackNotification"
        static let MEMBERSHIP_DETAILS = "MembershipNotification"
        static let TRIAL = "TrialNotification"
        static let TYPE = "type"
        static let RESOURCE = "resource"
        static let NOTIFICATIONID = "notification_id"
        static let FEEDBACK_NOTIOFICATIONS = "feedback_notifications"
        static let NOTIFICATION_TITLE = "title"
        static let NOTIFICATION_DESCRIPTION = "description"
        static let NOTIFICATION_ID = "id"
        static let NOTIFICATIONS = "notifications"
        static let UPDATE_BADGE_NOTIFICATION = "badgeUpdateNotification"
        static let CREATED_AT = "created_at"
        static let USER_ANNIVERSARY = "AnniversaryNotification"
        static let USER_BIRTHDAY = "BirthdayNotification"
        static let DESCRIPTION = "description"
        static let PAYMENT_NOTIFICATION = "UserNotification"
        static let BULK_UPDATE = "BulkNotification"
        static let TRANSFER_NOTIFICATION = "TransferNotification"
    }
    
    class AlertViewConstants {
        static let PN_ON_TITLE = "Push Notification On"
        static let PN_OFF_TITLE = "Push Notification Off"
        static let PN_ON_MESSAGE = "You will now receive important reminders, updates, feedback and more."
        static let PN_OFF_MESSAGE = "Are you sure? You will not receive important reminders, updates, feedback and more."
        static let OK = "Ok"
        static let CANCEL = "Cancel"
    }
    
    class MonthConstant {
        static let JANUARY = "January "
        static let FEBRUARY = "February "
        static let MARCH = "March "
        static let APRIL = "April"
        static let MAY = "May "
        static let JUNE = "June "
        static let JULY = "July "
        static let AUGUST = "August "
        static let SEPTEMBER = "September "
        static let OCTOBER = "October "
        static let NOVEMBER = "November "
        static let December = "December "
    }
    class StatusBarConstants {
        static let STATUS_BAR = "statusBar"
        static let SET_BACKGROUND_COLOR = "setBackgroundColor:"
    }
    
    class ScheduleParsingConstant {
        static let GYM_SCHEDULE = "gym_schedule"
        static let TIME = "time"
        static let ACTIVITY_NAME = "activity_name"
        static let TRAINER_NAME = "name"
        static let TODAY = "today"
        static let WEEK_DAYS = "week_days"
        static let SUNDAY = "Sun"
        static let MONDAY = "Mon"
        static let TUESDAY = "Tue"
        static let WEDNESDAY = "Wed"
        static let THURSDAY = "Thu"
        static let FRIDAY = "Fri"
        static let SATURDAY = "Sat"
        static let TRAINERS = "trainers"
    }
    
    class MonthConstantAsNumber {
        static let JANUARY = 1
        static let FEBUARY = 2
        static let MARCH = 3
        static let APRIL = 4
        static let MAY = 5
        static let JUNE = 6
        static let JULY = 7
        static let AUGUST = 8
        static let SEPTEBER = 9
        static let OCTOBER = 10
        static let NOVEMBER = 11
        static let DECEMBER = 12
    }
    
    class SelectedDay {
        static let SUNDAY = 0
        static let MONDAY = 1
        static let TUESDAY = 2
        static let WEDNESDAY = 3
        static let THURSDAY = 4
        static let FRIDAY = 5
        static let SATURDAY = 6
    }
    
    class IphoneWidth {
        static let iPhone5 = 320
        static let iPhone6 = 375
        static let iPhone6Plus = 414
    }
    
    /// below value are used for extraacting members from array so started with zero
    class PooledMembership {
        static let firstPooledMember = 0
        static let secondPooledMember = 1
        static let thirdPooledMember = 2
    }
    
    /// For analytics
    class ScreenName {
        static let HOME_SCREEN = "HomeScreen"
        static let PROFILE_SCREEN = "ProfileScreen"
        static let FEEDBACK_SCREEN = "FeedbackScreen"
        static let FEEDBACK_DETAILSCREEN = "FeedbackDetailScreen"
        static let MORE_SCREEN = "MoreScreen"
        static let NOTIFICATION_SCREEN = "NotificationScreen"
        static let EDIT_PROFILE_SCREEN = "EdirProfileScreen"
        static let ACTIVE_MEMBERSHIP_SCREEN = "ActiveMembershipScreen"
        static let UPCOMING_MEMBERSHIP_SCREEN = "UpcomingMembershipScreen"
        static let PAST_MEMBERSHIP_SCREEN = "PastMembershipScreen"
        static let UPCOMING_TRIALS = "UpcomingTrialScreen"
        static let PAST_TRIAL_SCREEN = "PastTrailScreen"
        static let CHANGE_PASSWORD_SCREEN = "ChangePasswordScreen"
        static let LOGIN_SCREEN = "LoginScreen"
        static let SCHEDULE_SCREEN = "ScheduleScreen"
        static let MEMBERSHIP_DETAILS_SCREEN = "MembershipDetailScreen"
        static let FORGOT_PASSWORD_SCREEN = "ForgotPasswordScreen"
        static let PRIVACY_POLICY_SCREEN = "PrivacyPolicyScreen"
        static let TERMS_OF_USE_SCREEN = "TermsOfUseScreen"
        static let TRIAL_DETAILS_SCREEN = "TrialDetailScreen"
        static let ADD_FEEDBACK_SCREEN = "AddFeedbackScreen"
    }
    
    class NibIdentefiers {
        static let HOME_SECTION_HEADER = "HomeSectionHeader"
    }
    
    class PaymentParsingConstant {
        static let USER = "user"
        static let PAYMENTS = "payments"
        static let PENDING = "pending"
        static let COMPLETED = "completed"
        static let GYM_NAME = "gym_name"
        static let INVOICE_NO = "invoice_no"
        static let TOTAL_AMOUNT = "total_amount"
        static let PAID_AMOUNT = "paid_amount"
        static let BALANCE_AMOUNT = "balance_amount"
        static let DUE_DATE = "due_date"
        static let PAID_DATE = "paid_date"
    }
}
