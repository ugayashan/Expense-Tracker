//
//  LoginViewModel.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/22/23.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func loginUser() async throws{
        try await AuthService.shared.login(
            withEmail: email,
            password: password
        )
    }
}
