//
//  NSPredicate+Const.swift
//  Storage
//
//  Created by Dmitry Kononov on 30.01.24.
//

import CoreData

public extension NSPredicate {
    
    enum Notification {
        
        public static var allNotComplited: NSPredicate {
            let complitedDateKeyPath = #keyPath (BaseNotificationMO.completedDate)
            return .init(format: "\(complitedDateKeyPath) == NULL")
        }
        
        public static func notification(by id: String) -> NSPredicate {
            let idKeypath = #keyPath(BaseNotificationMO.identifier)
            return .init(format: "\(idKeypath) CONTAINS[cd] %@", id)
        }
        
        public static func notifications(in ids: [String]) -> NSPredicate {
            let idKeypath = #keyPath(BaseNotificationMO.identifier)

            return NSCompoundPredicate(andPredicateWithSubpredicates: [
                .init(format: "\(idKeypath) IN %@", ids),
                allNotComplited
            ])
        }
    }
}
