//
//  ActiveMembershipHeader.swift
//  GymShim

import Foundation
import UIKit

class HomeSectionHeader: UIView {
    var title = "" {
        didSet{
          labelActiveMembership.text = title
        }
    }
    
    @IBOutlet weak var labelActiveMembership: UILabel!
    
    override func awakeFromNib() {
        self.setNeedsLayout()
    }
}
