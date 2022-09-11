//
//  LandmarkRow.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 27/08/2022.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    
    var body: some View {
        
        HStack {
            if landmark.imageData != nil {
                Image(uiImage: UIImage(data: landmark.imageData!)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .cornerRadius(80)
            }
            
            Text(landmark.name ?? "No name")
            
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Text("Test")
    }
}
