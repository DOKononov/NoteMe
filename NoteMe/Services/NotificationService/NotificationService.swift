//
//  NotificationSetvice.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 6.03.24.
//

import Foundation
import CoreLocation
import UserNotifications
import Storage

final class NotificationService {
    
     func makeLocationNotification(circleRegion: CLCircularRegion,
                                  dto: LocationNotificationDTO) {
        circleRegion.notifyOnEntry = true
        circleRegion.notifyOnExit = false
        let triger = UNLocationNotificationTrigger(region: circleRegion,
                                                   repeats: false)
        
        let content = UNMutableNotificationContent()
         content.title = dto.title
         
         if let subtitle = dto.subtitle {
             content.body = subtitle

         }
        
         let request = UNNotificationRequest(identifier: dto.id,
                                            content: content,
                                            trigger: triger)
        UNUserNotificationCenter.current().add(request)
    }
}


//        UNTimeIntervalNotificationTrigger(timeInterval: <#T##TimeInterval#>, repeats: <#T##Bool#>)
//        UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: <#T##Bool#>)
//        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: <#T##[String]#>)
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: <#T##[String]#>)


//UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
//    notifications.first?.date
//}
