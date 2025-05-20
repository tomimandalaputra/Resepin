//
//  HomeView.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import SwiftUI

struct HomeView: View {
   @Environment(SessionManager.self) var sessionManager: SessionManager
   @State private var viewModel = HomeViewModel()

   let columns = [
      GridItem(.flexible(), spacing: 16),
      GridItem(.flexible(), spacing: 16)
   ]

   let spacing: CGFloat = 8
   let padding: CGFloat = 8
   var itemWidth: CGFloat {
      let screenWidth = UIScreen.main.bounds.width
      return (screenWidth - (spacing * 2) - (padding * 2)) / 2
   }

   var itemHeight: CGFloat {
      return CGFloat(1.5) * itemWidth
   }

   fileprivate func ReceipeRow(receipe: ReceipeModel) -> some View {
      VStack(alignment: .leading) {
         AsyncImage(url: URL(string: receipe.image)) { image in
            image
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: itemWidth, height: itemHeight)
               .clipShape(RoundedRectangle(cornerRadius: 8))
               .clipped()

         } placeholder: {
            VStack {
               ProgressView()
            }.frame(width: itemWidth, height: itemHeight)
         }

         Text(receipe.name)
            .font(.system(size: 14, weight: .semibold))
            .lineLimit(1)
            .foregroundStyle(.black)
      }
   }

   fileprivate var ListSettingView: some View {
      List {
         HStack {
            Image(systemName: "person.fill")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 20)

            Text("tomimandalaputra")
         }

         HStack {
            Image(systemName: "envelope.fill")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 20)

            Text(verbatim: "example@mail.com")
         }

         Button(action: {
            viewModel.showSignOutAlert = true
         }, label: {
            HStack {
               Image(systemName: "arrowshape.left.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 20)

               Text("Sign Out")
                  .font(.system(size: 16))
            }
            .foregroundStyle(Color.red)
         })
      }
      .scrollDisabled(true)
      .presentationDetents([.height(200), .medium])
   }

   var body: some View {
      NavigationStack {
         VStack {
            ScrollView {
               LazyVGrid(columns: columns) {
                  ForEach(viewModel.receipes) { receipe in
                     NavigationLink {
                        ReceipeDetailView(receipe: receipe)
                     } label: {
                        ReceipeRow(receipe: receipe)
                     }
                  }
               }
               .padding(padding)
            }

            Spacer()

            Button(action: {
               viewModel.showAddReceipeView = true
            }, label: {
               Text("Add Receipe")
            })
            .buttonStyle(PrimaryButtonStyleComponent())
         }
         .navigationTitle("Receipes")
         .padding(padding)
         .task {
            await viewModel.fetchReceipes()
         }
         .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
               Button(action: {
                  viewModel.showSheetSettingView = true
               }, label: {
                  Image(systemName: "gearshape.fill")
                     .foregroundStyle(Color.black)
               })
            }
         }
         .sheet(isPresented: $viewModel.showSheetSettingView) {
            ListSettingView
         }
         .sheet(isPresented: $viewModel.showAddReceipeView, onDismiss: {
            guard viewModel.receipes.isEmpty else {
               return
            }

            Task {
               await viewModel.fetchReceipes()
            }

         }) {
            AddReceipeView()
         }
         .alert("Are you sure you would like to sign out?", isPresented: $viewModel.showSignOutAlert) {
            Button("Sign Out", role: .destructive) {
               if viewModel.signOut() {
                  sessionManager.sessionState = .loggedOut
               }
            }

            Button("Cancel", role: .cancel) {}
         }
      }
   }
}

#Preview {
   HomeView()
      .environment(SessionManager())
}
