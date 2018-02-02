//
//  WebViewVC.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions

class WebViewVC: CustomNotificationController {
    @IBOutlet var webViewAboutUs: UIWebView!
    
    var navigationTitle: String = ""
    var webViewUrl: String = ""
    
    //MARK: View cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        uiSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// Setups initial ui for webview screen
    func uiSetup() {
        self.title = navigationTitle
        hideNotificationButton()
        webViewAboutUs.loadRequest(NSURLRequest(URL:
            NSURL(string: webViewUrl)!))
    }
}
