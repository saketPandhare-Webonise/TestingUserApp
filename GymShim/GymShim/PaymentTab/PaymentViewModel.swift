//
//  PaymentViewModel.swift
//  GymShim

import UIKit
import ObjectMapper

protocol PaymentAPIDelegate {
    /// Delegate method which will get fire after receiving dat from server
    func didReveivePaymentData()
}

class PaymentViewModel: NSObject {

    var userPaymentModel: UserPaymentModel = UserPaymentModel()
    var isCompletedTabSelected: Bool = false
    var paymentAPIDelegate: PaymentAPIDelegate?
    
    /// This function is used to get payment data
    func getPaymentData() {
        if (!userLoginToken.isEmpty) {
        let requestParameters = [RequestParameters.AUTH_TOKEN : userLoginToken]
        WebserviceHandler().callWebService(WebServiceUrls.PAYMENT_INFO(), methodType: WebServiceType.GET, parameters: requestParameters, succeess: {
             (response, headerFields) in
            self.mapResponseToModel(response)
            self.paymentAPIDelegate?.didReveivePaymentData()
            }, failure: { (error) in
        })
      }
    }
    
    /// This function is used to map reponse to model
    /// Parameters: response from server
    func mapResponseToModel(response: AnyObject?) {
        userPaymentModel = Mapper<UserPaymentModel>().map(response)!
    }

    /// This function is used to get number of rows for paymentTableview
    /// return: array count
    func getNumberOfRows() -> Int {
        return (isCompletedTabSelected) ? userPaymentModel.dictionaryPayments.dictionaryPaymentData.arrayCompletedPayment.count :
            userPaymentModel.dictionaryPayments.dictionaryPaymentData.arrayPendingPayment.count
    }
}
