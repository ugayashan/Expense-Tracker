//
//  PredictionViewModel.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/25/23.
//

import Firebase
import FirebaseFirestoreSwift

class PredictionViewModel: ObservableObject{
    @Published var transactions = [Prediction]()
    @Published var isNextMonth: Bool = false
    
    @Published var totalIncome: String = ""
    @Published var totalExpense: String = ""
    @Published var isLoading: Bool = true
    init(){
        Task {
            try await fetchTransactions(for: Date())
        }
    }

    @MainActor
    func fetchTransactions(for selectedDate: Date) async throws {
        let currentDate = Date() // Get the current date
        let calendar = Calendar.current
        
        // Get the current year and month components
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        
        // Calculate the first day of the selected date's month
        let components = calendar.dateComponents([.year, .month], from: selectedDate)
        guard let selectedMonthFirstDay = calendar.date(from: components) else {
            throw NSError(domain: "gayashan.com", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to calculate selectedMonthFirstDay"])
        }
        // Simulate a 3-second delay
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000) // 3 seconds in nanoseconds
        self.transactions = try await PredictionService.fetchTransactions()
        isLoading = false
        // Calculate the first day of the previous month
        if let lastMonthFirstDay = calendar.date(from: DateComponents(year: currentYear, month: currentMonth - 1, day: 1)) {
            // Filter transactions for the last month
            
            let lastMonthTransactions = self.transactions.filter { transaction in
                
                let transactionDate = date1(from: transaction.transactionDate)
                    return calendar.isDate(transactionDate, inSameDayAs: lastMonthFirstDay) || transactionDate > lastMonthFirstDay
            }
            // Calculate the days difference
            let daysDifference = calendar.dateComponents([.day], from: selectedMonthFirstDay, to: selectedDate).day ?? 0
            // Calculate mean values only if there's data for the last month
            if !lastMonthTransactions.isEmpty {
                let lastMonthIncomeMean = calculateMean(transactions: lastMonthTransactions.filter { $0.type == "Income" })
                let lastMonthExpenseMean = calculateMean(transactions: lastMonthTransactions.filter { $0.type == "Expense" })
                
                let totalIncomePred = lastMonthIncomeMean * Double(daysDifference)
                let totalExpensePred = lastMonthExpenseMean * Double(daysDifference)
                
                // Format the calculated values with two decimal places
                self.totalIncome = String(format: "%.2f", totalIncomePred)
                self.totalExpense = String(format: "%.2f", totalExpensePred)
                
                print("DEBUG: Total Income for \(daysDifference) days: \(totalIncome)")
                print("DEBUG: Total Expense for \(daysDifference) days: \(totalExpense)")
                
//                print("DEBUG: Income :\(lastMonthIncomeMean) while Expense \(lastMonthExpenseMean) and UID is\(Auth.auth().currentUser?.uid)")
            }
        } else {
            print("Could not calculate the first day of the previous month.")
        }
    }

    // Convert Timestamp to Date
    func date1(from timestamp: Timestamp) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp.seconds))
    }
    
    func calculateMean(transactions: [Prediction]) -> Double {
        
        guard !transactions.isEmpty else {
            return 0.0 // Return 0 if there are no transactions
        }
        
        let totalAmount = transactions.reduce(0.0) { $0 + (Double($1.amount) ?? 0.0) }
        let mean = totalAmount / Double(transactions.count)
        return mean
    }
    
    func isDateInNextMonth(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
        
        _ = calendar.dateComponents([.year, .month], from: currentDate)
        let componentsSelected = calendar.dateComponents([.year, .month], from: date)
        let componentsNextMonth = calendar.dateComponents([.year, .month], from: nextMonthDate)
        
        return componentsSelected.year == componentsNextMonth.year && componentsSelected.month == componentsNextMonth.month
    }
    
}
