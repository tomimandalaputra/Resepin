//
//  ResepinApp.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
   func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
   {
      // FirebaseApp.configure()
      return true
   }
}

@main
struct ResepinApp: App {
   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

   @State private var hashSplashViewShown: Bool = true
   @State private var sessionManager = SessionManager()
   @AppStorage("hashHomeView") private var hashHomeView: Bool = false

   var body: some Scene {
      WindowGroup {
         Group {
            if hashSplashViewShown {
               SplashView().transition(.opacity)
            } else {
               if hashHomeView {
                  switch sessionManager.sessionState {
                  case .loggedIn:
                     HomeView()
                        .environment(sessionManager)
                  case .loggedOut:
                     AuthLoginView()
                        .environment(sessionManager)
                        .transition(.move(edge: .trailing))
                  }
               } else {
                  WelcomeView().transition(.move(edge: .bottom))
               }
            }
         }
         .preferredColorScheme(.light)
         .animation(.easeInOut(duration: 1), value: hashSplashViewShown)
         .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               withAnimation {
                  hashSplashViewShown = false
               }
            }
         }
      }
   }
}
