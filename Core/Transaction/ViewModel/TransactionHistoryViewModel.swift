//
//  TransactionHistoryViewModel.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/16/23.
//

import Foundation
import Combine
import FirebaseFirestore

class TransactionHistoryViewModel: ObservableObject{
    @Published var transactions = [Transaction]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit{
        unsubscribe()
    }
    
    func unsubscribe(){
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func subscribe(){
        if listenerRegistration == nil{
            listenerRegistration =  db.collection("transactions").addSnapshotListener{ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print ("No documents")
                    return
                }
                
                self.transactions =  documents.compactMap{ queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Transaction.self)
                }
            }
        }
    }
}
