//
//  HomeVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import Foundation
import Storage
import UIKit

protocol HomeAdapterProtocol: AnyObject {
    func relodeData(_ dtoList: [any DTODescription])
    func makeCollectionView() -> UICollectionView
    var tapButtonOnDTO: ((any DTODescription) -> Void)? { get set }
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
            sortDescriptors:
                [NSSortDescriptor(key: "targetDate",
                                  ascending: true)])
        loadFromStorage()
        bind()
    }
    
    private func loadFromStorage() {
        let dtos =  storage.fetch(
            predicate: nil,
            sortDescriptors: [NSSortDescriptor(key: "targetDate",
                                               ascending: true)])
        adapter.relodeData(dtos)
    }
    
    private func bind() {
        frcService.didChangeContent = { [weak adapter] in
            print("frc result cont: ", $0.count)
            adapter?.relodeData($0)
        }
        
        adapter.tapButtonOnDTO = {  dto in
            self.storage.delete(dto: dto as! DateNotificationMO.DTO)
            //TODO:
            // let vc = PopoverVC.make(type: .edit, for: addButton)
            // vc.delegate = self
            // present(vc, animated: true)
        }
    }
    
    func makeCollectionView() -> UICollectionView {
        adapter.makeCollectionView()
    }
}


