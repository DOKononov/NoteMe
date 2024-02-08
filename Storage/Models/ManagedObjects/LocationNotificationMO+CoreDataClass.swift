//
//  LocationNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by Dmitry Kononov on 1.02.24.
//
//

import Foundation
import CoreData

@objc(LocationNotificationMO)
 public class LocationNotificationMO: BaseNotificationMO {

     func apply(dto: LocationNotificationDTO) {
         self.identifier = dto.id
         self.date = dto.date
         self.title = dto.title
         self.subtitle = dto.subtitle
         self.completedDate = dto.completedDate
         self.latitude = dto.latitude
         self.longitude = dto.longitude
         self.imagePathStr = dto.imagePathStr
     }
}

extension LocationNotificationMO: MOdescription {
    public func apply(_ dto: any DTODescription) {
        apply(dto: dto as! LocationNotificationDTO)
    }
}
