//
//  PredictionCategoryItemView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/25/23.
//

import SwiftUI

struct PredictionCategoryItemView: View {
    var categorySymbol: String
    var categoryName: String
    var amount: String
    
    var randomColor: Color {
        let colors: [Color] = [
            .red, .blue, .green, .orange, .purple, .pink,
            .yellow, .teal, .indigo, .cyan, .gray,
            .black, .white, .brown,
        ]
        return colors.randomElement() ?? .black
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10) // Embed the content in a RoundedRectangle
            .fill(Color.white)
            .overlay(
                HStack {
                    HStack {
                        //category
                        Image(systemName: categorySymbol)
                            .foregroundColor(randomColor)
                        Text(categoryName)
                    }
                    Spacer()
                    //amount
                    VStack(alignment: .trailing) {
                        Text(amount)
                            .font(.headline)
                    }
                }
                .padding() // Add horizontal padding
            )
            .frame(width: 350, height: 60)
    }
}

struct PredictionCategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionCategoryItemView(categorySymbol: "externaldrive.fill", categoryName: "Tech", amount: "$1500")
    }
}
