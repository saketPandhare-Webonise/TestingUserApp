//
//  UserDefaults.swift
//  GymShim
//

import Foundation

//sets user name in user defaults
var userName: String {
    set(value) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: UserDefaultConstants.USERNAME)
    }
    get {
        var userName = ""
        if ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.USERNAME)) != nil){
            userName = ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.USERNAME)) as? String)!
        }
        return userName
    }
}

//sets user login token in user defaults
var userLoginToken: String {
    set(value) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: UserDefaultConstants.TOKEN)
    }
    get {
        var token = ""
        if ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.TOKEN)) != nil){
             token = ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.TOKEN)) as? String)!
        }
        return token
    }
}

//sets is password reset in user defaults
var isResetPassword: Bool {
    set(value) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: UserDefaultConstants.IS_REST_PASSWORD)
    }
    get {
        var token = false
        if ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.IS_REST_PASSWORD)) != nil){
            token = ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.IS_REST_PASSWORD)) as? Bool)!
        }
        
        return token
    }
}

//sets sign in count in user defaults
var signInCount: Int {
    set(value) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: UserDefaultConstants.SIGN_IN_COUNT)
    }
    get {
        var count = 0
        if ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.SIGN_IN_COUNT)) != nil) {
        count = ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.SIGN_IN_COUNT)) as? Int)!
        }
        return count
    }
}

//sets the key to true if avatar is present else false in user defaults
var isAvatarPresent: Bool {
    set(value) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: UserDefaultConstants.IS_AVATAR_PRESENT)
    }
    get {
        var token = false
        if ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.IS_AVATAR_PRESENT)) != nil){
        token = ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.IS_AVATAR_PRESENT)) as? Bool)!
        }
        return token
    }
}

// set device Token Received From APNS Server
var deviceToken: String {
     set(value) {
        let deviceToken = NSUserDefaults.standardUserDefaults()
        deviceToken[StringUtilsConstant.DEVICE_TOKEN] = value
    }
     get {
        var token = String()
        let deviceToken = NSUserDefaults.standardUserDefaults()
        if ((NSUserDefaults.standardUserDefaults().valueForKey(StringUtilsConstant.DEVICE_TOKEN)) != nil) {
           token = deviceToken[StringUtilsConstant.DEVICE_TOKEN] as! String
        }
        
        return token
  }
}

//sets usersRegestration ID From API Call of Register Notification
var userRegistrationID: String {
     set(value) {
        let registrationID = NSUserDefaults.standardUserDefaults()
        registrationID[StringUtilsConstant.NOTIFICATION_REG_ID] = value
      }
     get {
        var registrationID = ""
        let notificationRegisterID = NSUserDefaults.standardUserDefaults()
        
        if ((NSUserDefaults.standardUserDefaults().valueForKey(StringUtilsConstant.NOTIFICATION_REG_ID)) != nil){
            registrationID = notificationRegisterID[StringUtilsConstant.NOTIFICATION_REG_ID] as! String
        }
        
         return registrationID
    }
}

var isDeviceTokenRegistered: Bool {
     set(value) {
         NSUserDefaults.standardUserDefaults().setValue(value, forKey: UserDefaultConstants.IS_DEVICETOKEN_REGISTERED)
   }
      get {
         var token = false
        if ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.IS_DEVICETOKEN_REGISTERED)) != nil) {
            token = ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.IS_DEVICETOKEN_REGISTERED)) as? Bool)!
        }
        
         return token
   }
}

var userID: String {
       set(value) {
         NSUserDefaults.standardUserDefaults().setValue(value, forKey: UserDefaultConstants.USER_UNIQUE_NUMBER)
    }
    get {
       var userId = ""
       if ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.USER_UNIQUE_NUMBER)) != nil) {
        userId = ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.USER_UNIQUE_NUMBER)) as? String)!
    }
    return userId

   }
}

var notificationBadgeCount: Int {
      set(value) {
      NSUserDefaults.standardUserDefaults().setValue(value, forKey: UserDefaultConstants.NOTIFICATION_COUNT)
  }
      get {
      var count = 0
        if ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.NOTIFICATION_COUNT)) != nil){
        count = ((NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultConstants.NOTIFICATION_COUNT)) as? Int)!
        }
    return count
  }
}
