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
    
    var viewModel : TransactionViewModel = TransactionViewModel();
    
    var transaction: Transaction
    
    private func editButton(action: @escaping () -> Void) -> some View{
        Button(action: { action() }) {
            Text("Edit")
        }
    }
    
    var body: some View {
        Form{
            //Section(header: Text("")){
                Text("Title : \(transaction.title)")
                Text("Type: \(transaction.type)")
                Text("Date : \(transaction.transactionDate, style: .date)")
                Text("Amount : \(transaction.amount, specifier: "%.2f")")
                
                /*var catString = getCategoryString(category: transaction.category)
                HStack{
                    Text("Category : ")
                    Image(systemName: catString[1])
                    Text("\(catString[0])")
                }*/
                
                Text("Comments : \(transaction.comment)")
            //}
            
            .navigationBarTitle("")
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
            }/*.navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                    
                    NavigationLink(destination: TransactionHistoryView()) {
                        Image(systemName: "arrow.left")
                                    }
                    
                )*/
        }
    }
    
    func getCategoryString( category : String) -> Array <String> {
        var catString : [String] = ["",""]
        var category : Category = viewModel.getCategory(category)
        
        catString[0] = category.catName
        catString[1] = category.catImage
        
        
        return catString
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let transaction = Transaction(title: "Groceries", comment: "Groceries for June 02 Week", amount: 1000.00, transactionDate: Date.now, type: "sample", category:"Food", user: "Sanjani", recurringTransRef: "")
        return
            NavigationView{
                TransactionDetailView(transaction: transaction)
            }
        
    }
}
