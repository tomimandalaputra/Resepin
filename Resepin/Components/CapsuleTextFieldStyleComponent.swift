//
//  CapsuleTextFieldStyleComponent.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 17/05/2025.
//

import Foundation
import SwiftUI

struct CapsuleTextFieldStyleComponent: TextFieldStyle {
   func _body(configuration: TextField<Self._Label>) -> some View {
      configuration
         .padding(.horizontal)
         .padding(.vertical, 12)
         .background(
            RoundedRectangle(cornerRadius: 12)
               .fill(Color.primaryFormEntry)
         )
   }
}
