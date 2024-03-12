//
//  LocationNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import Storage
import MapKit


protocol LocationNotificatioCoordinatorProtocol: AnyObject {
    func finish()
    func openMapModule(
        delegate: MapModuleDelegate?,
        region: MKCoordinateRegion?
    )
}

final class LocationNotificationVM: LocationNotificationViewModelProtocol, MapModuleDelegate {
    
    var title: String?
    var comment: String?
    var imageDidSet: ((UIImage?) -> Void)?
    var catchTitleError: ((String?) -> Void)?
    var locationDidSet: ((LocationData) -> Void)?
    
    private var image: UIImage? { didSet{ imageDidSet?(image) } }
    private var region: MKCoordinateRegion?
    private var dto: LocationNotificationDTO?
    private let storage =  LocationNotificationStorage() //TODO: fix
    private let imageStorage = ImageStorage() //TODO: fix
    private weak var coordinator: LocationNotificatioCoordinatorProtocol?
    
    init(coordinator: LocationNotificatioCoordinatorProtocol,
         dto: LocationNotificationDTO?) {
        self.coordinator = coordinator
        self.dto = dto
        bind()
        
    }
    func createDidTap() {
        saveDTO()
    }
    
    func mapDidTap() {
        if let region {
            coordinator?.openMapModule(delegate: self, region: region)
        }
        coordinator?.openMapModule(delegate: self, region: nil)
    }
    
    func dismissDidTap() {
        coordinator?.finish()
    }
}

//MARK: -private methods
extension LocationNotificationVM {
    private func isValidTitle() -> Bool {
        guard
            let title,
            !title.isEmpty,
            title != ""
        else {
            catchTitleError?(.Notification.enter_title)
            return false
        }
        catchTitleError?(nil)
        return true
    }
    
    private func saveDTO() {
        //TODO: save dto && image
        guard isValidTitle() else { return }
        guard
            let title,
            let image,
            let region
        else { return }

        if dto != nil {
            dto?.mapCenterLatitude = region.center.latitude
            dto?.mapCenterLongitude = region.center.longitude
            dto?.mapSpanLatitude = region.span.latitudeDelta
            dto?.mapSpanLongitude = region.span.longitudeDelta
            imageStorage.saveImage(id: dto!.id, image: image)
            storage.updateOrCreate(dto: dto!)
        } else {
            let dto = LocationNotificationDTO(
                date: Date(),
                title: title,
                subtitle: comment,
                completedDate: nil,
                mapCenterLatitude: region.center.latitude,
                mapCenterLongitude: region.center.longitude,
                mapSpanLatitude: region.span.latitudeDelta,
                mapSpanLongitude: region.span.longitudeDelta)
            imageStorage.saveImage(id: dto.id, image: image)
            storage.updateOrCreate(dto: dto)
        }
        
        coordinator?.finish()
    }
    
    private func bind() {
        locationDidSet = { [weak self] data in
            self?.image = data.image
            self?.region = data.mapRegion
        }
    }
}
