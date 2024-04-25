//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit
import Storage

final class HomeAssembler {
    private init() {}
        
    static func make(coordinator: HomeCoordinatorProtocol,
                     container: Container
    ) -> UIViewController {
        let adapter = HomeAdapter()
        let worker: NotificationDataWorker = container.resolve()
        
        let viewModel = HomeVM(adapter: adapter,
                               coordinator: coordinator,
                               frcService: makeFRC(), 
                               worker: worker)

        let vc = HomeVC(viewModel: viewModel)
        return vc
    }
    
    private static func makeFRC() -> FRCService<BaseNotificationDTO> {
        .init { request in
//            request.predicate = .Notification.allNotComplited
            request.sortDescriptors = [.Notification.byDate]
        }
    }
}
