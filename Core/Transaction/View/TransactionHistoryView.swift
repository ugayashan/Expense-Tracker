//
//  TransactionHistoryView.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/17/23.
//

import SwiftUI

extension Date {
    
    static func from(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? Date()
    }
    
}
struct TransactionHistoryView: View {
    @StateObject var viewModel =  TransactionHistoryViewModel()
    @State var presentAddBookSheet = false
    
    @State private var selectedDate: Date = Date();
    @State private var filteredTrans: [Transaction] = []
    @State private var searchText = String();
    @State private var dateChanged =  false
    
    @State var openingMainView : Bool = false;
    @Environment(\.isSearching) var isSearching: Bool
    @State var presentEditTransactionSheet = false
    
    var newViewModel : TransactionHistoryViewModel = TransactionHistoryViewModel();
    
  
    
    var searchResults:[Transaction]{
        
        if searchText.isEmpty{
            return viewModel.transactions
        }
        else {
                return viewModel.transactions.filter {$0.title.hasPrefix(searchText)}
        }
        
    }
    
   
    
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
    
    private func searchButton(action: @escaping () -> Void) -> some View{
        Button(action: { action() }) {
            Text("Go")
        }
    }
    var body: some View {
        
        
        TabView{
            
            NavigationView{
                
                
                VStack{
                    Section{
                        HStack{
                            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            /*Button("Clear"){
                                self.viewModel.subscribe()
                                filteredTrans = self.viewModel.transactions
                                dateChanged.toggle()
                            }*/
                            searchButton{
                                filteredTrans = viewModel.transactions.filter{
                                    Calendar.current.compare($0.transactionDate, to: selectedDate, toGranularity: .day) == .orderedSame
                                }
                                self.presentEditTransactionSheet.toggle()
                            }
                            
                            
                            
                        }.padding(.leading)
                            .padding(.trailing)
                        
                        
                    }
                    
                    ZStack(alignment: .bottomTrailing){
                        
                        
                        
                            List{
                                ForEach (searchResults){ transaction in
                                    transactionRowView(transaction: transaction)
                                }
                            }
                            .navigationBarTitle("Transactions")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarItems(trailing: repeatButton)
                            .navigationBarItems(leading: signOutButton)
                            .onAppear(){
                                print("TransactionsListView Appears. Subscribing to data updates.")
                                self.viewModel.subscribe()
                                filteredTrans = self.viewModel.transactions
                            
                                
                                
                            }
                            .onChange(of: selectedDate){
                                value in
                                print("date changed")
                                filteredTrans = viewModel.transactions.filter{
                                    Calendar.current.compare($0.transactionDate, to: selectedDate, toGranularity: .day) == .orderedSame
                                }
                                print("\(selectedDate)")
                                print("\(filteredTrans[0].title)")
                                
                                newViewModel.transactions = filteredTrans
                                
                                
                            }.sheet(isPresented: self.$presentEditTransactionSheet){
                                TransactionDateSearchView(viewModel: newViewModel).presentationDetents([.height(600), .large])
                        }
                        
                        
                        addButton.padding()
                        
                    }
                }
                
                
            }.searchable(text: $searchText)
        }
        
        
    }
            
        }
    
    func showRepeatTransView() {
      RepeatTransactionsListView()
    }

func groupByDate(_ transactions: [Transaction]) -> [(Date, [Transaction])] {
    let grouped = Dictionary(grouping: transactions, by: { $0.transactionDate})
        return grouped.sorted(by: { $0.key < $1.key })
    }



struct RepeatTransactionsListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView()
    }
}



