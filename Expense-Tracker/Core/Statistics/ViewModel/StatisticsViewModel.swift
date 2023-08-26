//
//  StatisticsViewModel.swift
//  Expense-Tracker
//
//  Created by user236509 on 8/26/23.
//

import Foundation
import Firebase
import SwiftUICharts

class StatisticsViewModel: ObservableObject {
    
    @Published var transactionList = [TransactionStatistics]()
    @Published var transactionExpenseList = [TransactionStatistics]()
    
    func getData() {
        let db = Firestore.firestore()
        
        let currentUid = Auth.auth().currentUser?.uid
        
        db.collection("transactions")
            .whereField("uid", isEqualTo: currentUid ?? "0")
            .order(by: "transactionDate", descending: true)
            .getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.transactionList = snapshot.documents.map { d in
                            return TransactionStatistics(id: d.documentID,
                                                         title: d["title"] as? String ?? "",
                                                         amount: d["amount"] as? Double ?? 0)
                        }
                    }
                }
            }
        }
    }

    func getChartData() -> ChartData {
        let chartDataValues = transactionList.map { transaction in
            (transaction.title, transaction.amount)
        }
        
        return ChartData(values: chartDataValues)
    }
    
    func getExpenseData() {
        let db = Firestore.firestore()
        
        let currentUid = Auth.auth().currentUser?.uid
        
        db.collection("transactions")
            .whereField("uid", isEqualTo: currentUid ?? "0")
            .order(by: "transactionDate", descending: true)
            .getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.transactionExpenseList = snapshot.documents.map { d in
                            return TransactionStatistics(id: d.documentID,
                                                         title: d["title"] as? String ?? "",
                                                         amount: d["amount"] as? Double ?? 0)
                        }
                    }
                }
            }
        }
    }
    
    func getLineChartData() -> [Double] {
        let chartDataValues = transactionExpenseList.map { transaction in
            transaction.amount
        }

        return chartDataValues
    }

    
}
