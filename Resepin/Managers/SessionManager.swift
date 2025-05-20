//
//  SessionManager.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import FirebaseAuth
import FirebaseCore
import Foundation

@Observable
class SessionManager {
   var sessionState: SessionModel = .loggedOut
   var currentUser: User?

   init() {
      if FirebaseApp.allApps == nil {
         FirebaseApp.configure()
      }
      sessionState = Auth.auth().currentUser != nil ? .loggedIn : .loggedOut
   }
}
