//
//  LocationNotificationDTO.swift
//  Storage
//
//  Created by Dmitry Kononov on 1.02.24.
//

import Foundation

public struct LocationNotificationDTO: DTODescription {
    public typealias MO = LocationNotificationMO
    
    public var date: Date
    public var id: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    
    public var mapCenterLatitude: Double
    public var mapCenterLongitude: Double
    public var mapSpanLatitude: Double
    public var mapSpanLongitude: Double
    
    public init(date: Date,
                id: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                mapCenterLatitude: Double,
                mapCenterLongitude: Double,
                mapSpanLatitude: Double,
                mapSpanLongitude: Double
    ) {
        self.date = date
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.mapCenterLatitude = mapCenterLatitude
        self.mapCenterLongitude = mapCenterLongitude
        self.mapSpanLatitude = mapSpanLatitude
        self.mapSpanLongitude = mapSpanLongitude
    }
    
    public static func fromMO(_ mo: LocationNotificationMO) -> LocationNotificationDTO? {
        guard
            let date = mo.date,
            let identifier = mo.identifier,
            let title = mo.title
        else { return nil }
        return LocationNotificationDTO(
            date: date,
            id: identifier,
            title: title,
            subtitle: mo.subtitle,
            completedDate: mo.completedDate,
            mapCenterLatitude: mo.mapCenterLatitude,
            mapCenterLongitude: mo.mapCenterLongitude,
            mapSpanLatitude: mo.mapSpanLatitude,
            mapSpanLongitude: mo.mapSpanLongitude
        )
    }
}
