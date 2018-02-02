//
//  GymMembershipInfo.swift
//  GymShim


import UIKit

class GymMembershipInfo: NSObject {

    var sortedArrayMembership = [GymMembership]()
    
   
    /// This method is used to get gym name from response model
    ///
    /// - parameter indexPath: tableIndexPath
    ///
    /// - returns: gymName
    func displayGymName(indexPath:NSIndexPath)->String{
        return sortedArrayMembership[indexPath.row].gymName
    }
    
    /*
    func displayGymActivity(indexPath:NSIndexPath)->String{
        print("Needs to be Implemented After WS CHnages are done")
    }
 */

    /// This method is used to get memberShipStartDate from response model
    ///
    /// - parameter indexPath: tableIndexPath
    ///
    /// - returns: memberShipStartDate
    func displayStartDate(indexPath:NSIndexPath)->String{
        return sortedArrayMembership[indexPath.row].memberShipStartDate
    }
    
    /// This method is used to get memberShipEndDate from response model
    ///
    /// - parameter indexPath: tableIndexPath
    ///
    /// - returns: memberShipEndDate
    func displayEndDate(indexPath:NSIndexPath)->String{
        return sortedArrayMembership[indexPath.row].memberShipEndDate
    }
    
    /// This method is used to get memberShipSessions from response model
    ///
    /// - parameter indexPath: tableIndexPath
    ///
    /// - returns: total Sessions
    func displayTotalSession(indexPath:NSIndexPath)->String{
        return String(sortedArrayMembership[indexPath.row].memberShipSessions)
    }
    

    /// This method is used to get memberShipRemainingSessions from response model
    ///
    /// - parameter indexPath: tableIndexPath
    ///
    /// - returns: remainingSessions
    func displayRemainingSessions(indexPath:NSIndexPath)->String{
        return  String(sortedArrayMembership[indexPath.row].memberShipRemainingSessions)
    }
}
