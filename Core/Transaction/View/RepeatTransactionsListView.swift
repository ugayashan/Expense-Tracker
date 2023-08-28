//
//  RepeatTransactionsListView.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/26/23.
//

import SwiftUI

struct RepeatTransactionsListView: View {
    @StateObject var viewModel =  RepeatTransactionsListViewModel()
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
    
   /* private var repeatButton: some View{
        
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
    
    */
    
    private func transactionRowView(repTransaction: RepeatTransaction) -> some View{
        NavigationLink(destination: RepeatTransactionDetailView(repTransaction: repTransaction)){
            VStack(alignment: .leading){
                Text(repTransaction.title)
                    .font(.headline)
                Text(repTransaction.comment)
                    .font(.subheadline)
                Text("\(repTransaction.amount,specifier: "%.2f")")
                    .font(.subheadline)
                Text("\(repTransaction.startDate,  style: .date)")
                    .font(.subheadline)
                Text(repTransaction.type)
                    .font(.subheadline)
            }
        }
    }
    var body: some View {
       
            
            
                
                        
                        ZStack(alignment: .bottomTrailing){
                            Text("Repeat Transactions")
                            List{
                                ForEach (viewModel.repTransactions){ repTransaction in
                                    transactionRowView(repTransaction: repTransaction)
                                }
                            }
                            .navigationBarTitle("Repeat Transactions")
                            /*.navigationBarItems(trailing: repeatButton)
                            .navigationBarItems(leading: signOutButton)*/
                            .onAppear(){
                                print("TransactionsListView Appears. Subscribing to data updates.")
                                self.viewModel.subscribe()
                            }
                            
                            
                            /*.sheet(isPresented: self.$presentAddBookSheet){
                                TransactionEditView()
                            }*/
                            .fullScreenCover(isPresented: self.$presentAddBookSheet){
                                RepeatTransactionEditView()
                            }
                        addButton.padding()
                        
                    
                    
                }
            
            
        
        
        
    }
    
    func showRepeatTransView() {
      RepeatTransactionsListView()
    }}



struct RepeatTransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        RepeatTransactionsListView()
    }
}
