//
//  ProgressUploadView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 20/05/2025.
//

import SwiftUI

struct ProgressUploadView: View {
   @Binding var value: Float

   var body: some View {
      ZStack {
         Color.black.opacity(0.4).ignoresSafeArea()

         ProgressView(value: value, total: 1) {
            HStack {
               Spacer()
               Text("Uploading...")
                  .foregroundStyle(.white)
               Spacer()
            }.padding(.bottom)
         }
         .padding(.horizontal)
      }
   }
}

#Preview {
   ProgressUploadView(value: .constant(0.5))
}
