//
//  GymScheduleViewModel.swift
//  GymShim
//

import Foundation
import ObjectMapper

protocol ScheduleDataDelegate {
    func setScheduleData()
}

class GymScheduleViewModel {
    
     var scheduleDataDelegate: ScheduleDataDelegate?
     var gymScheduleModel: GymScheduleModel = GymScheduleModel()
    
    /**
     Calls gym schedule api
     */
    func gymScheduleApiCall(memberShipID: String) {
        if (!userLoginToken.isEmpty) {
        let scheduleRequestParameters = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.IMAGE_SIZE:CommonHelper().getDeviceSizeForImage()]
        
        WebserviceHandler().callWebService(WebServiceUrls.GYM_SCHEDULE(memberShipID), methodType: WebServiceType.GET, parameters: scheduleRequestParameters, succeess: { (response, headerFields) in
            //TO-DO: code to be executed on successful call of api
            
            self.mapResponseToModel(response)
            self.scheduleDataDelegate?.setScheduleData()
        }) { (error) in
            //TO-DO: code to be executed on failure of api
        }
      }
    }
    
    
    
    /// This Method is used to Map schedule to its m odel
    ///
    /// - parameter response: response from server
    func mapResponseToModel(response: AnyObject?) {
        self.gymScheduleModel = Mapper<GymScheduleModel>().map(response)!
    }
    
    /// This function is used to get current day send by webservice
    func getCurrentDay() -> Int {
        return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.weekDayNumber
    }
    
    /// This function is used to get Membership number to generate QRCode
    /// return:- membership number
    func getMemberShipNumber() -> String {
        return gymScheduleModel.dictionaryMemberships.membershipNumber
    }
    
    /// This function is used to get Array of GymSchedule for particular day selected
    ///
    /// - parameter selectedDay: selected day by user
    ///
    /// - returns: GymSchedule Info Array
    func getScheduleForSelectedDay(selectedDay: Int) -> [GymScheduleInfo] {
        
        switch selectedDay {
            
            case SelectedDay.SUNDAY:
            return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.dictionaryWeekDaysSchedule.arraySundayGymScheduleInfo
            
            case SelectedDay.MONDAY:
            return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.dictionaryWeekDaysSchedule.arrayMondayGymScheduleInfo
            
            case SelectedDay.TUESDAY:
            return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.dictionaryWeekDaysSchedule.arrayTuesdayGymScheduleInfo
            
            case SelectedDay.WEDNESDAY:
            return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.dictionaryWeekDaysSchedule.arrayWednesdayGymScheduleInfo
            
            case SelectedDay.THURSDAY:
            return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.dictionaryWeekDaysSchedule.arrayThursdayGymScheduleInfo
            
            case SelectedDay.FRIDAY:
            return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.dictionaryWeekDaysSchedule.arrayFridayGymScheduleInfo
            
            case SelectedDay.SATURDAY:
            return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.dictionaryWeekDaysSchedule.arraySaturdayGymScheduleInfo
            
        default:
            break
        }
        return self.gymScheduleModel.dictionaryMemberships.dictionaryGymSchedule.dictionaryWeekDaysSchedule.arraySundayGymScheduleInfo
    }
    
    /// This function is used to get membership number to generate QRCode
    /// return:- membership number
    func getNumberToGenerateQRCode()-> String {
        return gymScheduleModel.dictionaryMemberships.membershipNumber
    }
    
    
    /// this function is used to get GymName
    ///
    /// - returns: gymname
    func getGymName()->String {
        return gymScheduleModel.dictionaryMemberships.gymName
    }
    
    /// This funcion will return plan name associated with gym
    ///
    /// - returns: plan name as string 
    func getGymPlanName()->String {
        return gymScheduleModel.dictionaryMemberships.planName
    }
    /// This function is used to get membership start date
    ///
    /// - returns: membership Start date
    func getMemberShipStartDate()->String {
        return gymScheduleModel.dictionaryMemberships.membershipStartDate
    }
    
    /// This function is used to get membership end date
    ///
    /// - returns: membership end date
    func getMembershipEndDate()->String {
        return gymScheduleModel.dictionaryMemberships.membershipEndDate
    }
    
    /// This function is used to get user total session
    ///
    /// - returns: total sessions
    func getTotalSession()->Int {
        return gymScheduleModel.dictionaryMemberships.membershipTotalSessions
    }
    
    /// This function is used to get user remaining session
    ///
    /// - returns: remaining sessions
    func getRemainingSession()->Int {
        return gymScheduleModel.dictionaryMemberships.membershipRemainingSessions
    }
    
    
    /// This function will check whether pooled membership is present or not
    ///
    /// - returns: bool value
    func isPooledMembershipPresent()->Bool {
        return gymScheduleModel.dictionaryMemberships.isPooledMembershipAvailable
    }
    
    /// This function will return count of pooledmembership array
    ///
    /// - returns: array count value
    func getPooledMembershipArrayCount()->Int {
        return gymScheduleModel.dictionaryMemberships.arrayPooledMembership.count
    }
    /// This function will return first pooled user name
    ///
    /// - returns: username as string
    func getFirstPooledUserName()->String {
        return gymScheduleModel.dictionaryMemberships.arrayPooledMembership[PooledMemberships.firstPooledMember].pooledMemberName
    }
    
    
    /// This function will return first pooled user remaining session
    ///
    /// - returns: remaining session as string
    func getFirstPooledUserRemainingSession() -> Int {
         return gymScheduleModel.dictionaryMemberships.arrayPooledMembership[PooledMemberships.firstPooledMember].pooledRemainingSessions
    }
   
    /// This function will return second pooled user name
    ///
    /// - returns: username as string
    func getSecondPooledUserName() -> String {
        return gymScheduleModel.dictionaryMemberships.arrayPooledMembership[PooledMemberships.secondPooledMember].pooledMemberName
    }
    
    /// This function will return second pooled user remaining session
    ///
    /// - returns: remaining session as string
    func getSecondPooledUserRemainingSession() -> Int {
        return gymScheduleModel.dictionaryMemberships.arrayPooledMembership[PooledMemberships.secondPooledMember].pooledRemainingSessions
    }
    
    /// This function will return third pooled user name
    ///
    /// - returns: username as string
    func getThirdPooledUserName() -> String {
        return gymScheduleModel.dictionaryMemberships.arrayPooledMembership[PooledMemberships.thirdPooledMember].pooledMemberName
    }
    
    /// This function will return third pooled user remaining session
    ///
    /// - returns: remaining session as string
    func getThirdPooledUserRemainingSession() -> Int {
        return gymScheduleModel.dictionaryMemberships.arrayPooledMembership[PooledMemberships.thirdPooledMember].pooledRemainingSessions
    }
}
