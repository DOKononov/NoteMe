//
//  DateNotificationMO+CoreDataProperties.swift
//  Storage
//
//  Created by Dmitry Kononov on 30.01.24.
//
//

import Foundation
import CoreData


extension DateNotificationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateNotificationMO> {
        return NSFetchRequest<DateNotificationMO>(entityName: "DateNotificationMO")
    }

    @NSManaged public var targetDate: Date?
}
