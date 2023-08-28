//
//  ButtonModifier.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/19/23.
//


import SwiftUI

struct ButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 352, height: 44)
            .background(.black)
            .cornerRadius(8)
    }
}
