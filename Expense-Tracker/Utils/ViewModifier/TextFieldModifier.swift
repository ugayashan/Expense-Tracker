//
//  TextFieldModifier.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/19/23.
//

import SwiftUI


struct TextFieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 15)
    }
}
