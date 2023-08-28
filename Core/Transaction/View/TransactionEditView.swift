//
//  TransactionEditView.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/17/23.
//

import SwiftUI

 enum Mode {
  case new
  case edit
     
}
 
enum Action {
  case delete
  case done
  case cancel
}

struct TransactionEditView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @State private var date = Date()
    
    
    //var transType: String = "Expense"
    //@ObservedObject var categories = getCategories();

    @ObservedObject var viewModel = TransactionViewModel()
    @State var selection = ""
    
    /*init(){
        _selection = State<String>(initialValue: TransactionViewModel().transaction.type)    }*/
    
    
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    //var categories = [Category]();
    
    
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
                
                /*Section{
                    Picker(selection: $viewModel.transaction.type , label: Text("Income/Expense")) {
                        Text("Income").tag("Income")
                        Text("Expense").tag("Expense")
                    }
                    .pickerStyle(.segmented)
                    .onTapGesture (count: 1){
                        self.viewModel.categories.removeAll()
                        self.viewModel.fetchCategories(viewModel.transaction.type)
                    }
                    /*.onChange(of: $viewModel.$transaction.$type){ tag in
                        self.viewModel.categories.removeAll();
                        self.viewModel.fetchCategories(viewModel.transaction.type)
                     }*/
                    
                    
                }*/
                
                Section{
                    
                    
                    
                }
                Section(header: Text("")){
                    Picker(selection: $selection, label: Text("Income/Expense")) {
                        Text("Income").tag("Income")
                        Text("Expense").tag("Expense")
                    }
                    .pickerStyle(.segmented)
                    /*.onTapGesture (count: 1){
                        self.viewModel.categories.removeAll()
                        self.viewModel.fetchCategories(viewModel.transaction.type)
                    }*/
                    .onChange(of: selection){ tag in
                        self.viewModel.categories.removeAll();
                        self.viewModel.fetchCategories(selection)
                     }
                    .onAppear(){
                        selection = self.viewModel.transaction.type
                        if(selection.isEmpty){
                            selection = "Income";
                        }
                    }
                    Spacer()
                    HStack {
                        Text("Title : ")
                        TextField("", text: $viewModel.transaction.title)
                    }/*.foregroundColor(Color(UIColor.darkGray)*/
                    //TextField("Titleee", text: $viewModel.transaction.title)
                    //TextField("Type", text: $viewModel.transaction.type)
                    
                    //.pickerStyle(.segmented)
                    
                    Picker(selection: $viewModel.transaction.category, label: Text("Category : ")/*.foregroundColor(Color(UIColor.darkGray))*/) {
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
                                        DatePicker("Transaction Date : ",
                               selection: $viewModel.transaction.transactionDate,
                                                   displayedComponents: [.date])
                    
                    
                    HStack {
                        Text("Amount : ")
                        TextField("", value: $viewModel.transaction.amount, formatter: amountFormatter)
                    }
                    
                    HStack {
                        Text("Comments : ")
                        TextField("", text: $viewModel.transaction.comment)
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
            .navigationTitle(mode == .new ? "New Transaction" : "Edit Transaction")
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
                Alert(title: Text("Error"), message: Text("Please fill Title, Category and Amount"), dismissButton: .cancel())
                            }
        }
    }
    
    func handleCancelTapped() {
        self.dismiss()
      }
       
      func handleDoneTapped() {
          self.viewModel.transaction.type = selection
          
          if(self.viewModel.transaction.title.isEmpty || self.viewModel.transaction.category.isEmpty ||
             self.viewModel.transaction.amount == nil
          ){
              viewModel.showErrorMessage.toggle()
          }
          else{
              
              self.viewModel.handleDoneTapped()
              self.dismiss()}
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

struct TransactionEditView_Previews: PreviewProvider {
    static var previews: some View {
        let transaction = Transaction(title: "Tution Fees", comment: "Tution Fees for Dance Class", amount: 5000.00, transactionDate: Date.now, type: "Expense", category: "Bills", user: "Sanjani", recurringTransRef: "")
        let transactionViewModel = TransactionViewModel(transaction: transaction)
        return TransactionEditView(viewModel: transactionViewModel, mode: .edit)
        //return TransactionEditView()
    }
}

/*struct TransDatePicker: View {
    @Binding var date : Date //<-- Here
    var body: some View {
        Form {
            DatePicker("Transaction Date",
                       selection: $date,
                       displayedComponents: [.date])
            
        }
    }
}*/

