//
//  CategoryService.swift
//  Expense-Tracker
//
//  Created by user235012 on 8/23/23.
//

import Firebase


class CategoryService{
    
    @Published var incomeCatagories: [Category] = []
    @Published var expenseCatagories: [Category] = []
    
    static let shared = CategoryService()
    
    func getAllCategories(user:String)async throws{
//        do{
//
//        }catch{
//
//        }
    }
    
    func saveCategory(userId:String, catId:String, catType:String, catName:String, catImage:String) async throws{

        let  db = Firestore.firestore()
        let ref = db.collection("category").document()
        
//        let catId: String
//        let catName:String
//        let catType:String
//        let catImage:String
//        var userid:String?
//
        ref.setData(["catid":catId, "catName": catName, "catType": catType, "catImage": catImage, "userid": userId]){
            error in if let error = error{
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}
