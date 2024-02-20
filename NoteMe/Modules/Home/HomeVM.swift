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
    var tapButtonOnDTO: ((_ sender: UIButton, _ dto: any DTODescription) -> Void)? { get set }
}

protocol HomeCoordinatorProtocol {
    func startEdite(date dto: DateNotificationDTO)
}

final class HomeVM: HomeViewModelProtocol {
    
    private let frcService = FRCService<DateNotificationDTO>()
    private let storage: DateNotificationStorage
    private let adapter: HomeAdapterProtocol
    private let coordinator: HomeCoordinatorProtocol
    var showPopup: ((_ sender: UIButton) -> Void)?
    private var selectedDTO: (any DTODescription)?
    private let sortDescriptor = NSSortDescriptor(key: "targetDate",
                                                  ascending: true)

    
    init(adapter: HomeAdapterProtocol,
         storage: DateNotificationStorage,
         coordinator: HomeCoordinatorProtocol
    ) {
        self.adapter = adapter
        self.storage = storage
        self.coordinator = coordinator
        configFRC()
        loadFromStorage()
        bind()
    }
    
    private func bind() {
        frcService.didChangeContent = { [weak adapter] in
            print("frc result cont: ", $0.count)
            adapter?.relodeData($0)
        }
        
        adapter.tapButtonOnDTO = { [weak self] sender, dto in
            self?.selectedDTO = dto
            self?.showPopup?(sender)
        }
    }
    
    func makeCollectionView() -> UICollectionView {
        adapter.makeCollectionView()
    }
    
    private func configFRC() {
        frcService.config(predicate: nil,sortDescriptors:[sortDescriptor])
    }
    
    private func loadFromStorage() {
        let dtos =  storage.fetch(predicate: nil,
                                  sortDescriptors: [sortDescriptor])
        adapter.relodeData(dtos)
    }
}


extension HomeVM: PopoverVCDelegate {
    func didSelectDelete() {
        guard let selectedDTO else { return }
        storage.delete(dto: selectedDTO as! DateNotificationMO.DTO)
    }
    
    func didSelectEdit() {
        guard let selectedDTO else { return }
        
        switch selectedDTO {
        case is DateNotificationDTO:
            coordinator.startEdite(date: selectedDTO as! DateNotificationDTO)
        default:
            break

        }
    }
}
