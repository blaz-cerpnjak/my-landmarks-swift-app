//
//  LandmarkList.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 27/08/2022.
//

import SwiftUI

struct LandmarkList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    @State private var showFavoritesOnly = false
    @State private var showingAddView = false
    @State private var showingEditView = false
    @State private var selectedLandmark: Landmark = Landmark()
    
    var filteredLandmarks: [Landmark] {
        dataController.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    func setLandmark(landmark: Landmark) {
        self.selectedLandmark = landmark
        print("tu")
        showingEditView = true
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetails(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteLandmark(landmark: landmark)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button(action: {
                            setLandmark(landmark: landmark)
                        }, label: {
                            Label("Edit", systemImage: "pencil.circle")
                        })
                    }
                }
            }
            .navigationTitle("Landmarks")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Landmark", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddLandmarkView()
            }
            .sheet(isPresented: $showingEditView) {
                EditLandmarkView(landmark: self.$selectedLandmark)
            }
        }
    }
    
    private func deleteLandmark(landmark: Landmark) {
        withAnimation {
            dataController.deleteLandmark(landmark: landmark, context: managedObjectContext)
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(DataController())
    }
}
