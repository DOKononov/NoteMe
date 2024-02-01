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
 class LocationNotificationMO: BaseNotificationMO {

     func apply(dto: LocationNotificationDTO) {
         self.identifire = dto.id
         self.date = dto.date
         self.title = dto.title
         self.subtitle = dto.subtitle
         self.completedDate = dto.completedDate
         self.latitude = dto.latitude
         self.longitude = dto.longitude
         self.imagePathStr = dto.imagePathStr
     }
}
