//
//  HomeVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import Foundation
import Storage

protocol HomeAdapterProtocol: AnyObject {
    func relodeData(_ dtoList: [any DTODescription])
}

protocol HomeCoordinatorProtocol {}

final class HomeVM: HomeViewModelProtocol {
    
    private let frcService = FRCService<DateNotificationDTO>(sortDescriptors: [])
    private let adapter: HomeAdapterProtocol
    
    init(adapter: HomeAdapterProtocol
    ) {
        self.adapter = adapter
        bind()
    }
    
    private func bind() {
        frcService.didChangeContent = { [weak adapter] in adapter?.relodeData($0) }
    }
    
}
