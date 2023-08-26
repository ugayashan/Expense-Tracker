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
                Image(systemName: "plus").foregroundColor(.white)
                //Text("Transactions")
            }.font(.title2.weight(.semibold))
            
                .padding()

                .background(Color.blue)

                .foregroundColor(.white)

                .clipShape(Circle())
            
            
            
            
            
        }
        
        
        
        
    
    
    private var repeatButton: some View{
        
        NavigationLink(destination: RepeatTransactionsListView()) {
            Image(systemName: "repeat")
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
           
                
                TabView{
                    
                        NavigationView{
                            ZStack(alignment: .bottomTrailing){
                            
                                List{
                                    ForEach (viewModel.transactions){ transaction in
                                        transactionRowView(transaction: transaction)
                                    }
                                }
                                .navigationBarTitle("Transactions")
                                .navigationBarItems(trailing: repeatButton)
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
                            addButton.padding()
                            
                        }
                        
                    }
                }
                
            
            
            
        }
    
    func showRepeatTransView() {
      RepeatTransactionsListView()
    }}



struct RepeatTransactionsListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView()
    }
}



