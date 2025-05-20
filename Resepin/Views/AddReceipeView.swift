//
//  AddReceipeView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 17/05/2025.
//

import PhotosUI
import SwiftUI

struct AddReceipeView: View {
   @Environment(\.dismiss) private var dismiss
   
   @State var viewModel = AddReceipeViewModel()
   @StateObject private var imageLoaderViewModel = ImageLoaderViewModel()
   
   var body: some View {
      ZStack {
         VStack(alignment: .leading) {
            Text("What's New")
               .font(.system(size: 20, weight: .bold))
               .padding(.top, 20)
            
            ZStack {
               ZStack {
                  RoundedRectangle(cornerRadius: 12)
                     .fill(Color.primaryFormEntry)
                     .frame(height: 200)
                  
                  Image(systemName: "photo.fill")
               }
               
               if let displayReceipeImage = viewModel.displayReceipeImage {
                  displayReceipeImage
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(height: 200)
                     .clipShape(RoundedRectangle(cornerRadius: 12))
                     .clipped()
               }
            }.onTapGesture {
               viewModel.showImageOptions = true
            }
            
            Text("Receipe name")
               .font(.system(size: 15, weight: .semibold))
               .padding(.top)
            
            TextField("", text: $viewModel.receipeName)
               .textFieldStyle(CapsuleTextFieldStyleComponent())
               .autocorrectionDisabled()
               .textInputAutocapitalization(.never)
            
            Text("Preparation time")
               .font(.system(size: 15, weight: .semibold))
               .padding(.top)
            
            Picker(selection: $viewModel.preparationTime) {
               ForEach(0 ... 120, id: \.self) { time in
                  if time % 5 == 0 {
                     Text("\(time) mins")
                        .font(.system(size: 15))
                        .tag(time)
                  }
               }
            } label: {
               Text("Prep time")
            }
            
            Text("Cooking intructions")
               .font(.system(size: 15, weight: .semibold))
               .padding(.top)
            
            TextEditor(text: $viewModel.intructions)
               .autocorrectionDisabled()
               .textInputAutocapitalization(.never)
               .padding(.horizontal)
               .padding(.vertical, 12)
               .frame(height: 200)
               .background(
                  RoundedRectangle(cornerRadius: 12)
                     .fill(Color.primaryFormEntry)
               )
               .scrollContentBackground(.hidden)
            
            Button(action: {
               Task {
                  if let imageURL = await viewModel.upload() {
                     viewModel.addReceipe(imageURL: imageURL) { success in
                        if success {
                           dismiss()
                        }
                     }
                  }
               }
            }, label: {
               Text("Add Receipe")
            })
            .buttonStyle(PrimaryButtonStyleComponent())
            .padding(.top)
            
            Spacer()
         }
         .padding(.horizontal)
         .photosPicker(isPresented: $viewModel.showLibrary, selection: $imageLoaderViewModel.imageSelection, matching: .images, photoLibrary: .shared())
         .onChange(of: imageLoaderViewModel.imageToUpload) { _, newValue in
            if let newValue = newValue {
               viewModel.displayReceipeImage = Image(uiImage: newValue)
               viewModel.receipeImage = newValue
            }
         }
         .confirmationDialog("Upload an image to your receipe", isPresented: $viewModel.showImageOptions, titleVisibility: .visible) {
            Button(action: {
               viewModel.showLibrary = true
            }, label: {
               Text("Upload from library")
            })
            
            Button(action: {
               viewModel.showCamera = true
            }, label: {
               Text("Upload from camera")
            })
         }
         .fullScreenCover(isPresented: $viewModel.showCamera, content: {
            CameraPicker(action: { image in
               viewModel.displayReceipeImage = Image(uiImage: image)
               viewModel.receipeImage = image
            }).ignoresSafeArea()
         })
         
         if viewModel.isUpload {
            ProgressUploadView(value: $viewModel.progressUpload)
         }
         
         if viewModel.isLoading {
            LoadingView()
         }
      }
      .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
         Button(action: {}, label: {
            Text("OK")
         })
      } message: {
         Text(viewModel.alertMessage)
      }
   }
}

#Preview {
   AddReceipeView()
}
