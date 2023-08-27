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
            .whereField("user", isEqualTo: currentUid ?? "0")
            .order(by: "transactionDate", descending: true)
            .getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.transactionList = snapshot.documents.map { d in
                            return TransactionStatistics(id: d.documentID,
                                                         title: d["title"] as? String ?? "",
                                                         amount: d["amount"] as? Double ?? 0,
                                                         type: d["type"] as? String ?? "")
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
    
    func getPieChartData() -> [Double] {
        var totalIncome: Double = 0
        var totalExpense: Double = 0
        
        for transaction in transactionList {
            if transaction.type == "Income" {
                totalIncome += transaction.amount
            } else if transaction.type == "Expense" {
                totalExpense += transaction.amount
            }
        }
        
        return [totalIncome, totalExpense]
    }
        
    func getExpenseData() {
        let db = Firestore.firestore()
        
        let currentUid = Auth.auth().currentUser?.uid
        
        db.collection("transactions")
            .whereField("user", isEqualTo: currentUid ?? "0")
            .order(by: "transactionDate", descending: true)
            .getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.transactionExpenseList = snapshot.documents.map { d in
                            return TransactionStatistics(id: d.documentID,
                                                         title: d["title"] as? String ?? "",
                                                         amount: d["amount"] as? Double ?? 0,
                                                         type: d["type"] as? String ?? "")
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
