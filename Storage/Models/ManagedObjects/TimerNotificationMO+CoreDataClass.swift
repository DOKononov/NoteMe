//
//  TimerNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by Dmitry Kononov on 1.02.24.
//
//

import Foundation
import CoreData

@objc(TimerNotificationMO)
 class TimerNotificationMO: BaseNotificationMO {

     func apply(dto: TimerNotificationDTO) {
         self.identifire = dto.id
         self.date = dto.date
         self.title = dto.title
         self.subtitle = dto.subtitle
         self.completedDate = dto.completedDate
         self.targetDate = dto.targetDate
     }
}
