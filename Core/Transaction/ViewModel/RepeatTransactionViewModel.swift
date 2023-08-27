//
//  RepeatTransactionViewModel.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/26/23.
//

import Foundation
import Combine
import FirebaseFirestore

class RepeatTransactionViewModel:ObservableObject{
    
@Published var repTransaction: RepeatTransaction
@Published var modified = false
@Published var categories = [Category]()

private var listenerRegistration: ListenerRegistration?
    var docIdsArr = [String]()
  

private var cancellables = Set<AnyCancellable>()

    init(repTransaction: RepeatTransaction = RepeatTransaction(repTransId: "",title: "",  comment: "", amount: 0.00, startDate: Date.now, endDate: Date.now, frequency: "", type: "", category: "", user: "")){
    self.repTransaction = repTransaction
    
    self.$repTransaction
        .dropFirst()
        .sink{[weak self] transaction in
            self?.modified = true
        }
        .store(in: &self.cancellables)
}

//Firestore

private var db = Firestore.firestore()

private func addTransaction(_ repTransaction: RepeatTransaction) {
    do {
      let _ = try db.collection("repeatTransactions").addDocument(from: repTransaction)
    }
    catch {
      print(error)
    }
  }
   
private func updateTransaction(_ repTransaction: RepeatTransaction) {
    if let documentId = repTransaction.id {
      do {
        try db.collection("repeatTransactions").document(documentId).setData(from: repTransaction)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddTransaction() {
      repTransaction.user = AuthService().userSession?.uid ?? "";
      
    if let _ = repTransaction.id {
        self.updateTransaction(self.repTransaction)
        updateTransactionFromRepeat(repTrans: repTransaction)
    }
    else {
        repTransaction.repTransId = randomString();
      addTransaction(repTransaction)
        print("Added rep");
      createTransactionsFromRepeat(repTrans: repTransaction)
    }
  }
   
  private func removeTransaction() {
    if let documentId = repTransaction.id {
      db.collection("repeatTransactions").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
    deleteTransactionByRepeat(repTrans: self.repTransaction)
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
    
  
    
    func createTransactionsFromRepeat(repTrans: RepeatTransaction){
        
        print(repTrans.startDate)
        print(Date.now)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
         
        var sdate : Date = dateFormatter.date(from: dateFormatter.string(from: repTrans.startDate)) ?? repTrans.startDate
        var cdate : Date = dateFormatter.date(from: dateFormatter.string(from: Date.now)) ?? Date.now
        var edate : Date = dateFormatter.date(from: dateFormatter.string(from: repTrans.endDate)) ?? repTrans.endDate
        
        print(sdate)
        print(cdate)
        
        if(sdate <= cdate && edate >= cdate){
            
            var dayCount = Calendar.current.dateComponents([.day], from: repTrans.startDate, to: Date.now).day! + 1
            
            switch(repTrans.frequency){
            
            case "Daily" :
                var day = repTrans.startDate
                
                for i in 1...dayCount{
                    var transacton = Transaction(title: repTrans.title, comment: repTrans.comment, amount: repTrans.amount, transactionDate: day, type: repTrans.type, category: repTrans.category, user: repTrans.user, recurringTransRef: repTrans.repTransId)
                    
                    
                    var transVM = TransactionViewModel(transaction: transacton)
                    print("\(transacton.title) - \(transacton.category) - \(transacton.recurringTransRef) - \(transacton.user)");
                    transVM.addTransaction(transacton)
                    
                    day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
                 }
                break;
            
            case "Weekly":
                var weekCount : Int = dayCount/7;
                var remainder : Int = dayCount%7;
                
                if(remainder != 0){
                    weekCount = weekCount+1
                }
                
                var day = repTrans.startDate
                
                for i in 1...weekCount{
                    var transacton = Transaction(title: repTrans.title, comment: repTrans.comment, amount: repTrans.amount, transactionDate: day, type: repTrans.type, category: repTrans.category, user: repTrans.user, recurringTransRef: repTrans.repTransId)
                    
                    var transVM = TransactionViewModel(transaction: transacton)
                    transVM.addTransaction(transacton)
                    
                    day = Calendar.current.date(byAdding: .day, value: 7, to: day)!
                 }
                break;
                
            case "Monthly":
                
                var day = repTrans.startDate
                
                var dayStartDate = Calendar.current.component(.day, from: day)
                var dayCurrentDate = Calendar.current.component(.day, from: Date.now)
                
                var monthStart = Calendar.current.component(.month, from: day)
                var monthCurr = Calendar.current.component(.month, from: Date.now)
                
                var yearStart = Calendar.current.component(.year, from: day)
                var yearCurr = Calendar.current.component(.year, from: Date.now)
                
                var yearCount = yearCurr  - yearStart
                var monthCount = 0;
                
                if(yearCount == 0){
                    if(dayCurrentDate < dayStartDate){
                        monthCount = monthCurr - monthStart
                    }
                    else{
                        monthCount = monthCurr - monthStart + 1
                    }
                }
                else if (yearCount == 1){
                    if(dayCurrentDate < dayStartDate){
                        monthCount = (13 - monthStart) + (monthCurr - 1)
                    }
                    else{
                        monthCount = (13 - monthStart) + monthCurr
                    }
                }
                else{
                    if(dayCurrentDate < dayStartDate){
                        monthCount =  (12 * (yearCount - 1)) + (13 - monthStart) + (monthCurr - 1)
                    }
                    else{
                        monthCount =  (12 * (yearCount - 1)) + (13 - monthStart) + monthCurr
                    }
                }
                
                for i in 1...monthCount{
                    var transacton = Transaction(title: repTrans.title, comment: repTrans.comment, amount: repTrans.amount, transactionDate: day, type: repTrans.type, category: repTrans.category, user: repTrans.user, recurringTransRef: repTrans.repTransId)
                    
                    var transVM = TransactionViewModel(transaction: transacton)
                    transVM.addTransaction(transacton)
                    
                    day = Calendar.current.date(byAdding: .month, value: i, to: repTrans.startDate)!
                 }
                break;
            case "Yearly":
                
                var day = repTrans.startDate
                var currDate = Date.now
                
                var dayStartDate = Calendar.current.component(.day, from: day)
                var dayCurrentDate = Calendar.current.component(.day, from: Date.now)
                
                var monthStart = Calendar.current.component(.month, from: day)
                var monthCurr = Calendar.current.component(.month, from: Date.now)
                
                var yearStart = Calendar.current.component(.year, from: day)
                var yearCurr = Calendar.current.component(.year, from: Date.now)
                
                var yearCount = yearCurr  - yearStart
                var monthCount = 0;
                
                if(yearCount == 0){
                    if(monthStart <= monthCurr && dayStartDate <= dayCurrentDate){
                        yearCount = 1
                    }
                    else{
                        yearCount = 0
                    }
                }
                else if (yearCount > 0){
                    if(monthStart <= monthCurr && dayStartDate <= dayCurrentDate){
                        yearCount = yearCount + 1
                    }
                }
                
                
                for i in 1...yearCount{
                    var transacton = Transaction(title: repTrans.title, comment: repTrans.comment, amount: repTrans.amount, transactionDate: day, type: repTrans.type, category: repTrans.category, user: repTrans.user, recurringTransRef: repTrans.repTransId)
                    
                    var transVM = TransactionViewModel(transaction: transacton)
                    transVM.addTransaction(transacton)
                    
                    day = Calendar.current.date(byAdding: .year, value: i, to: repTrans.startDate)!
                 }
                break;
            default:
                break;
            }
            
            
        }
        
    }
    
    func deleteTransactionByRepeat(repTrans: RepeatTransaction){
        
        db.collection("transactions").whereField("recurringTransRef", isEqualTo: repTrans.repTransId).whereField("user", isEqualTo: AuthService().userSession?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //var id = document[document.] as? String ?? "";
                    print("Deleting")
                    self.db.collection("transactions").document(document.documentID).delete { error in
                        if let error = error {
                            
                            print(error.localizedDescription)
                        }
                    }
                }
                
            }
            
        }
        
        
    }
    
    func updateTransactionFromRepeat(repTrans: RepeatTransaction){
        
        getDocIdsToDelete(repTrans: repTrans)
        
        
        
        createTransactionsFromRepeat(repTrans: repTrans)
    }
    
    func getDocIdsToDelete(repTrans: RepeatTransaction){
        
        
        listenerRegistration = db.collection("transactions").whereField("recurringTransRef", isEqualTo: repTrans.repTransId).whereField("user", isEqualTo: AuthService().userSession?.uid).addSnapshotListener(){(querySnapshot, err) in 
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in querySnapshot!.documents {
                        print("document.documentID : \(document.documentID)")
                        self.db.collection("transactions").document(document.documentID).delete { error in
                                if let error = error {
                                    
                                    print(error.localizedDescription)
                                }
                            }
                            
                        
                    }
                    self.listenerRegistration?.remove();
                    
                 }
                
        }
        
        
    }
    
    func randomString() -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<36).map{ _ in letters.randomElement()! })
    }
    
}



