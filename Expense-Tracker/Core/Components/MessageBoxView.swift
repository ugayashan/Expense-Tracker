//
//  MessageBoxView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/26/23.
//

import SwiftUI

struct MessageBoxView: View {
    var message: String
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.green.opacity(0.3))
                .overlay {
                    Text(message)
                        .foregroundColor(Color.gray)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            .frame(width: 370, height: 40)
 
        }
    }
}

struct MessageBoxView_Previews: PreviewProvider {
    static var previews: some View {
        MessageBoxView(message: "Select a future date to forecast")
            .previewLayout(.sizeThatFits)
    }
}
