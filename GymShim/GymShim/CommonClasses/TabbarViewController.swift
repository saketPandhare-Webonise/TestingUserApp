//
//  TabbarViewController.swift
//  GymShim
import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var bgView = UIView()
    let topHeight:CGFloat = 6
    let bottomHeight:CGFloat = -6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = self.tabBar
        self.delegate = self
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().barTintColor = UIColor.whiteColor()//getAppThemeColor()
        UITabBar.appearance().opaque = true
        
        self.view.setNeedsLayout()
        for item in tabBar.items! {
            item.imageInsets = UIEdgeInsets(top: topHeight, left: 0, bottom:bottomHeight, right: 0)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        setBackgroundcolorToSelectedTab(item.tag)
    }

    /// this function will set Tabbackground color to AppTheme color on selection
    func setBackgroundcolorToSelectedTab(index:Int) {
        bgView.backgroundColor = UIColor.clearColor()
        let itemIndex = CGFloat(index)
        let bgColor = getAppThemeColor()
        let itemWidth = self.view.frame.width / CGFloat(tabBar.items!.count)
        bgView = UIView(frame: CGRectMake(itemWidth * itemIndex, 0, itemWidth,tabBar.frame.height))
        bgView.backgroundColor = bgColor
        tabBar.insertSubview(bgView, atIndex: index)
        tabBar.tintColor = UIColor.whiteColor()
    }
}
