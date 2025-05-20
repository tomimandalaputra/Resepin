//
//  AuthLoginView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import SwiftUI

struct AuthLoginView: View {
   @State private var viewModel = AuthLoginViewModel()
   @Environment(SessionManager.self) var sessionManager: SessionManager

   var body: some View {
      ZStack {
         VStack(alignment: .leading) {
            HStack {
               Spacer()
               Text("Log In")
                  .font(.system(size: 28, weight: .bold))
               Spacer()
            }

            Spacer()

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
                  if let user = await viewModel.signIn() {
                     sessionManager.currentUser = user
                     sessionManager.sessionState = .loggedIn
                  }
               }
            }, label: {
               Text("Log In")
            })
            .buttonStyle(PrimaryButtonStyleComponent())
            .padding(.vertical, 20)

            HStack {
               Spacer()
               Text("Don't have an account?")
                  .font(.system(size: 14))
               Button(action: {
                  viewModel.presentAuthRegistrationView = true
               }, label: {
                  Text("Register now")
                     .font(.system(size: 14, weight: .semibold))
               })
               Spacer()
            }

            Spacer()
         }
         .padding(.horizontal)
         .fullScreenCover(isPresented: $viewModel.presentAuthRegistrationView) {
            AuthRegistrationView()
         }

         if viewModel.isLoading {
            LoadingView()
         }
      }
      .alert("Error Sign In", isPresented: $viewModel.showAlert) {} message: {
         Text(viewModel.errorMessage)
      }
   }
}

#Preview {
   AuthLoginView().environment(SessionManager())
}
