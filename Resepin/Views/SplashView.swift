//
//  SplashView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import SwiftUI

struct SplashView: View {
   @State private var isAnimated: Bool = false

   var body: some View {
      ZStack {
         Color.primaryBrand.ignoresSafeArea()

         VStack {
            Spacer()

            Image("cook")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 64, height: 64)
               .foregroundStyle(.white)
               .scaleEffect(isAnimated ? 1.2 : 1.0)
               .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: true), value: isAnimated)

            Text("Resepin.")
               .font(.system(size: 32, weight: .bold))
               .foregroundStyle(.white)
               .padding(.top, -6)

            Spacer()

            Text("by Tukucode - 2025")
               .font(.system(size: 14))
               .foregroundStyle(.white)
         }
      }.onAppear {
         isAnimated = true
      }
   }
}

#Preview {
   SplashView()
}
