//
//  PalaceApp.swift
//  Palace
//
//  Created by Kuba Milcarz on 8/1/23.
//

import SwiftUI
//import SwiftData

@main
struct PalaceApp: App {
    let dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()  
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .preferredColorScheme(.dark)
        }
//        .modelContainer(for: PiRun.self)
        #if os(visionOS)
//        .defaultSize(width: 400, height: 600, depth: 1)
        #endif
    }
}
