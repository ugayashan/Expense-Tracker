//
//  RegistrationView.swift
//  Expense-Tracker
//
//  Created by Uditha gayashan on 8/18/23.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    
    var body: some View {
        NavigationStack(){
            VStack{
                Spacer()
                Image(systemName: "creditcard.circle")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .fontWeight(.thin)
                    .padding()
                
                VStack{
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(TextFieldModifier())
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                    TextField("Enter your full name", text: $viewModel.fullname)
                        .modifier(TextFieldModifier())
                    TextField("Enter your username", text: $viewModel.username)
                        .modifier(TextFieldModifier())
                }
                
                Button {
                    Task { try await viewModel.createUser() }
                } label: {
                    Text("Sign Up")
                        .modifier(ButtonModifier())
                }
                .padding(.top)
                
                Spacer()
                Divider()
                
                NavigationLink {
                    LoginView()
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
