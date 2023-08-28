//
//  RepeatTransactionEditView.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/26/23.
//

import SwiftUI




struct RepeatTransactionEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @State private var date = Date()
    
    @ObservedObject var viewModel = RepeatTransactionViewModel()
    @State var selection = ""
    @State var errorMsg : String = ""
    
    
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
          Text("Cancel")
        }
      }
       
      var saveButton: some View {
        Button(action: { self.handleDoneTapped() }) {
          Text(mode == .new ? "Done" : "Save")
        }
        .disabled(!viewModel.modified)
      }
    
    var body: some View {
        NavigationView{
            
            Form{
                let amountFormatter: NumberFormatter = {
                    let formatter = NumberFormatter()
                    formatter.zeroSymbol = ""
                    return formatter
                }()
                
                
                
                Section{
                    
                    
                    
                }
                Section(header: Text("")){
                    Picker(selection: $selection, label: Text("Income/Expense")) {
                        Text("Income").tag("Income")
                        Text("Expense").tag("Expense")
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selection){ tag in
                        self.viewModel.categories.removeAll();
                        self.viewModel.fetchCategories(selection)
                     }
                    .onAppear(){
                        selection = self.viewModel.repTransaction.type
                        if(selection.isEmpty){
                            selection = "Income";
                        }
                    }
                    Spacer()
                    HStack {
                        Text("Title : ")
                        TextField("", text: $viewModel.repTransaction.title)
                    }
                    
                    Picker(selection: $viewModel.repTransaction.category, label: Text("Category : ")/*.foregroundColor(Color(UIColor.darkGray))*/) {
                        /*ForEach(self.viewModel.categories){ category in
                            
                            Text(category.name).tag(category.name)
                            //print("***** \(category.name)")
                        }*/
                        ForEach(self.viewModel.categories, id: \.self) { category in // <-- notice the use of id
                            HStack {
                                Image(systemName: category.catImage)
                                Text(category.catName)
                                                    }.tag(category.catId)
                                        }
                    }
                
                    
                    /*DatePicker("Transaction Date", selection: $date , displayedComponents: [.date])*/
                    
                    /*TransDatePicker(date: $viewModel.transaction.transactionDate)*/
                                        DatePicker("Start Date : ",
                                                   selection: $viewModel.repTransaction.startDate,
                                                   displayedComponents: [.date])
                    
                    DatePicker("End Date : ",
                               selection: $viewModel.repTransaction.endDate,
                               displayedComponents: [.date])
                    
                    Picker(selection: $viewModel.repTransaction.frequency, label: Text("Frequency")) {
                        Text("Daily").tag("Daily")
                        Text("Weekly").tag("Weekly")
                        Text("Monthly").tag("Monthly")
                        Text("Yearly").tag("Yearly")
                    }
                    
                    HStack {
                        Text("Amount : ")
                        TextField("", value: $viewModel.repTransaction.amount, formatter: amountFormatter)
                    }
                    
                    HStack {
                        Text("Comments : ")
                        TextField("", text: $viewModel.repTransaction.comment)
                    }
                    
                    
                    
                       
                    /*
                    
                    TextField("Transaction Date", value: $viewModel.transaction.transactionDate, format: .dateTime)
                    */
                    
                }
                
                /*Section(header: Text("Transaction")){
                    Text("Name").font(.headline)
                    TextField("Title", text: $viewModel.transaction.title)
                    
                    
                }*/
                
                
                
                
                if mode == .edit{
                    Section{
                        Button("Delete"){ self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(mode == .new ? "New Repeat Transaction" : "Edit Repeat Transaction")
            .navigationBarTitleDisplayMode(mode == .new ? .inline: .inline)
            .navigationBarItems(
                leading: cancelButton, trailing: saveButton)
            .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(title: Text("Are you sure?"),
                                buttons: [
                                  .destructive(Text("Delete transaction"),
                                               action: { self.handleDeleteTapped() }),
                                  .cancel()
                                ])
                  }
            .alert(isPresented: $viewModel.showErrorMessage) {
                Alert(title: Text("Error"), message: Text(self.errorMsg), dismissButton: .cancel())
                            }
            
            
        }
    }
    
    func handleCancelTapped() {
        self.dismiss()
      }
       
      func handleDoneTapped() {
          self.viewModel.repTransaction.type = selection
          
          if(self.viewModel.repTransaction.title.isEmpty || self.viewModel.repTransaction.category.isEmpty ||
             self.viewModel.repTransaction.amount == nil ||
             self.viewModel.repTransaction.frequency.isEmpty
          ){
              errorMsg = "Please fill Title, Category, Amount and Frequency"
              viewModel.showErrorMessage.toggle()
          }
          else if (self.viewModel.repTransaction.startDate > self.viewModel.repTransaction.endDate){
              errorMsg = "Start Date should be earlier than the End Date"
              viewModel.showErrorMessage.toggle()
          }
          else{
              self.viewModel.handleDoneTapped()
              self.dismiss()
          }
      }
       
      func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
      }
       
      func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
      }
    
}

struct RepeatTransactionEditView_Previews: PreviewProvider {
    static var previews: some View {
        RepeatTransactionEditView()
    }
}
