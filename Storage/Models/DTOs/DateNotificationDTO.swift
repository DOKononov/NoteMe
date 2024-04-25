//
//  DateNotificationDTO.swift
//  Storage
//
//  Created by Dmitry Kononov on 30.01.24.
//

import Foundation
import CoreData

public struct DateNotificationDTO: DTODescription {
    public typealias MO = DateNotificationMO
    
    public var date: Date
    public var id: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var targetDate: Date
    
    public init(date: Date,
                id: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                targetDate: Date) {
        self.date = date
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.targetDate = targetDate
    }

    public static func fromMO(_ mo: DateNotificationMO) -> DateNotificationDTO? {
        guard
            let id = mo.identifier,
            let title = mo.title,
            let date = mo.date,
            let targetDate = mo.targetDate
        else { return nil }
        return DateNotificationDTO(
            date: date,
            id: id,
            title: title,
            subtitle: mo.subtitle,
            completedDate: mo.completedDate,
            targetDate: targetDate
        )
    }
    
    public func createMO(context: NSManagedObjectContext) -> DateNotificationMO? {
        let mo = DateNotificationMO(context: context)
        mo.apply(dto: self)
        return mo
    }
}
