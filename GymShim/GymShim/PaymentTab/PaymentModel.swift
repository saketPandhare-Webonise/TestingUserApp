//
//  PaymentModel.swift
//  GymShim

import UIKit
import ObjectMapper


class UserPaymentModel: Mappable {
    var dictionaryPayments = PaymentModel()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        dictionaryPayments <- map[PaymentParsingConstant.USER]
    }
}

class PaymentModel: Mappable {
    
    var dictionaryPaymentData = PaymentDataInfo()
   
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        dictionaryPaymentData <- map[PaymentParsingConstant.PAYMENTS]
    }
}

class PaymentDataInfo: Mappable {
    var arrayPendingPayment = [PaymentData]()
    var arrayCompletedPayment = [PaymentData]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        arrayPendingPayment <- map[PaymentParsingConstant.PENDING]
        arrayCompletedPayment <- map[PaymentParsingConstant.COMPLETED]
    }

}

class PaymentData: Mappable {
    
    var gymName: String = ""
    var invoiceNumber: String = ""
    var totalAmount: String = ""
    var paidAmount: String = ""
    var balanceAmount: String = ""
    var dueDate: String = ""
    var paidDate: String = ""
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        gymName <- map[PaymentParsingConstant.GYM_NAME]
        invoiceNumber <- map [PaymentParsingConstant.INVOICE_NO]
        totalAmount <- map[PaymentParsingConstant.TOTAL_AMOUNT]
        paidAmount <- map[PaymentParsingConstant.PAID_AMOUNT]
        balanceAmount <- map[PaymentParsingConstant.BALANCE_AMOUNT]
        dueDate <- map[PaymentParsingConstant.DUE_DATE]
        paidDate <- map[PaymentParsingConstant.PAID_DATE]
    }
}

class CompletedPayment: Mappable {
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
    }
    
}
