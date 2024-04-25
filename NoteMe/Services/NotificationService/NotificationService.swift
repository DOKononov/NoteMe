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
    
    func makeLocationNotification(dto: LocationNotificationDTO) {
        let circleRegion = makeCircleRegion(dto: dto)
        circleRegion.notifyOnEntry = dto.notifyOnEntry
        circleRegion.notifyOnExit = dto.notifyOnExit
        let triger = UNLocationNotificationTrigger(
            region: circleRegion,
            repeats: dto.repeats)
        
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
    
    func deleteNotification(for id: [String]) {
        notificationCenter.removeDeliveredNotifications(withIdentifiers: id)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: id)
    }
    
    private func setContent(_ dto: any DTODescription) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = dto.title
        
        if let subtitle = dto.subtitle {
            content.body = subtitle
        }
        return content
    }
    
    private func makeCircleRegion(dto: LocationNotificationDTO) -> CLCircularRegion {
        return CLCircularRegion(
            center: CLLocationCoordinate2D(
                latitude: dto.mapCenterLatitude,
                longitude: dto.mapCenterLongitude),
            radius: dto.circularRadius,
            identifier: dto.id)
    }
}
