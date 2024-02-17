//
//  HomeVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit
import Storage

protocol HomeAdapterProtocol: AnyObject {
    func relodeData(_ dtoList: [any DTODescription])
    func makeTableView() -> UITableView
}

protocol HomeCoordinatorProtocol {}

final class HomeVM: HomeViewModelProtocol {

    
    private let frcService = FRCService<DateNotificationDTO>()
    private let storage: DateNotificationStorage
    private let adapter: HomeAdapterProtocol
    
    init(adapter: HomeAdapterProtocol,
         storage: DateNotificationStorage
    ) {
        self.adapter = adapter
        self.storage = storage
        frcService.config(
            predicate: nil,
            sortDescriptors: [NSSortDescriptor(key: "identifier", 
                                               ascending: true)])
        loadFromStorage()
        bind()
    }
    
    private func loadFromStorage() {
       let dtos =  storage.fetch(
            predicate: nil,
            sortDescriptors: [NSSortDescriptor(key: "identifier",
                                               ascending: true)])
        adapter.relodeData(dtos)
    }
    
    private func bind() {
        frcService.didChangeContent = { [weak adapter] in
            print($0.count)
            adapter?.relodeData($0)
        }
    }
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    
}
