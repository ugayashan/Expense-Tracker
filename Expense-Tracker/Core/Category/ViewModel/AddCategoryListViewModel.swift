//
//  AddCategoryListModel.swift
//  Expense-Tracker
//
//  Created by user235012 on 8/23/23.
//

import Foundation


class AddCategoryListViewModel: ObservableObject{
    
    @Published var userId = ""
    @Published var catId = ""
    @Published var catType = ""
    @Published var catName = ""
    @Published var catImage = ""
    
    @MainActor
    func createCategory() async throws{
        print("DEBUG: \(userId) here")
        try await CategoryService.shared.saveCategory(userId: userId, catId: catId, catType: catType, catName: catName, catImage: catImage)
    }
    
}
