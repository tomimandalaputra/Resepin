//
//  TextFieldStyleComponent.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import Foundation
import SwiftUI

struct TextFieldStyleComponent: TextFieldStyle {
   func _body(configuration: TextField<Self._Label>) -> some View {
      VStack {
         configuration
            .font(.system(size: 15))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()

         Rectangle()
            .fill(Color.border)
            .frame(height: 1)
            .padding(.bottom, 15)
      }
   }
}
