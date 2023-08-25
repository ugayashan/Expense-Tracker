//
//  TransactionDetailView.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/16/23.
//

import SwiftUI

struct TransactionDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditTransactionSheet = false
    
    var transaction: Transaction
    
    private func editButton(action: @escaping () -> Void) -> some View{
        Button(action: { action() }) {
            Text("Edit")
        }
    }
    
    var body: some View {
        Form{
            Section(header: Text("Transaction")){
                Text(transaction.title)
                Text(transaction.comment)
            }
            Section(header: Text("Date")){
                Text("\(transaction.transactionDate, style: .date)")
               
            }
            .navigationBarTitle(transaction.title)
            .navigationBarItems(trailing: editButton {
                self.presentEditTransactionSheet.toggle()
            })
            .onAppear(){
                print("TransactonDetailView.onAppear() for \(self.transaction.title)")
            }
            .onDisappear(){
                print("TransactonDetailView.onDisappear()")
            }
            /*.sheet(isPresented: self.$presentEditTransactionSheet){
                TransactionEditView(viewModel: TransactionViewModel(transaction: transaction), mode: .edit) { result in
                        if case .success(let action) = result, action == .delete {
                          self.presentationMode.wrappedValue.dismiss()
                        }
                      }
            }*/
            .fullScreenCover(isPresented: self.$presentEditTransactionSheet){
                TransactionEditView(viewModel: TransactionViewModel(transaction: transaction), mode: .edit) { result in
                        if case .success(let action) = result, action == .delete {
                          self.presentationMode.wrappedValue.dismiss()
                        }
                      }
            }
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let transaction = Transaction(title: "sample", comment: "sample", amount: 1000.00, transactionDate: Date.now, type: "sample", category:"", user: "Sanjani", recurringTransRef: "")
        return
            NavigationView{
                TransactionDetailView(transaction: transaction)
            }
        
    }
}
