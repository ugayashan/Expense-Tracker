//
//  Transaction.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/16/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Transaction: Identifiable, Codable{
    @DocumentID var id: String?
    var title : String
    var comment: String
    var amount: Double
    var transactionDate : Date
    var type : String
    var category : String
    var user : String
    var recurringTransRef : String
    
    
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case comment
        case amount
        case transactionDate
        case type
        case category
        case user
        case recurringTransRef
    }
}
