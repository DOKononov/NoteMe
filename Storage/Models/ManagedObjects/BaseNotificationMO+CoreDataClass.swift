//
//  BaseNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by Dmitry Kononov on 30.01.24.
//
//

import Foundation
import CoreData

@objc(BaseNotificationMO)
public class BaseNotificationMO: NSManagedObject, MODescription {
    
    public func toDTO() -> (any DTODescription)? {
        return BaseNotificationDTO.fromMO(self)
    }
    
    public func apply(dto: any DTODescription) {
        self.identifier = dto.id
        self.date = dto.date
        self.completedDate = dto.completedDate
        self.title = dto.title
        self.subtitle = dto.subtitle
    }
}

