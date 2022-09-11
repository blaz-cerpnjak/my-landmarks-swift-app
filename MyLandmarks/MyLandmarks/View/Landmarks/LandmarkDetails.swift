//
//  LandmarkDetails.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 27/08/2022.
//

import SwiftUI
import MapKit

struct LandmarkDetails: View {
    @EnvironmentObject var dataController: DataController
    var landmark: Landmark
    
    var landmarkIndex: Int {
        dataController.landmarks.firstIndex(where: {$0.id == landmark.id})!
    }
    
    var body: some View {
        VStack {
            MapView(coordinate: CLLocationCoordinate2DMake(46.0569, 14.5058))
                //.ignoresSafeArea(edges: .top) // if you want it bellow the navigation title
                .frame(height: 300)
            
            if landmark.imageData != nil {
                HStack {
                    Spacer()
                    CircleImage(imageData: landmark.imageData)
                        .offset(y: -130)
                        .padding(.bottom, -130)
                    Spacer()
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                   Text(landmark.name ?? "No name")
                        .font(.title)
                    FavoriteButton(
                        isSet: $dataController.landmarks[landmarkIndex].isFavorite,
                        landmark: dataController.landmarks[landmarkIndex])
                }
                
                HStack {
                    Text(landmark.category ?? "No category")
                        .font(.subheadline)
                    Spacer()
                    Text(formatDate(date: landmark.date!))
                        .font(.subheadline)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()

                Text("About \(landmark.name ?? "No name")")
                    .font(.title2)
                
                Text(landmark.desc ?? "No description.")
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle(landmark.name ?? "No name...")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetails_Previews: PreviewProvider {
    static let dataController = DataController()

    static var previews: some View {
        LandmarkDetails(landmark: DataController().landmarks[0])
            .environmentObject(dataController)
    }
}

