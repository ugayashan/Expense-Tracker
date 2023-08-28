//
//  ContentView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group{
            if viewModel.userSession != nil{
                TransactionHistoryView()
            } else{
                LoginView()
            }
        }
        .onAppear {
            if let userSession = viewModel.userSession {
                print("DEBUG: \(viewModel.userSession?.uid)")
            } else {
                print("DEBUG: Session is nil")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
