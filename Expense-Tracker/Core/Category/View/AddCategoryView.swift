//
//  AddCategoryView.swift
//  ExpenseTrackerApp
//
//  Created by user235012 on 8/21/23.
//

import SwiftUI

struct AddCategoryView:  View {
 
    @State private var categoryImageName:String = ""
    @State private var isCatInc:Bool = true
    @State private var showAlert = false
    @State private var alretMessage = ""
    @StateObject var viewModel = AddCategoryListViewModel()
    @StateObject var catViewModelView = CategoryListViewModel()
    
    var categories:[Category] = CategoryList.incomeCategories + CategoryList.expenseCategories
    
    let columns = [GridItem(.adaptive(minimum: 50))]

    var body: some View {
       
        VStack(spacing:20){
            Image(systemName: $viewModel.catImage.wrappedValue)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.bottom,12)
            
        
            TextField("Category Name", text: $viewModel.catName)
                .padding(10)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.subheadline)
    
            Toggle(isOn:$isCatInc, label:{
                isCatInc ? Text("Income") :Text("Expense")
            }).onChange(of:isCatInc){ newValue in
                if(newValue){
                    $viewModel.catType.wrappedValue = "Income"
                }else{
                    $viewModel.catType.wrappedValue = "Expense"
                }
            }
               .toggleStyle(CustomToggle())
            .padding()
                      
            LazyVGrid(columns:columns, spacing: 10){
                ForEach(categories) { category in
                    CategoryImageButton(categoryImageName: $viewModel.catImage, categoryId: $viewModel.catId, category: category)
                }
            }

            Button{
                if($viewModel.catName.wrappedValue == "" || $viewModel.catImage.wrappedValue == ""){
                    alretMessage = "Category Name and Image Required"
                    showAlert = true;
                }else{
                    Task {
                       try await viewModel.createCategory()
                        catViewModelView.getAllCategories()
                        alretMessage = "Category Created"
                        setDefaultValues()
                        showAlert = true;
                    }
                }
            }label: {
                Text("ADD")
                    .frame(width: 200, height: 45)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                .font(.system(size: 18, weight: .bold, design: .default))
                .cornerRadius(10)
            }

        }.alert(isPresented: $showAlert, content:{
            Alert(title: Text("Message"), message: Text(alretMessage))
        })
    }
    
    func setDefaultValues(){
        $viewModel.catImage.wrappedValue = ""
        $viewModel.catName.wrappedValue = ""
        $viewModel.catType.wrappedValue = "Income"
        isCatInc = true
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}

struct CategoryImageButton:View{
    
    @Binding var categoryImageName:String
    @Binding var categoryId:String
    var category: Category
    var body:some View{
        Button{
            categoryImageName = category.catImage
            categoryId = category.catId
            
        }label:{
            Image(systemName: category.catImage)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)          
                .frame(width: 40, height: 40)
        }
    }
}
