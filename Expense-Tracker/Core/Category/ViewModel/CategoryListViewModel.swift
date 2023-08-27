//
//  CategoryListViewModel.swift
//  Expense-Tracker
//
//  Created by user235012 on 8/23/23.
//

import Foundation
import Firebase

class CategoryListViewModel: ObservableObject{
    
    @Published var incomeCategory = [Category]()
    @Published var expenseCategory = [Category]()

   
    func getAllCategories() {
        print("Debug: Fetch Category")
        incomeCategory.removeAll()
        expenseCategory.removeAll()
        
     Task{
            let db  = Firestore.firestore()
            let ref = db.collection("category").whereField("userid", isEqualTo: AuthService().userSession?.uid ??  "")
            
            do{
                let snapshot = try await ref.getDocuments()

                            
                
                for documents in snapshot.documents{
                    let data = documents.data()
                    let catid = data["catid"] as? String ?? ""
                    let catname = data["catName"] as? String ?? ""
                    let catimage = data["catImage"] as? String ?? ""
                    let catType = data["catType"] as? String ?? ""
                    let userid = data["userid"] as? String ?? ""
                    let cat = Category(catId: catid, catName: catname, catType: catType, catImage: catimage,userid: userid)
                    print("Debug:\(cat)")
                    if(catType == "Income"){
                      self.incomeCategory.append(cat)
                    }else{
                      self.expenseCategory.append(cat)
                    }
                   
                }
                
            
            }catch{
                print("Error: \(error.localizedDescription)")
               
            }
         
        }
    }
  
}
