//
//  DateNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by Dmitry Kononov on 30.01.24.
//
//

import Foundation
import CoreData

@objc(DateNotificationMO)
 class DateNotificationMO: BaseNotificationMO {
     
     func apply(dto: DateNotificationDTO) {
         self.identifire = dto.id
         self.date = dto.date
         self.title = dto.title
         self.subtitle = dto.subtitle
         self.completedDate = dto.completedDate
         self.targetDate = dto.targetDate
     }
     
}
