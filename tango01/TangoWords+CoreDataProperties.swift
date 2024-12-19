//
//  TangoWords+CoreDataProperties.swift
//  tango01
//
//  Created by Toshi Fuji on 2024/12/18.
//
//

import Foundation
import CoreData


extension TangoWords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TangoWords> {
        return NSFetchRequest<TangoWords>(entityName: "TangoWords")
    }

    @NSManaged public var content: String?
    @NSManaged public var last_studied: Date?
    @NSManaged public var name: String?
    @NSManaged public var study_count: Int64
    @NSManaged public var word_id: UUID?
    @NSManaged public var tangobook_id: TangoBook?

}

extension TangoWords : Identifiable {

}
