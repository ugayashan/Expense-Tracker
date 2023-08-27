//
//  CategoryService.swift
//  Expense-Tracker
//
//  Created by user235012 on 8/23/23.
//

import Firebase


class CategoryService:ObservableObject{
    
    @Published var incomeCatagories: [Category] = []
    @Published var expenseCatagories: [Category] = []
    
    static let shared = CategoryService()

    func saveCategory(userId:String, catId:String, catType:String, catName:String, catImage:String) async throws{
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
