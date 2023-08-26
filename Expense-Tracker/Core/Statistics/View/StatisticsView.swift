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
                LineChartView(data: model.getLineChartData(), title: "Line Chart")
                BarChartView(
                    data: model.getChartData(),
                    title: "Income & Expenses"
                )
            }
            PieChartView(
                data: [12, 22, 15, 25, 10, 7],
                title: "Pie Chart")
            List(model.transactionList) { item in
                Text(item.title)
            }
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
