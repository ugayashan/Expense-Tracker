//
//  CustomToggle.swift
//  ExpenseTrackerApp
//
//  Created by user235012 on 8/22/23.
//

import SwiftUI


struct CustomToggle:ToggleStyle{
    
    func makeBody(configuration: Configuration) -> some View {
           HStack {
               configuration.label
               Spacer()
               Rectangle()
                   .foregroundColor(configuration.isOn ? .green : .yellow)
                   .frame(width: 51, height: 31, alignment: .center)
                   .overlay(
                       Circle()
                           .foregroundColor(.white)
                           .padding(.all, 3)
                           .overlay(
                               Image(systemName: configuration.isOn ? "plus" : "minus")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .font(Font.title.weight(.black))
                                   .frame(width: 8, height: 8, alignment: .center)
                                   .foregroundColor(configuration.isOn ? .green : .yellow)
                           )
                           .offset(x: configuration.isOn ? 11 : -11, y: 0)
                           .animation(Animation.linear(duration: 0.1))
                           
                   ).cornerRadius(20)
                   .onTapGesture { configuration.isOn.toggle() }
           }
       }
}
