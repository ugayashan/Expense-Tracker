//
//  TransactionView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/22/23.
//

import SwiftUI

struct TransactionView: View {
    var currentUser = AuthService().userSession
    var body: some View {
        Text("Transaction View")
        Button {
            print("DEBUG here: \(AuthService().userSession?.uid)")
            AuthService.shared.signOut()
        } label: {
            Image(systemName: "line.3.horizontal")
        }

    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
