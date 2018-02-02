//
//  Analytics.swift
//  GymShim


import UIKit
import Google


class Analytics: NSObject {

    /// This function is used to add track screens by using google analytics
    ///
    /// - parameter screenName: <#screenName description#>
    static func trackScreenByGoogleAnalytic(screenName: String) {
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: screenName)
        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
}
