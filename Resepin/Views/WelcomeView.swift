//
//  WelcomeView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import SwiftUI

struct WelcomeView: View {
   @AppStorage("hashHomeView") private var hashHomeView: Bool = false
   var body: some View {
      ZStack {
         Color.primaryBrand.ignoresSafeArea()

         VStack(spacing: 24) {
            Spacer()

            Image("readBook")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 180)

            Text("Selamat datang di Resepin")
               .font(.system(size: 24, weight: .bold))
               .foregroundStyle(.white)

            Text("Saatnya simpan dan kelola resep masakan favoritmu dengan mudah disini.")
               .font(.system(size: 16, weight: .medium))
               .multilineTextAlignment(.center)
               .foregroundStyle(.white)

            Spacer()

            Button(action: {
               hashHomeView = true
            }, label: {
               Text("Mulai")
                  .font(.system(size: 18, weight: .bold))
                  .frame(maxWidth: .infinity)
                  .frame(height: 52)
            })
            .foregroundStyle(.primaryBrand)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
         }
         .padding()
      }
   }
}

#Preview {
   WelcomeView()
}
