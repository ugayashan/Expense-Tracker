//
//  StatisticsView.swift
//  Expense-Tracker
//
//  Created by user236509 on 8/25/23.
//

import SwiftUICharts
import SwiftUI

struct StatisticsView: View {
    
    @ObservedObject var model = StatisticsViewModel()
    
    var body: some View {
        VStack {
            HStack {
                LineChartView(data: model.getLineChartData(), title: "Exp. Over Period")
                BarChartView(
                    data: model.getChartData(),
                    title: "Your Transactions"
                )
            }
            PieChartView(
                data: model.getPieChartData(),
                title: "Income & Expenses")
        }
        
    }
    
    init() {
        model.getData()
        model.getExpenseData()
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
