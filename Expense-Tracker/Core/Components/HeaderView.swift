//
//  HeaderView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/25/23.
//

import SwiftUI

struct HeaderView: View {
        var body: some View {
            HStack{
                Button {
                    
                } label: {
                    CircularProfileImageView()
                }
                Spacer()
                Text("Prediction")
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bell.badge")
                        .font(.system(size: 22))
                        .accentColor(.black)
                }

            }
        }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
