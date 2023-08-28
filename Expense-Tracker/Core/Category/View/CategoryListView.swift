//
//  CategoryListView.swift
//  ExpenseTrackerApp
//
//  Created by user235012 on 8/21/23.
//

import SwiftUI

struct CategoryListView: View {
    
    @ObservedObject var  viewModel = CategoryListViewModel()

    var body: some View {
        NavigationView{
                List{
                    Section{
                        ForEach(viewModel.incomeCategory) { category in
                            CatListItem(catImage: category.catImage, catName: category.catName)
                        }
                    } header:{
                        Text("Income")
                    }
                    Section{
                        ForEach(viewModel.expenseCategory) { category in
                            CatListItem(catImage: category.catImage, catName: category.catName)
                        }
                    } header:{
                        Text("Expense")
                    }
                }
                .navigationTitle("Categories")
                .toolbar{
                        NavigationLink(destination:AddCategoryView(),label:{                        Label("Add", systemImage: "plus")
                        })
                }.onAppear(perform: {
                    viewModel.getAllCategories()
                })
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
