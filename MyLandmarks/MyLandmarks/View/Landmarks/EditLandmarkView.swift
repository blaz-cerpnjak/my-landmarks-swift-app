//
//  EditLandmarkView.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 26/08/2022.
//

import PhotosUI
import SwiftUI

struct EditLandmarkView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    
    @Binding var landmark: Landmark
    
    @State private var name = ""
    @State private var category = ""
    @State private var desc = ""
    @State private var latitude = ""
    @State private var longitude = ""
    @State private var showImagePicker = false
    @State private var image: UIImage?
    
    @State private var showErrorMessage = false
    @State private var error: String = ""
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                if image != nil {
                    CircleImage(imageData: image!.pngData())
                } else {
                    CircleImage(imageData: landmark.imageData)
                }
                Spacer()
            }
            
            Section {
                TextField("Landmark Name", text: $name)
                    .onAppear {
                        self.name = landmark.name ?? ""
                    }
                
                TextField("Category", text: $category)
                    .onAppear {
                        self.category = landmark.category ?? ""
                    }
                
                TextField("Description", text: $desc)
                    .onAppear {
                        self.desc = landmark.desc ?? ""
                    }
                
                HStack {
                    TextField("Latitude", text: $latitude)
                        .onAppear {
                            self.latitude = String(landmark.latitude)
                        }
                    
                    TextField("Longitude", text: $longitude)
                        .onAppear {
                            self.longitude = String(landmark.longitude)
                        }
                }
                
                HStack {
                    Spacer()
                    Button("Select Photo") {
                        showImagePicker.toggle()
                    }
                    Spacer()
                }
            }
            
            HStack {
                Spacer()
                Button("Save") {
                    if isValid() {
                        dataController.editLandmark(
                            landmark: landmark,
                            name: name,
                            category: category,
                            desc: desc,
                            lat: Double(latitude)!,
                            lon: Double(longitude)!,
                            imageData: image?.pngData() ?? nil,
                            context: managedObjectContext)
                    }
                    dismiss()
                }
                .alert(isPresented: $showErrorMessage) {
                    Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
                .ignoresSafeArea()
        }
    }

    func isValid() -> Bool {
        if name.isEmpty {
            self.error = "Name cannot be empty."
            self.showErrorMessage = true
            return false
        }
        
        if category.isEmpty {
            self.error = "Category cannot be empty."
            self.showErrorMessage = true
            return false
        }
        
        if !latitude.isEmpty || !longitude.isEmpty {
            if Double(latitude) == nil {
                self.error = "Invalid latitude."
                self.showErrorMessage = true
                return false
            }
            
            if Double(longitude) == nil {
                self.error = "Invalid longitude."
                self.showErrorMessage = true
                return false
            }
        }
        
        self.showErrorMessage = false
        self.error = ""
        
        return true
    }
}

struct EditLandmarkView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Edit")
    }
}
