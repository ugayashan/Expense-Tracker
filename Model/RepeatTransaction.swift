//
//  RepeatTransaction.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/26/23.
//

import Foundation
import FirebaseFirestoreSwift

struct RepeatTransaction: Identifiable, Codable{
    @DocumentID var id: String?
    var repTransId : String
    var title : String
    var comment: String
    var amount: Double
    var startDate : Date
    var endDate : Date
    var frequency : String
    var type : String
    var category : String
    var user : String
    
    
    
    enum CodingKeys: String, CodingKey{
        case id
        case repTransId
        case title
        case comment
        case amount
        case startDate
        case endDate
        case frequency
        case type
        case category
        case user
        
    }
}
