//
//  FavoriteButton.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 27/08/2022.
//

import SwiftUI

struct FavoriteButton: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    
    @Binding var isSet: Bool
    var landmark: Landmark
    
    var body: some View {
        Button {
            isSet.toggle()
            dataController.setFavorite(landmark: landmark, isFavorite: isSet, context: managedObjectContext)
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("Favorite Button")
    }
}
