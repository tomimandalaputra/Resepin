//
//  AddReceipeViewModel.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 17/05/2025.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Foundation
import SwiftUI

@Observable
class AddReceipeViewModel {
   var receipeName: String = ""
   var preparationTime: Int = 0
   var intructions: String = ""
   var showImageOptions: Bool = false
   var showLibrary: Bool = false
   var displayReceipeImage: Image?
   var receipeImage: UIImage?
   var showCamera: Bool = false
   var progressUpload: Float = 0
   var isUpload: Bool = false
   var isLoading: Bool = false
   var showAlert: Bool = false
   var alertTitle: String = ""
   var alertMessage: String = ""

   func addReceipe(imageURL: URL, handler: @escaping (_ success: Bool) -> Void) {
      guard let userId = Auth.auth().currentUser?.uid else {
         createAlert(title: "Not Signed in", message: "Please sign in to create receipes.")
         handler(false)
         return
      }

      guard receipeName.count >= 3 else {
         createAlert(title: "Invalid receipe name", message: "Receipe name must be 3 or more characters long.")
         handler(false)
         return
      }

      guard intructions.count >= 5 else {
         createAlert(title: "Invalid intructions", message: "Receipe name must be 5 or more characters long.")
         handler(false)
         return
      }

      guard preparationTime != 0 else {
         createAlert(title: "Invalid preparation time", message: "Preparation time must be greater than 0 minutes.")
         handler(false)
         return
      }

      isLoading = true
      let ref = Firestore.firestore().collection("receipes").document()
      let receipe = ReceipeModel(id: ref.documentID, name: receipeName, image: imageURL.absoluteString, instructions: intructions, time: preparationTime, userId: userId)

      do {
         try Firestore.firestore().collection("receipes").document(ref.documentID).setData(from: receipe) { error in
            self.isLoading = false
            if let error = error {
               print(error.localizedDescription)
               self.createAlert(title: "Could not save receipe", message: "We could not save your receipe right now, please try later.")
               handler(false)
               return
            }
            handler(true)
         }
      } catch {
         createAlert(title: "Could not save receipe", message: "Something went wrong, please try again.")
         isLoading = false
         handler(false)
      }
   }

   private func createAlert(title: String, message: String) {
      alertTitle = title
      alertMessage = message
      showAlert = true
   }

   func upload() async -> URL? {
      guard let userId = Auth.auth().currentUser?.uid else {
         return nil
      }

      guard let receipeImage = receipeImage,
            let imageData = receipeImage.jpegData(compressionQuality: 0.7)
      else {
         createAlert(title: "Upload image failed", message: "Your receipe image could not be uploaded.")
         return nil
      }

      let imageId = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "_")
      let imageName = "\(imageId).jpg"
      let imagePath = "images/\(userId)/\(imageName)"
      let storageRef = Storage.storage().reference(withPath: imagePath)

      // define content type image
      let metaData = StorageMetadata()
      metaData.contentType = "image/jpg"

      isUpload = true
      do {
         _ = try await storageRef.putDataAsync(imageData, metadata: metaData) { progress in
            if let progress = progress {
               let percentComplete = Float(progress.completedUnitCount / progress.totalUnitCount)
               self.progressUpload = percentComplete
            }
         }

         isUpload = false
         let downloadURL = try await storageRef.downloadURL()
         return downloadURL
      } catch {
         createAlert(title: "Upload image failed", message: "Something went wrong, please try again.")
         isUpload = false
         return nil
      }
   }
}
