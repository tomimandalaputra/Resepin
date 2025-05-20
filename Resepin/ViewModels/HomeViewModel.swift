//
//  HomeViewModel.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

@Observable
class HomeViewModel {
   var showSignOutAlert: Bool = false
   var showSheetSettingView: Bool = false
   var showAddReceipeView: Bool = false
   var receipes: [ReceipeModel] = []

   func signOut() -> Bool {
      do {
         try Auth.auth().signOut()
         return true
      } catch {
         print(error.localizedDescription)
         return false
      }
   }

   func fetchReceipes() async {
      guard let userId = Auth.auth().currentUser?.uid else {
         return
      }

      do {
         let result = try await Firestore.firestore().collection("receipes").whereField("userId", isEqualTo: userId).getDocuments()
         receipes = result.documents.compactMap { ReceipeModel(snapshot: $0) }
      } catch {}
   }
}
