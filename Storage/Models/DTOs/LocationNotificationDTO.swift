//
//  LocationNotificationDTO.swift
//  Storage
//
//  Created by Dmitry Kononov on 1.02.24.
//

import Foundation

public struct LocationNotificationDTO: DTODescription {
    public typealias DTO = Self
    public typealias MO = LocationNotificationMO
    
    public var date: Date
    public var id: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var latitude: Double
    public var longitude: Double
    public var imagePathStr: String
    
    public init(date: Date,
                id: String,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                latitude: Double,
                longitude: Double,
                imagePathStr: String) {
        self.date = date
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.latitude = latitude
        self.longitude = longitude
        self.imagePathStr = imagePathStr
    }
    
    public init?(mo: LocationNotificationMO) {
        guard
            let date = mo.date,
            let identifier = mo.identifier,
            let title = mo.title,
            let imagePathStr = mo.imagePathStr
        else { return nil }
        self.date = date
        self.id = identifier
        self.title = title
        self.subtitle = mo.subtitle
        self.completedDate = mo.completedDate
        self.latitude = mo.latitude
        self.longitude = mo.longitude
        self.imagePathStr = imagePathStr
    }
}
