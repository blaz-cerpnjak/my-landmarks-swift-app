//
//  CircleImage.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 11/09/2022.
//

import SwiftUI

struct CircleImage: View {
    var imageData: Data?
    
    var body: some View {
        if imageData != nil {
            Image(uiImage: UIImage(data: imageData!)!)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .cornerRadius(100).overlay(RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.white, lineWidth: 3))
                .shadow(radius: 10)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
