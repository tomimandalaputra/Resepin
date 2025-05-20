//
//  AuthRegistrationViewModel.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

@Observable
class AuthRegistrationViewModel {
   var username: String = ""
   var email: String = ""
   var password: String = ""
   var showPassword: Bool = false
   var isLoading: Bool = false
   var errorMessage: String = ""
   var showAlert: Bool = false

   private var isValidateUsername: Bool {
      return username.count >= 3 && username.count <= 20
   }

   func signUp() async -> User? {
      guard isValidateUsername else {
         errorMessage = "Username must be more than equal to 3 characters and cannot be more than equal to 20 characters."
         showAlert = true
         return nil
      }

      isLoading = true

      guard let matchingUsername = try? await Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments() else {
         errorMessage = "Something has gone wrong. Please try again leter."
         showAlert = true
         isLoading = false
         return nil
      }

      guard matchingUsername.documents.count == 0 else {
         errorMessage = "Username already exists"
         showAlert = true
         isLoading = false
         return nil
      }

      do {
         let result = try await Auth.auth().createUser(withEmail: email, password: password)
         let userId = result.user.uid
         let user = User(id: userId, username: username, email: email)
         try Firestore.firestore().collection("users").document(userId).setData(from: user)
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

               case .emailAlreadyInUse:

                  errorMessage = "Email already is use"

               case .weakPassword:
                  errorMessage = "Weak password"

               default:
                  break
            }
         }

         showAlert = true
         return nil
      }
   }
}
