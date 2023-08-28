//
//  Category.swift
//  ExpenseTrackerApp
//
//  Created by user235012 on 8/22/23.
//

import Foundation


struct Category: Identifiable, Hashable, Codable{
    let id = UUID()
    let catId: String
    let catName:String
    let catType:String
    let catImage:String
    var userid:String?
}

struct CategoryList{
    static let incomeCategories = [
        Category(catId: "001", catName: "Salary", catType: "income", catImage: "briefcase.fill"),
        Category(catId: "002", catName: "Rent", catType: "income", catImage: "house.circle.fill"),
        Category(catId: "003", catName: "Personal income", catType: "income", catImage: "person.circle.fill"),
        Category(catId: "004", catName: "Gift", catType: "income", catImage: "gift"),
        Category(catId: "005", catName: "Other Income", catType: "income", catImage: "dollarsign"),
        
    ]
    
    
    static let expenseCategories = [
        Category(catId: "010", catName: "Books", catType: "expense", catImage: "book.circle.fill"),
        Category(catId: "011", catName: "Transport", catType: "expense", catImage: "car.fill"),
        Category(catId: "012", catName: "Cable TV", catType: "expense", catImage: "tv"),
        Category(catId: "013", catName: "Grocery", catType: "expense", catImage: "cart.fill"),
        Category(catId: "014", catName: "Stationary", catType: "expense", catImage: "pencil"),
        Category(catId: "015", catName: "Garbage", catType: "expense", catImage: "trash"),
        Category(catId: "016", catName: "Mobile", catType: "expense", catImage: "phone"),
        Category(catId: "017", catName: "Credit Card", catType: "expense", catImage: "creditcard"),
        Category(catId: "018", catName: "Travel", catType: "expense", catImage: "airplane"),
        Category(catId: "019", catName: "Fitness", catType: "expense", catImage: "figure.cooldown"),
        Category(catId: "020", catName: "Family", catType: "expense", catImage: "figure.2.and.child.holdinghands"),
        Category(catId: "021", catName: "Medical", catType: "expense", catImage: "cross.case"),
        Category(catId: "022", catName: "Medicin", catType: "expense", catImage: "cross.vial"),
        Category(catId: "023", catName: "Food", catType: "expense", catImage: "fork.knife"),
        Category(catId: "024", catName: "Education", catType: "expense", catImage: "graduationcap"),
        Category(catId: "025", catName: "Electricity", catType: "expense", catImage: "bolt"),
        Category(catId: "026", catName: "Fuel", catType: "expense", catImage: "fuelpump"),
        Category(catId: "027", catName: "Travel", catType: "expense", catImage: "figure.hiking"),
        Category(catId: "028", catName: "Pest", catType: "expense", catImage: "ant.circle"),
        
    ]
}
