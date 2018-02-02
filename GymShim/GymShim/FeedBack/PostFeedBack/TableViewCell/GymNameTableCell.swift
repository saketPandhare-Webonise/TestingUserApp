//
//  GymNameTableCell.swift
//  GymShim


import UIKit

class GymNameTableCell: UITableViewCell {
    
    @IBOutlet weak var labelgymName: UILabel!
    var memberShipDetails = ListGyms() {
        didSet {
            setGymData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// set data to DropDown TableCell
    func setGymData() {
        labelgymName.text = memberShipDetails.gymName
    }
}
