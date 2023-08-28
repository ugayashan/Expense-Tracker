//
//  PredictionCard.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/25/23.
//

import SwiftUI

struct PredictionCard: View {
    var title: String
    var precentageChange: Double
    var value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 2){
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .foregroundColor(.black)
            
            HStack(spacing: 1) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(.degrees(precentageChange >= 0 ? 0 : 180))
                Text("25.34%")
                    .font(.caption)
                .bold()
            }.foregroundColor(precentageChange >= 0 ? Color.green : Color.red)
        }
    }
}

struct PredictionCard_Previews: PreviewProvider {
    
    static var previews: some View {
        PredictionCard(title: "Income", precentageChange: 25.4, value: "1520")
            .previewLayout(.sizeThatFits)
    }
}
