//
//  RepeatTransactionsListViewModel.swift
//  Expense-Tracker
//
//  Created by user234389 on 8/26/23.
//

import Foundation
import Combine
import FirebaseFirestore

class RepeatTransactionsListViewModel: ObservableObject{
    @Published var repTransactions = [RepeatTransaction]()
    
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
            listenerRegistration =  db.collection("repeatTransactions").addSnapshotListener{ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print ("No documents")
                    return
                }
                
                self.repTransactions =  documents.compactMap{ queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: RepeatTransaction.self)
                }
            }
        }
    }
}
