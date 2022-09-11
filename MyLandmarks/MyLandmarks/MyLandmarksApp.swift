//
//  MyLandmarksApp.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 26/08/2022.
//

import SwiftUI

@main
struct MyLandmarksApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
