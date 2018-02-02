    //
    //  GymScheduleTableCell.swift
    //  GymShim
    
    
    import UIKit
    
    class GymScheduleTableCell: UITableViewCell {
        
        
        @IBOutlet weak var labelScheduleTime: UILabel!
        @IBOutlet weak var labelScheduleType: UILabel!
        @IBOutlet weak var labelTrainerName: UILabel!
        
        var trainerNameArray = [String]()
        var trainerNames: String = ""
        var scheduleData = GymScheduleInfo() {
            didSet {
                setGymScheduleData()
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        func setGymScheduleData() {
            labelScheduleTime.text = scheduleData.time
            labelScheduleType.text = scheduleData.activityName
            scheduleData.arrayListTrainers.count
            setTrainerData()
        }
        
        func setTrainerData() {
            if (!scheduleData.arrayListTrainers.isEmpty) {
                for i in 0...scheduleData.arrayListTrainers.count - 1 {
                    trainerNameArray.append( scheduleData.arrayListTrainers[i].trainerName)
                }
                trainerNames = trainerNameArray.first!
                labelTrainerName.text = trainerNames
            }
        }
    }
