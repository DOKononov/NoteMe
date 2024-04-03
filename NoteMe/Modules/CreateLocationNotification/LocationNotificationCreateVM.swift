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

protocol LocationNotificationStorageUseCase {
    func updateOrCreate(
        dto: any DTODescription,
        completion: ((Bool) -> Void)?
    )
}
protocol LocationImageStorageUsecase {
    func loadImage(id: String) -> UIImage?
    func saveImage(id: String, image: UIImage)
}

protocol LocationNotificationServiceUseCase {
    func makeLocationNotification(
        dto: LocationNotificationDTO,
        notifyOnEntry: Bool,
        notifyOnExit: Bool,
        repeats: Bool
    )
}

final class LocationNotificationCreateVM: LocationNotificationViewModelProtocol, MapModuleDelegate {
    
    var title: String?
    var comment: String?
    var imageDidSet: ((UIImage?) -> Void)?
    var catchTitleError: ((String?) -> Void)?
    var catchLocationError: ((Bool) -> Void)?
    var locationDidSet: ((LocationData) -> Void)?
    var shouldEditeDTO: ((LocationNotificationDTO?) -> Void)?
    var notifyOnEntry: Bool = true
    var notifyOnExit: Bool = false
    var repeats: Bool = false
    
    private var image: UIImage? { didSet{ imageDidSet?(image) } }
    private var region: MKCoordinateRegion?
    private var circularRadius: CLLocationDistance?
    private let storage: LocationNotificationStorageUseCase
    private let imageStorage: LocationImageStorageUsecase
    private weak var coordinator: LocationNotificatioCoordinatorProtocol?
    private let notificationService: LocationNotificationServiceUseCase
    
    init(coordinator: LocationNotificatioCoordinatorProtocol,
         storage: LocationNotificationStorageUseCase,
         imageStorage: LocationImageStorageUsecase,
         notificationService: LocationNotificationServiceUseCase
    ) {
        self.coordinator = coordinator
        self.storage = storage
        self.imageStorage = imageStorage
        self.notificationService = notificationService
        bind()
    }
    
    func viewDidLoad() {
        imageDidSet?(image)
        shouldEditeDTO?(nil)
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
extension LocationNotificationCreateVM {
    private func isValidTitle() -> Bool {
        guard let title, !title.isEmpty, title != "" else {
            catchTitleError?(.Notification.enter_title)
            return false
        }
        catchTitleError?(nil)
        return true
    }
    
    private func isValidLocation() -> Bool {
        if  region != nil && circularRadius != nil {
            catchLocationError?(false)
            return true
        } else {
            catchLocationError?(true)
            return false
        }
    }
    
    private func saveDTO() {
        guard isValidTitle() && isValidLocation() else { return }
        guard let title, let image, let region, let circularRadius else { return }
        
        let dto = makeDTO(region: region, title: title, circularRadius: circularRadius)
        imageStorage.saveImage(id: dto.id, image: image)
        storage.updateOrCreate(dto: dto, completion: nil)
        
        notificationService.makeLocationNotification(
            dto: dto,
            notifyOnEntry: notifyOnEntry,
            notifyOnExit: notifyOnExit,
            repeats: repeats)
        
        coordinator?.finish()
    }
    
    private func bind() {
        locationDidSet = { [weak self] data in
            self?.image = data.image
            self?.region = data.mapRegion
            self?.circularRadius = data.captureRadius
        }
    }
    
    private func makeDTO(
        region: MKCoordinateRegion,
        title: String,
        circularRadius: CLLocationDistance) -> LocationNotificationDTO {
            return LocationNotificationDTO(
                date: Date(),
                title: title,
                subtitle: comment,
                completedDate: nil,
                mapCenterLatitude: region.center.latitude,
                mapCenterLongitude: region.center.longitude,
                mapSpanLatitude: region.span.latitudeDelta,
                mapSpanLongitude: region.span.longitudeDelta,
                circularRadius: circularRadius,
                repeats: repeats,
                notifyOnEntry: notifyOnEntry,
                notifyOnExit: notifyOnExit
            )
        }
}

