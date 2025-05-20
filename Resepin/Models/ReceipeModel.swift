//
//  ReceipeModel.swift
//  Resepin
//
//  Created by Tomi Mandala Putra on 16/05/2025.
//

import FirebaseFirestore
import Foundation

struct ReceipeModel: Identifiable, Encodable {
   let id: String
   let image: String
   let name: String
   let instructions: String
   let time: Int
   let userId: String

   init(id: String, name: String, image: String, instructions: String, time: Int, userId: String) {
      self.id = id
      self.name = name
      self.image = image
      self.instructions = instructions
      self.time = time
      self.userId = userId
   }

   init?(snapshot: QueryDocumentSnapshot) {
      let data = snapshot.data()

      guard let image = data["image"] as? String else {
         return nil
      }

      guard let instructions = data["instructions"] as? String else {
         return nil
      }

      guard let name = data["name"] as? String else {
         return nil
      }

      guard let time = data["time"] as? Int else {
         return nil
      }

      guard let userId = data["userId"] as? String else {
         return nil
      }

      self.image = image
      self.instructions = instructions
      self.name = name
      self.time = time
      self.userId = userId
      self.id = snapshot.documentID
   }
}

extension ReceipeModel {
   static var mockReceipes = [
      ReceipeModel(id: UUID().uuidString, name: "Steak and Potatoes", image: "https://firebasestorage.googleapis.com/v0/b/resepin-app-ios.firebasestorage.app/o/mockImages%2Fbeef.jpg?alt=media&token=c201f18a-c2bf-4b13-8333-93f304cd6e84", instructions: "To prepare a classic steak and potatoes meal, start by preheating your oven to 400°F for the potatoes. Wash and cut the potatoes into wedges, toss them with olive oil, salt, pepper, and your choice of herbs like rosemary or thyme. Spread them on a baking sheet and roast until golden and crispy, about 25-30 minutes, turning halfway through. Meanwhile, take your steak out of the fridge and let it come to room temperature for about 20 minutes. Season it generously with salt and pepper. Heat a cast-iron skillet over high heat and add a splash of oil. Sear the steak for about 3-4 minutes on each side for medium-rare, or longer depending on the thickness and your preference. Let the steak rest for a few minutes before slicing. Serve with the roasted potatoes and a side of steamed vegetables or a fresh salad for a complete meal.", time: 40, userId: "testUserId"),
      ReceipeModel(id: UUID().uuidString, name: "Roast Chicken", image: "https://firebasestorage.googleapis.com/v0/b/resepin-app-ios.firebasestorage.app/o/mockImages%2Fchicken.jpg?alt=media&token=7b284f74-5ef5-4d54-a583-dc1189153ef0", instructions: "To prepare a delicious roast chicken, begin by preheating your oven to 375°F (190°C). Clean the chicken by removing any giblets and pat it dry with paper towels. Rub the entire surface of the chicken with olive oil and season generously inside and out with salt, pepper, and herbs like rosemary, thyme, and sage. Optionally, stuff the cavity with halved lemons and garlic cloves to enhance the flavor. Place the chicken breast-side up in a roasting pan. Tuck the wing tips under the body and tie the legs together with kitchen twine. Roast in the oven for about 20 minutes per pound, or until the internal temperature reaches 165°F (74°C) and the juices run clear. Let the chicken rest for 10 minutes before carving to allow the juices to redistribute. Serve with roasted vegetables or a light salad for a hearty, satisfying meal.", time: 50, userId: "testUserId"),
      ReceipeModel(id: UUID().uuidString, name: "Lasagna", image: "https://firebasestorage.googleapis.com/v0/b/resepin-app-ios.firebasestorage.app/o/mockImages%2Flasagna.jpg?alt=media&token=21cf4f90-5f14-48dd-a89f-2059cee77b86", instructions: "To prepare a classic lasagna, start by preheating your oven to 375°F (190°C). First, prepare the meat sauce by sautéing chopped onions and garlic in olive oil until translucent. Add ground beef or a mix of beef and pork, and cook until browned. Stir in a can of crushed tomatoes, basil, oregano, salt, and pepper, and let it simmer for about 20 minutes. In a separate bowl, mix ricotta cheese with an egg, grated Parmesan, and chopped parsley. To assemble the lasagna, spread a layer of meat sauce in a baking dish, followed by a layer of lasagna noodles (no need to boil if using oven-ready noodles). Spread a layer of the ricotta mixture over the noodles, and sprinkle with shredded mozzarella. Repeat the layers until all ingredients are used, finishing with a generous layer of cheese. Cover with foil and bake for 25 minutes, then remove the foil and bake for another 25 minutes until the top is bubbly and golden. Allow it to rest for 15 minutes before slicing to help the layers set. Serve warm with a side of garlic bread or a green salad.", time: 60, userId: "testUserId"),
   ]
}
