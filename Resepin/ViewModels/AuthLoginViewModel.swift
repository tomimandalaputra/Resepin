//
//  AuthLoginViewModel.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

@Observable
class AuthLoginViewModel {
   var presentAuthRegistrationView: Bool = false
   var email: String = ""
   var password: String = ""
   var showPassword: Bool = false
   var isLoading: Bool = false
   var errorMessage: String = ""
   var showAlert: Bool = false

   func signIn() async -> User? {
      isLoading = true
      do {
         let result = try await Auth.auth().signIn(withEmail: email, password: password)
         let userId = result.user.uid
         let user = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
         isLoading = false
         return user
      } catch {
         isLoading = false
         errorMessage = "Something went wrong. Please try again leter."
         let codeError = error._code
         if let authErrorCode = AuthErrorCode(rawValue: codeError) {
            switch authErrorCode {
               case .invalidEmail:
                  errorMessage = "Invalid email"

               case .wrongPassword:
                  errorMessage = "Wrong password"

               default:
                  break
            }
         }

         showAlert = true
         return nil
      }
   }
}
