//
//  TransactionHistoryView.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/17/23.
//

import SwiftUI

struct TransactionHistoryView: View {
    @StateObject var viewModel =  TransactionHistoryViewModel()
    @State var presentAddBookSheet = false
    
    private var addButton: some View{
        Button(action:{ self.presentAddBookSheet.toggle()  }){
            Image(systemName: "plus")
            //Text("Transactions")
        }
        
        
        
    }
    
    private var signOutButton: some View{
        Button(action:{ AuthService.shared.signOut() }){
            Image(systemName: "line.3.horizontal")
            //Text("Transactions")
        }
        
        
        
    }
    
    
    
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
        NavigationView{
            List{
                ForEach (viewModel.transactions){ transaction in
                    transactionRowView(transaction: transaction)
                }
            }
            .navigationBarTitle("Transactions")
            .navigationBarItems(trailing: addButton)
            .navigationBarItems(leading: signOutButton)
            .onAppear(){
                print("TransactionsListView Appears. Subscribing to data updates.")
                self.viewModel.subscribe()
            }
            /*.sheet(isPresented: self.$presentAddBookSheet){
                TransactionEditView()
            }*/
            .fullScreenCover(isPresented: self.$presentAddBookSheet){
                TransactionEditView()
            }
        }
        
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView()
    }
}



