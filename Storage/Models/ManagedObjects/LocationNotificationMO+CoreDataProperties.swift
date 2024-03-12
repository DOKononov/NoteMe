//
//  LocationNotificationMO+CoreDataProperties.swift
//  Storage
//
//  Created by Dmitry Kononov on 1.02.24.
//
//

import Foundation
import CoreData


extension LocationNotificationMO {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationNotificationMO> {
        return NSFetchRequest<LocationNotificationMO>(entityName: "LocationNotificationMO")
    }
    
    @NSManaged public var mapCenterLatitude: Double
    @NSManaged public var mapCenterLongitude: Double
    @NSManaged public var mapSpanLatitude: Double
    @NSManaged public var mapSpanLongitude: Double
}
