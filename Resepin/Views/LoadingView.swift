//
//  LoadingView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 19/05/2025.
//

import SwiftUI

struct LoadingView: View {
   var body: some View {
      ZStack {
         Color.black.opacity(0.4).ignoresSafeArea()

         ProgressView().tint(Color.white)
      }
   }
}

#Preview {
   LoadingView()
}
