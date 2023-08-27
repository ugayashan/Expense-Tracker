//
//  CircularProfileImageView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/24/23.
//

import SwiftUI

struct CircularProfileImageView: View {
    var body: some View {
        Image("pp")
            .resizable()
            .scaledToFill()
            .frame(width: 30, height: 30)
            .clipShape(Circle())
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView()
    }
}
