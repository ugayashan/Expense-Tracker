//
//  TransactionDateSearchView.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/28/23.
//

import SwiftUI

struct TransactionDateSearchView: View {
    
    @StateObject var viewModel =  TransactionHistoryViewModel()
    
    
    
    
    private func transactionRowView(transaction: Transaction) -> some View{
        NavigationLink(destination: TransactionDetailView(transaction: transaction)){
            VStack(alignment: .leading){
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.comment)
                    .font(.subheadline)
                Text("\(transaction.amount,specifier: "%.2f")")
                    .font(.subheadline)
                Text("\(transaction.transactionDate,  style: .date)")
                    .font(.subheadline)
                Text(transaction.type)
                    .font(.subheadline)
            }
        }
    }
    
    
    var body: some View {
        
        
        TabView{
            
            NavigationView{
                
                ZStack(alignment: .bottomTrailing){
                    
                    
                    List{
                        ForEach (self.viewModel.transactions){ transaction in
                            transactionRowView(transaction: transaction)
                        }
                    }
                    .navigationBarTitle("\(self.viewModel.transactions[0].transactionDate, style: .date)")
                    .navigationBarTitleDisplayMode(.inline)
                    
                    
                    
                    
                    
                }
            }
            
            
        }
    }
    
    
    
}
        
 






struct TransactionDateSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDateSearchView()
    }
}
