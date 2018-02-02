//
//  ActivityIndicatorLoader.swift
//  VMS

import UIKit

class LoadingActivityIndicatorView {
    
    static var currentOverlay : UIView?
    
    static func show() {
        guard let currentMainWindow = UIApplication.sharedApplication().keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow)
    }
    
    static func show(loadingText: String) {
        guard let currentMainWindow = UIApplication.sharedApplication().keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow, loadingText: loadingText)
    }
    
    static func show(overlayTarget : UIView) {
        show(overlayTarget, loadingText: nil)
    }
    
    /**
     Methods that takes gif image name with size of image that needed to be shown & shows it with overlay
     - parameter overlayTarget: View over which loader will be shown
     - parameter gifImage: method name of the gif image for loader animation
     - parameter parameters: size of the image
     - parameter animationDuration:   animation duration for gif image
     - parameter loadingText: text to show some text below loader
     */
    static func show(overlayTarget : UIView, gifImage : String, size: CGSize, animationDuration : Double, loadingText: String?) {
       
        // Clear it first in case it was already shown
        hide()
        
        // Create the overlay
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        overlay.alpha = 0
        overlay.backgroundColor = UIColor.clearColor()
        overlayTarget.addSubview(overlay)
        
        let overlayTransparent = UIView(frame: overlayTarget.frame)
        overlayTransparent.center = overlayTarget.center
        overlayTransparent.alpha = 0.5
        overlayTransparent.backgroundColor = UIColor.blackColor()
        overlay.addSubview(overlayTransparent)
        
        let loadingGif = UIImage.gifImageWithName(gifImage, duration: animationDuration)
        
        let imageView = UIImageView(image: loadingGif)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        imageView.center = overlay.center
        imageView.contentMode = UIViewContentMode.ScaleToFill
        overlay.addSubview(imageView)
        
        overlay.bringSubviewToFront(imageView)
        
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.blackColor()
            label.sizeToFit()
            label.center = CGPoint(x: imageView.center.x, y: imageView.center.y + 30)
            overlay.addSubview(label)
        }
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        overlay.alpha = 1.0//overlay.alpha > 0 ? 0 : 0.5
        UIView.commitAnimations()
        
        currentOverlay = overlay
    }
    
    static func show(overlayTarget : UIView, loadingText: String?) {
        // Clear it first in case it was already shown
        hide()
        
        // Create the overlay
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        overlay.alpha = 0
        overlay.backgroundColor = UIColor.blackColor()
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        // Create and animate the activity indicator
        let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicator.center = overlay.center
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.whiteColor()
            label.sizeToFit()
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            overlay.addSubview(label)
        }
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        UIView.commitAnimations()
        
        currentOverlay = overlay
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
    }
}
