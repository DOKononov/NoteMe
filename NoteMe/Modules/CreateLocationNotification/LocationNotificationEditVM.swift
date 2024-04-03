//
//  LocationNotificationEditVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 1.04.24.
//

import UIKit
import MapKit
import Storage

final class LocationNotificationEditVM: LocationNotificationViewModelProtocol, MapModuleDelegate {
    
    var title: String?
    var comment: String?
    var imageDidSet: ((UIImage?) -> Void)?
    var catchTitleError: ((String?) -> Void)?
    var locationDidSet: ((LocationData) -> Void)?
    var catchLocationError: ((Bool) -> Void)?
    var notifyOnEntry: Bool = true
    var notifyOnExit: Bool = false
    var repeats: Bool = false
    var shouldEditeDTO: ((LocationNotificationDTO?) -> Void)?
    
    private var image: UIImage? { didSet{ imageDidSet?(image) } }
    private var region: MKCoordinateRegion?
    private var circularRadius: CLLocationDistance?
    private var dto: LocationNotificationDTO
    private let storage: LocationNotificationStorageUseCase
    private let imageStorage: LocationImageStorageUsecase
    private weak var coordinator: LocationNotificatioCoordinatorProtocol?
    private let notificationService: LocationNotificationServiceUseCase
    
    init(coordinator: LocationNotificatioCoordinatorProtocol,
         dto: LocationNotificationDTO,
         storage: LocationNotificationStorageUseCase,
         imageStorage: LocationImageStorageUsecase,
         notificationService: LocationNotificationServiceUseCase
    ) {
        self.coordinator = coordinator
        self.dto = dto
        self.storage = storage
        self.imageStorage = imageStorage
        self.notificationService = notificationService
        bind()
        setSwitchers()
    }
    
    func viewDidLoad() {
        imageDidSet?(image)
        shouldEditeDTO?(dto)
        self.image = imageStorage.loadImage(id: dto.id)
        setRegion(for: dto)
        self.circularRadius = dto.circularRadius
    }
    
    private func setSwitchers() {
        self.repeats = dto.repeats
        self.notifyOnExit = dto.notifyOnExit
        self.notifyOnEntry = dto.notifyOnEntry
    }
    
    private func setRegion(for dto: LocationNotificationDTO) {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: dto.mapCenterLatitude,
                longitude: dto.mapCenterLongitude),
            span: MKCoordinateSpan(
                latitudeDelta: dto.mapSpanLatitude,
                longitudeDelta: dto.mapSpanLongitude))
    }
    
    func createDidTap() {
        saveDTO()
    }
    
    func mapDidTap() {
        coordinator?.openMapModule(delegate: self, region: region)
    }
    
    func dismissDidTap() {
        coordinator?.finish()
    }
}

//MARK: -private methods
extension LocationNotificationEditVM {
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
    
    private func isValidLocation() -> Bool { true }
    
    private func saveDTO() {
        guard isValidTitle() else { return }
        guard
            let title,
            let image,
            let region,
            let circularRadius
        else { return }
        
        dto.title = title
        dto.subtitle = comment
        dto.mapCenterLatitude = region.center.latitude
        dto.mapCenterLongitude = region.center.longitude
        dto.mapSpanLatitude = region.span.latitudeDelta
        dto.mapSpanLongitude = region.span.longitudeDelta
        dto.notifyOnExit = notifyOnExit
        dto.notifyOnEntry = notifyOnEntry
        dto.repeats = repeats
        dto.circularRadius = circularRadius
        imageStorage.saveImage(id: dto.id, image: image)
        
        notificationService.makeLocationNotification(
            dto: dto, 
            notifyOnEntry: notifyOnEntry,
            notifyOnExit: notifyOnExit,
            repeats: repeats)
        
        storage.updateOrCreate(dto: dto, completion: nil)
        coordinator?.finish()
    }
    
    private func bind() {
        locationDidSet = { [weak self] data in
            self?.image = data.image
            self?.region = data.mapRegion
            self?.circularRadius = data.captureRadius
        }
    }
}
