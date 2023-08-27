//
//  AddCategoryListModel.swift
//  Expense-Tracker
//
//  Created by user235012 on 8/23/23.
//

import Foundation
import Firebase


class AddCategoryListViewModel: ObservableObject{
    
    @Published var catId = ""
    @Published var catType = "Income"
    @Published var catName = ""
    @Published var catImage = ""
    
    @MainActor
    func createCategory() async throws{
        let  db = Firestore.firestore()
        let ref = db.collection("category").document()
        ref.setData(["catid": catId,
                     "catName": catName,
                     "catType": catType,
                     "catImage": catImage,
                     "userid": AuthService().userSession?.uid ??  "",
                    ]){
            error in if let error = error{
                print(error.localizedDescription)
            }
        }
    }
  
}
