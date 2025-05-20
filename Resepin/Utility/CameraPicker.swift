//
//  CameraPicker.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 20/05/2025.
//

import Foundation
import SwiftUI

struct CameraPicker: UIViewControllerRepresentable {
   @Environment(\.dismiss) private var dismiss
   var action: (UIImage) -> Void

   func makeUIViewController(context: Context) -> some UIViewController {
      let imagePicker = UIImagePickerController()
      imagePicker.allowsEditing = true
      imagePicker.sourceType = .camera
      imagePicker.delegate = context.coordinator
      imagePicker.modalPresentationStyle = .fullScreen
      return imagePicker
   }

   func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

   func makeCoordinator() -> Coordinator {
      return Coordinator(self)
   }

   class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
      var parent: CameraPicker

      init(_ parent: CameraPicker) {
         self.parent = parent
      }

      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
         if let image = info[.editedImage] as? UIImage {
            parent.action(image)
         }

         parent.dismiss()
      }

      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         parent.dismiss()
      }
   }
}
