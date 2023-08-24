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
        incomeCatagories.removeAll()
        expenseCatagories.removeAll()
        
        let db  = Firestore.firestore()
        let ref = db.collection("Categories").whereField("userid", isEqualTo: user)
        ref.getDocuments{
            snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                for documents in snapshot.documents{
                    let data = documents.data()
                    let catid = data["catid"] as? String ?? ""
                    let catname = data["catName"] as? String ?? ""
                    let catimage = data["catImage"] as? String ?? ""
                    let catType = data["catType"] as? String ?? ""
                    let userid = data["userid"] as? String ?? ""
                    let cat = Category(catId: catid, catName: catname, catType: catType, catImage: catimage,userid: userid)
                    
                    if(catType == "Income"){
                        self.incomeCatagories.append(cat)
                    }else{
                        self.expenseCatagories.append(cat)
                    }
                    
                }
            }
        }
        
    }
    
    func saveCategory(userId:String, catId:String, catType:String, catName:String, catImage:String) async throws{

        let  db = Firestore.firestore()
        let ref = db.collection("category").document()

        ref.setData(["catid":catId,
                     "catName": catName,
                     "catType": catType,
                     "catImage": catImage,
                     "userid": userId
                    ]){
            error in if let error = error{
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}
