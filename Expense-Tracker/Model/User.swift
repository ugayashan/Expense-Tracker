//
//  User.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/23/23.
//

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
