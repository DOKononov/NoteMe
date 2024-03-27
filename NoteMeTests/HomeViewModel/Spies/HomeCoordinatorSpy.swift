//
//  HomeCoordinatorSpy.swift
//  NoteMeTests
//
//  Created by Dmitry Kononov on 26.03.24.
//

import UIKit
@testable import NoteMe
import Storage

final class HomeCoordinatorSpy: HomeCoordinatorProtocol {
    func startEdite(date dto:  DateNotificationDTO) {}
    func startEdite(location dto:  LocationNotificationDTO) {}
    func startEdite(timer dto: TimerNotificationDTO) {}
    func showMenu(_ sender: UIView, delegate: MenuPopoverDelegate) {}
    
}
