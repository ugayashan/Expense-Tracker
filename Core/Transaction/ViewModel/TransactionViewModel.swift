//
//  TransactionViewModel.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/16/23.
//

import Foundation
import Combine
import FirebaseFirestore

class TransactionViewModel:ObservableObject{
    
    @Published var transaction: Transaction
    @Published var modified = false
    @Published var categories = [Category]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(transaction: Transaction = Transaction(title: "", comment: "", amount: 0.00, transactionDate: Date.now, type: "", category: "", user: "", recurringTransRef: "")){
        self.transaction = transaction
        
        self.$transaction
            .dropFirst()
            .sink{[weak self] transaction in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    //Firestore
    
    private var db = Firestore.firestore()
    
    func addTransaction(_ transaction: Transaction) {
        do {
            print("adding transaction to table")
          let _ = try db.collection("transactions").addDocument(from: transaction)
        }
        catch {
            print("error")
          print(error)
        }
      }
       
    func updateTransaction(_ transaction: Transaction) {
        if let documentId = transaction.id {
          do {
            try db.collection("transactions").document(documentId).setData(from: transaction)
          }
          catch {
            print(error)
          }
        }
      }
       
      private func updateOrAddTransaction() {
          transaction.user = AuthService().userSession?.uid ?? "";
          transaction.recurringTransRef = "";
        if let _ = transaction.id {
            self.updateTransaction(self.transaction)
        }
        else {
          addTransaction(transaction)
        }
      }
       
      func removeTransaction() {
        if let documentId = transaction.id {
          db.collection("transactions").document(documentId).delete { error in
            if let error = error {
              print(error.localizedDescription)
            }
          }
        }
      }
       
      func handleDoneTapped() {
          self.updateOrAddTransaction()
      }
       
      func handleDeleteTapped() {
          self.removeTransaction()
      }
    
    func fetchCategories(_ transType: String){
        var name : String = ""
        var type : String = ""
        var id : String = ""
        var image : String = ""
        var uid : String = ""
        db.collection("category").whereField("catType", isEqualTo: transType).whereField("userid", isEqualTo: AuthService().userSession?.uid)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        id = document["catId"] as? String ?? "";
                        name = document["catName"] as? String ?? "";
                        type = document["catType"] as? String ?? "";
                        image = document["catImage"] as? String ?? "";
                        uid = document["userid"] as? String ?? "";
                        var category =  Category(catId: id, catName: name, catType: type, catImage: image, userid: uid);
                        self.categories.append(category);
                        print("\(category.catName)")
                    }
                    
                }
        }
        //return categories;
    }
}

