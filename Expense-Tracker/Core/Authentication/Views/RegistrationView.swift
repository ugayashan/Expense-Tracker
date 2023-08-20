//
//  RegistrationView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/18/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image("ios-et")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding()
                
                VStack{
                    TextField("Enter your email", text: $email)
                        .modifier(TextFieldModifier())
                    TextField("Enter your password", text: $password)
                        .modifier(TextFieldModifier())
                    TextField("Enter your full name", text: $fullname)
                        .modifier(TextFieldModifier())
                    SecureField("Enter your username", text: $username)
                        .modifier(TextFieldModifier())
                }
                
                Button {
                    
                } label: {
                    Text("Sign Up")
                        .modifier(ButtonModifier())
                }
                .padding(.top)
                
                Spacer()
                Divider()
                
                NavigationLink {
                    Text("Registration view")
                } label: {
                    HStack(spacing: 3){
                        Text("Already have an account")
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                }
                .padding(.vertical)
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
