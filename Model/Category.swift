//
//  Category.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/24/23.
//

import Foundation

import Foundation
import FirebaseFirestoreSwift

struct Category: Identifiable, Codable, Hashable{
    let id = UUID()
    let catId : String
    let catName : String
    let catType: String
    let catImage : String
    var userid :String?
    
    
    
    
}
