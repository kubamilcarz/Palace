//
//  DataController.swift
//  Palace
//
//  Created by Kuba Milcarz on 8/30/23.
//

import SwiftUI
import CloudKit
import CoreData

struct DataController {
    static let shared = DataController()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Palace")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        // Check if persistent store already exists
        let storeURL = container.persistentStoreDescriptions.first?.url
        let storeExists = FileManager.default.fileExists(atPath: storeURL?.path ?? "")

        if !storeExists {
            // Perform additional setup for the first launch
            let description = NSPersistentStoreDescription(url: storeURL!)
            container.persistentStoreDescriptions = [description]

            // Additional setup code goes here
            // For example, you can perform initial data population or any other necessary setup steps
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error loading persistent stores: \(error), \(error.userInfo)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
