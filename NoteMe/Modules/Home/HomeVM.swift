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
    var filterDidSelect: ((NotificationFilterType) -> Void)? { get set }
}

protocol HomeCoordinatorProtocol {
    func startEdite(date dto: DateNotificationDTO)
    func startEdite(location dto: LocationNotificationDTO)
    func startEdite(timer dto: TimerNotificationDTO)
    func showMenu(_ sender: UIView, delegate: MenuPopoverDelegate)
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
    private var selectedDTO: (any DTODescription)?
    private var selectedFilter: NotificationFilterType = .all {
        didSet {
            adapter.relodeData(filterResults())
        }
    }

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
        frcService.didChangeContent = { [weak self] _ in
            self?.adapter.relodeData(self?.filterResults() ?? [])
        }
        
        adapter.tapButtonOnDTO = { [weak self] sender, dto in
            guard let self else { return }
            self.selectedDTO = dto
            self.coordinator.showMenu(sender, delegate: self)
        }
        
        adapter.filterDidSelect = { [weak self] type in
            self?.selectedFilter = type
        }
        
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    private func filterResults() -> [any DTODescription] {
        frcService.fetchedDTOs.filter { dto in
           switch selectedFilter {
           case .date:
               return dto is DateNotificationDTO
           case .timer:
               return dto is TimerNotificationDTO
           case .location:
               return dto is LocationNotificationDTO
           default:
               return true
           }
       }
    }
}

extension HomeVM: MenuPopoverDelegate {
    func didSelect(action: MenuPopoverVC.Action) {
        guard let selectedDTO else { return }
        
        switch action {
        case .edite:
            switch selectedDTO {
            case is DateNotificationDTO:
                coordinator.startEdite(date: selectedDTO as! DateNotificationDTO)
            case is LocationNotificationDTO:
                coordinator.startEdite(location: selectedDTO as! LocationNotificationDTO)
                break
            case is TimerNotificationDTO:
                coordinator.startEdite(timer: selectedDTO as! TimerNotificationDTO)
                break
            default: break
            }
        case .delete: storage.delete(dto: selectedDTO)
        default: break
        }
    }
}
