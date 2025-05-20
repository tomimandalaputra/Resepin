//
//  ReceipeDetailView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import SwiftUI

struct ReceipeDetailView: View {
   let receipe: ReceipeModel

   var body: some View {
      VStack(alignment: .leading) {
         AsyncImage(url: URL(string: receipe.image)) { image in
            image
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(height: 250)
               .clipped()
         } placeholder: {
            ZStack {
               Rectangle()
                  .fill(Color.primaryFormEntry)
                  .frame(height: 250)
               Image(systemName: "photo.fill")
            }
         }

         HStack {
            Text(receipe.name)
               .font(.system(size: 22, weight: .semibold))
            Spacer()
            Image(systemName: "clock.fill")
               .font(.system(size: 15))
            Text("\(receipe.time) mins")
               .font(.system(size: 15))
         }
         .padding(.top)
         .padding(.horizontal)

         Text(receipe.instructions)
            .font(.system(size: 15))
            .padding(.top, 6)
            .padding(.horizontal)

         Spacer()
      }
   }
}

#Preview {
   ReceipeDetailView(receipe: ReceipeModel.mockReceipes[0])
}
