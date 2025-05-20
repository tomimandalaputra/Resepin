//
//  AuthRegistrationView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import SwiftUI

struct AuthRegistrationView: View {
   @State private var viewModel = AuthRegistrationViewModel()
   
   @Environment(\.dismiss) private var dismiss
   @Environment(SessionManager.self) var sessionManager: SessionManager
   
   var body: some View {
      ZStack {
         VStack(alignment: .leading) {
            HStack {
               Spacer()
               Text("Sign Up")
                  .font(.system(size: 28, weight: .bold))
               Spacer()
            }
            
            Spacer()
            
            Text("Username")
               .font(.system(size: 15))
            TextField("Username", text: $viewModel.username)
               .keyboardType(.alphabet)
               .textFieldStyle(TextFieldStyleComponent())
            
            Text("Email")
               .font(.system(size: 15))
            TextField("example@mail", text: $viewModel.email)
               .keyboardType(.emailAddress)
               .textFieldStyle(TextFieldStyleComponent())
            
            Text("Password")
               .font(.system(size: 15))
            PasswordComponent(showPassword: $viewModel.showPassword, textPassword: $viewModel.password)
            
            Button(action: {
               Task {
                  if let user = await viewModel.signUp() {
                     sessionManager.currentUser = user
                     sessionManager.sessionState = .loggedIn
                  }
               }
            }, label: {
               Text("Sign Up")
            })
            .buttonStyle(PrimaryButtonStyleComponent())
            .padding(.vertical, 20)
            
            HStack {
               Spacer()
               Text("Already have an account?")
                  .font(.system(size: 14))
               Button(action: {
                  dismiss()
               }, label: {
                  Text("Login now")
                     .font(.system(size: 14, weight: .semibold))
               })
               Spacer()
            }
            
            Spacer()
         }.padding(.horizontal)
         
         if viewModel.isLoading {
            LoadingView()
         }
      }
      .alert("Error Sign Up", isPresented: $viewModel.showAlert) {} message: {
         Text(viewModel.errorMessage)
      }
   }
}

#Preview {
   AuthRegistrationView()
      .environment(SessionManager())
}
