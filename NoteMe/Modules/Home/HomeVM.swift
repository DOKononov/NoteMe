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
    func makeTableView() -> UITableView
    var tapButtonOnDTO: ((_ sender: UIButton, _ dto: any DTODescription) -> Void)? { get set }
}

protocol HomeCoordinatorProtocol {
    func startEdite(date dto: DateNotificationDTO)
}

final class HomeVM: HomeViewModelProtocol {
    func viewDidLoad() {
        frcService.startHandle()
        let dtos = frcService.fetchedDTOs
        adapter.relodeData(dtos)
    }
    
    private let frcService: FRCService<BaseNotificationDTO>
    private let storage: AllNotificationStorage
    private let adapter: HomeAdapterProtocol
    private let coordinator: HomeCoordinatorProtocol
    var showPopup: ((_ sender: UIButton) -> Void)?
    private var selectedDTO: (any DTODescription)?

    init(adapter: HomeAdapterProtocol,
         storage: AllNotificationStorage,
         coordinator: HomeCoordinatorProtocol,
         frcService: FRCService<BaseNotificationDTO>
    ) {
        self.adapter = adapter
        self.storage = storage
        self.coordinator = coordinator
        self.frcService = frcService
        bind()
    }
    
    private func bind() {
        frcService.didChangeContent = { [weak adapter] in
            adapter?.relodeData($0)
        }
        
        adapter.tapButtonOnDTO = { [weak self] sender, dto in
            self?.selectedDTO = dto
            self?.showPopup?(sender)
        }
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
}


extension HomeVM: PopoverVCDelegate {
    func didSelectDelete() {
        guard let selectedDTO else { return }
        storage.delete(dto: selectedDTO)
    }
    
    func didSelectEdit() {
        guard let selectedDTO else { return }
        
        switch selectedDTO {
        case is DateNotificationDTO:
            coordinator.startEdite(date: selectedDTO as! DateNotificationDTO)
        default: break
        }
    }
}
