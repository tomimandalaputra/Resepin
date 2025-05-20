//
//  PasswordComponent.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import SwiftUI

struct PasswordComponent: View {
   @Binding var showPassword: Bool
   @Binding var textPassword: String

   var body: some View {
      if showPassword {
         TextField("password", text: $textPassword)
            .keyboardType(.emailAddress)
            .textFieldStyle(TextFieldStyleComponent())
            .overlay(alignment: .trailing) {
               Button(action: {
                  toggleShowPassword()
               }, label: {
                  Image(systemName: "eye")
                     .foregroundStyle(.black)
                     .padding(.bottom)
               })
            }
      } else {
         SecureField("password", text: $textPassword)
            .textFieldStyle(TextFieldStyleComponent())
            .overlay(alignment: .trailing) {
               Button(action: {
                  toggleShowPassword()
               }, label: {
                  Image(systemName: "eye.slash")
                     .foregroundStyle(.black)
                     .padding(.bottom)
               })
            }
      }
   }

   private func toggleShowPassword() {
      showPassword = !showPassword
   }
}

#Preview {
   PasswordComponent(showPassword: .constant(false), textPassword: .constant(""))
}
