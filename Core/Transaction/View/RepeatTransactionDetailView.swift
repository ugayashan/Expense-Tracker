//
//  RepeatTransactionDetailView.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/26/23.
//

import SwiftUI

struct RepeatTransactionDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditTransactionSheet = false
    
    var repTransaction: RepeatTransaction
    
    private func editButton(action: @escaping () -> Void) -> some View{
        Button(action: { action() }) {
            Text("Edit")
        }
    }
    
    var body: some View {
        Form{
                Section(header: Text("Transaction")){
                    Text(repTransaction.title)
                    Text(repTransaction.comment)
                }
                Section(header: Text("Start Date")){
                    Text("\(repTransaction.startDate , style: .date)")
                    
                }
                .navigationBarTitle(repTransaction.title)
                .navigationBarItems(trailing: editButton {
                    self.presentEditTransactionSheet.toggle()
                })
                .onAppear(){
                    print("TransactonDetailView.onAppear() for \(self.repTransaction.title)")
                }
                .onDisappear(){
                    print("TransactonDetailView.onDisappear()")
                }
                .fullScreenCover(isPresented: self.$presentEditTransactionSheet){
                    RepeatTransactionEditView(viewModel: RepeatTransactionViewModel( repTransaction: repTransaction), mode: .edit) {
                        result in
                            if case .success(let action) = result, action == .delete {
                              self.presentationMode.wrappedValue.dismiss()
                            }
                          }
                }
        }
    }
}

    struct RepeatTransactionDetailView_Previews: PreviewProvider {
        static var previews: some View {
            let repTransaction = RepeatTransaction(repTransId: "" , title: "sample", comment: "sample", amount: 1000.00, startDate: Date.now, endDate: Date.now, frequency: "", type: "sample", category:"", user: "Sanjani" )
            return
            NavigationView{
                RepeatTransactionDetailView(repTransaction: repTransaction)
            }
            
        }
    }
    

