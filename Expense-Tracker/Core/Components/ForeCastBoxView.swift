//
//  ForeCastBoxView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/26/23.
//

import SwiftUI

struct ForeCastBoxView: View {
    @ObservedObject var viewModel: PredictionViewModel

    var body: some View {
                HStack{
                    PredictionCard(title: "Income", precentageChange: 10, value: viewModel.totalIncome)
                    Spacer()
                    PredictionCard(title: "Expense", precentageChange: -5, value: viewModel.totalExpense)
                }.padding(.horizontal)
                    .frame(width: 370, height: 90)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.1), Color.red.opacity(0.1)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
//                ForEach(viewModel.transactions){ category in
//                    PredictionCategoryItemView(categorySymbol: "gift", categoryName: "Gift", amount: "1500")
//                }

    }
}

struct ForeCastBoxView_Previews: PreviewProvider {
    static var previews: some View {
        ForeCastBoxView(viewModel: PredictionViewModel())
            .previewLayout(.sizeThatFits)
    }
}
