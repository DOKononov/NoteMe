//
//  NSPredicate+Const.swift
//  Storage
//
//  Created by Dmitry Kononov on 30.01.24.
//

import CoreData

extension NSPredicate {
    
    enum Notification {
        static func notification(by id: String) -> NSPredicate {
            let idKeypath = #keyPath(BaseNotificationMO.identifier)
            return .init(format: "\(idKeypath) CONTAINS[cd] %@", id)
        }
    }
}
