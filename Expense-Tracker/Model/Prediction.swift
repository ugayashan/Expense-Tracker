//
//  Prediction.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/25/23.
//
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Prediction: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    let amount: String
    let category: String
    let comment: String
    let title: String
    let transactionDate: Timestamp
    let type: String
    let uid: String
}
