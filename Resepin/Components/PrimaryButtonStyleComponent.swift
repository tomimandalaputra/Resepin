//
//  PrimaryButtonStyleComponent.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 17/05/2025.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyleComponent: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
      configuration
         .label
         .foregroundStyle(Color.white)
         .font(.system(size: 18, weight: .bold))
         .padding(.vertical, 14)
         .frame(maxWidth: .infinity)
         .background(Color.primaryBrand)
         .clipShape(RoundedRectangle(cornerRadius: 12))
   }
}
