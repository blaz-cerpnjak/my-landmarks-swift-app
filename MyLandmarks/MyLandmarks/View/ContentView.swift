//
//  ContentView.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 26/08/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    //@FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var landmarks: FetchedResults<Landmark>
    
    //@State private var showingAddView = false
    
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataController())
    }
}
