//
//  PiRecord+CoreDataProperties.swift
//  Palace
//
//  Created by Kuba Milcarz on 8/30/23.
//
//

import Foundation
import CoreData


extension PiRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PiRecord> {
        return NSFetchRequest<PiRecord>(entityName: "PiRecord")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var attemptDate: Date?
    @NSManaged public var score: Int64
    @NSManaged public var time: Double

}

extension PiRecord : Identifiable {

}
