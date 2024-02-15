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
public class DateNotificationMO: BaseNotificationMO, MODescription {
    public typealias DTO = DateNotificationDTO
    
    public func apply(dto: DTO) {
         self.identifier = dto.id
         self.date = dto.date
         self.title = dto.title
         self.subtitle = dto.subtitle
         self.completedDate = dto.completedDate
         self.targetDate = dto.targetDate
     }
}
