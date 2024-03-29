//
//  NSSortDescriptor+Const.swift
//  Storage
//
//  Created by Dmitry Kononov on 20.02.24.
//

import CoreData
import Foundation

public extension NSSortDescriptor {
    
    enum Notification {
        public static var byDate: NSSortDescriptor {
            let dateKeyPath = #keyPath(BaseNotificationMO.date)
            return .init(key: dateKeyPath, ascending: false)
        }
        
        public static var byCompleted: NSSortDescriptor {
            let completedKeyPath = #keyPath(BaseNotificationMO.completedDate)
            return .init(key: completedKeyPath, ascending: false)
        }
    }
}
