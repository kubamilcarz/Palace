//
//  PalaceApp.swift
//  Palace
//
//  Created by Kuba Milcarz on 8/1/23.
//

import SwiftUI
import SwiftData

@main
struct PalaceApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
