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

    public override func toDTO() -> (any DTODescription)? {
        return LocationNotificationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
        guard let dto = dto as? LocationNotificationDTO
        else {
            print("[MODTO]", "\(Self.self) apply failed: dto is type of \(type(of: dto))")
            return
        }
        super.apply(dto: dto)
        self.mapCenterLatitude = dto.mapCenterLatitude
        self.mapCenterLongitude = dto.mapCenterLongitude
        self.mapSpanLatitude = dto.mapSpanLatitude
        self.mapSpanLongitude = dto.mapSpanLongitude
    }
}

