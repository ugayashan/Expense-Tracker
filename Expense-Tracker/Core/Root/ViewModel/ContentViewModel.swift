//
//  ContentViewModel.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/22/23.
//

import Foundation
import Firebase
import Combine

class ContentViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        setupSubscribers()
    }
    
    private func setupSubscribers(){
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession 
        }.store(in: &cancellables)
    }
}
