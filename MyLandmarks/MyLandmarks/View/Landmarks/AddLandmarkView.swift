//
//  AddLandmarkView.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 26/08/2022.
//

import PhotosUI
import SwiftUI

struct AddLandmarkView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    
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
            if let image = self.image {
                HStack {
                    Spacer()
                    CircleImage(imageData: image.pngData())
                    Spacer()
                }
            }
            
            Section {
                TextField("Landmark Name", text: $name)
                
                TextField("Category", text: $category)
                
                TextField("Description", text: $desc)
                
                HStack {
                    TextField("Latitude", text: $latitude)
                    
                    TextField("Longitude", text: $longitude)
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
                Button("Add") {
                    if isValid() {
                        dataController.addLandmark(
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

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
     
    private let controller = UIImagePickerController()
     
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
 
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
        let parent: ImagePicker
 
        init(parent: ImagePicker) {
            self.parent = parent
        }
 
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
 
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
 
    }
     
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.delegate = context.coordinator
        return controller
    }
 
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
 
    }
}

struct AddLandmarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddLandmarkView()
    }
}
