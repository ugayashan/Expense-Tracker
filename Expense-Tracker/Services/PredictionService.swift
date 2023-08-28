//
//  PredictionService.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/25/23.
//

import Firebase
import FirebaseFirestoreSwift


class PredictionService: ObservableObject {
    
//    let selectedDate = Timestamp(date: selectedDate)
    
    static func fetchTransactions() async throws -> [Prediction] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return[] }
        let snapshot = try await Firestore
            .firestore()
            .collection("transactions")
            .whereField("uid", isEqualTo: currentUid)
            .order(by: "transactionDate", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Prediction.self) })
    }
}
