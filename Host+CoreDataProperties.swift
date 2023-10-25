//
//  Host+CoreDataProperties.swift
//  Surfing
//
//  Created by Bechir Kefi on 25/10/2023.
//
//

import Foundation
import CoreData


extension Host {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Host> {
        return NSFetchRequest<Host>(entityName: "Host")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var image: String?

}

extension Host : Identifiable {

}
