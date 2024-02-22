//
//  TimerNotificationDTO.swift
//  Storage
//
//  Created by Dmitry Kononov on 1.02.24.
//

import Foundation

public struct TimerNotificationDTO: DTODescription {
    public typealias MO = TimerNotificationMO
    
    public var date: Date
    public var id: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var targetDate: Date
    
    public var timeLeft: TimeInterval {
        get {targetDate.timeIntervalSince(date)}
        set {targetDate = date.addingTimeInterval(newValue)}
    }
    
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
    
    public static func fromMO(_ mo: TimerNotificationMO) -> TimerNotificationDTO? {
        guard
            let id = mo.identifier,
            let title = mo.title,
            let date = mo.date,
            let targetDate = mo.targetDate
        else { return nil }
        
        return TimerNotificationDTO(date: date,
                                    id: id,
                                    title: title,
                                    subtitle: mo.subtitle,
                                    completedDate: mo.completedDate,
                                    targetDate: targetDate)
    }
}
