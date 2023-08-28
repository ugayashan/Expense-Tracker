//
//  PredictionView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/23/23.
//

import SwiftUI

struct PredictionView: View {
    @StateObject var viewModel = PredictionViewModel()
    @State private var date = Date.now
    @State private var shouldShowDetails = false
    
    let categories: [(symbolName: String, name: String, amount: String)] = [
        ("gift.fill", "Gift", "$500"),
        ("car.fill", "Car", "$1000"),
        ("house.fill", "House", "$2000"),
        ("heart.fill", "Health", "$300"),
        ("book.fill", "Education", "$150"),
        ("gamecontroller.fill", "Entertainment", "$50"),
        ("briefcase.fill", "Work", "$800"),
        ("tshirt.fill", "Clothing", "$250"),
        ("globe", "Travel", "$1200"),
        ("music.note", "Music", "$75")
    ]
    
    var body: some View {
        VStack {
            HeaderView()
                .padding(.horizontal)
            DatePicker(
                "",
                 selection: $date,
                in: Date()...Calendar.current.date(byAdding: .year, value: 1, to: Date())!,
                displayedComponents: [.date]
            ).datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .padding()
            .onChange(of: date) { newValue in
                Task{ try await viewModel.fetchTransactions(for: newValue) }
                shouldShowDetails = true
                viewModel.isLoading = true
            }
            Divider().opacity(0.5)
                .padding(.bottom)
            ScrollView{
                if shouldShowDetails && !viewModel.isDateInNextMonth(date){
                    if viewModel.isLoading {
                         ForeCastBoxView(viewModel: viewModel)
                             .redacted(reason: .placeholder)
                             .shimmering()
                     } else {
                         ForeCastBoxView(viewModel: viewModel)
                         Text(AuthService.shared.userSession?.uid ?? "")
                     }
                }else if(viewModel.isDateInNextMonth(date)){
                    MessageBoxView(message: "Not enough data to forecast")
                }else{
                    MessageBoxView(message: "Select a future date to forecast")
                }
            }
        }.background(Color.gray.opacity(0.01))
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}
