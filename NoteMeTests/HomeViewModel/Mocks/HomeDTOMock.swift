//
//  HomeDTOMock.swift
//  NoteMeTests
//
//  Created by Dmitry Kononov on 26.03.24.
//

import Foundation
import Storage
import CoreData

struct HomeDTOMock: DTODescription {
    typealias MO = BaseNotificationMO
    
    var id: String = "test id"
    var date: Date = .init()
    var title: String = "test title"
    var subtitle: String? = "test subtitle"
    var completedDate: Date? = nil
    
    static func fromMO(_ mo: Storage.BaseNotificationMO) -> HomeDTOMock? {
        return nil
    }
}
