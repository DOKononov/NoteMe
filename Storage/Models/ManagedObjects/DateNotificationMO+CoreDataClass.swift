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
public class DateNotificationMO: BaseNotificationMO {
    
    public override func toDTO() -> (any DTODescription)? {
        return DateNotificationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
        guard let dto = dto as? DateNotificationDTO 
        else {
            print("[MODTO]", "\(Self.self) apply failed: dto is type of \(type(of: dto))")
            return
        }
        super.apply(dto: dto)
        self.targetDate = dto.targetDate
    }
}

