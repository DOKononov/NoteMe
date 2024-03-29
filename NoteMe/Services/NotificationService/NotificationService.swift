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
    
    private lazy var notificationCenter = UNUserNotificationCenter.current()
    
    func makeLocationNotification(circleRegion: CLCircularRegion,
                                  dto: LocationNotificationDTO) {
        circleRegion.notifyOnEntry = true
        circleRegion.notifyOnExit = false
        let triger = UNLocationNotificationTrigger(
            region: circleRegion,
            repeats: false)
        
        let content = setContent(dto)
        let request = UNNotificationRequest(
            identifier: dto.id,
            content: content,
            trigger: triger)
        notificationCenter.add(request)
    }
    
    func makeTimerNotification(dto: TimerNotificationDTO) {
        let content = setContent(dto)
        let triger =  UNTimeIntervalNotificationTrigger(
            timeInterval: dto.timeLeft,
            repeats: false)
        let request = UNNotificationRequest(
            identifier: dto.id,
            content: content,
            trigger: triger)
        notificationCenter.add(request)
    }
    
    func makeDateNotification(dto: DateNotificationDTO) {
        let content = setContent(dto)
        let components = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: dto.targetDate)
        let triger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: false)
        let request = UNNotificationRequest(
            identifier: dto.id,
            content: content,
            trigger: triger)
        notificationCenter.add(request)
    }
    
    func deleteNotification(for dto: any DTODescription) {
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [dto.id])
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [dto.id])
    }
    
    private func setContent(_ dto: any DTODescription) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = dto.title
        
        if let subtitle = dto.subtitle {
            content.body = subtitle
        }
        return content
    }
}

//UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
//    notifications.first?.date
//}
