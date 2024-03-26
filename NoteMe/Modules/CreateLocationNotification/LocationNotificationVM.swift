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
        dto: LocationNotificationDTO,
        completion: ((Bool) -> Void)?
    )
}
protocol LocationImageStorageUsecase {
    func loadImage(id: String) -> UIImage?
    func saveImage(id: String, image: UIImage?)
}

protocol LocationNotificationServiceUseCase {
    func makeLocationNotification(
        circleRegion: CLCircularRegion,
        dto: LocationNotificationDTO
    )
}

final class LocationNotificationVM: LocationNotificationViewModelProtocol, MapModuleDelegate {
    
    var title: String?
    var comment: String?
    var imageDidSet: ((UIImage?) -> Void)?
    var catchTitleError: ((String?) -> Void)?
    var locationDidSet: ((LocationData) -> Void)?
    var shouldEditeDTO: ((LocationNotificationDTO) -> Void)?
    
    private var image: UIImage? { didSet{ imageDidSet?(image) } }
    private var region: MKCoordinateRegion?
    private var circularRegionCenter: CLLocationCoordinate2D?
    private var circularRegionRadius: CLLocationDistance?
    private var dto: LocationNotificationDTO?
    private let storage: LocationNotificationStorageUseCase
    private let imageStorage: LocationImageStorageUsecase
    private weak var coordinator: LocationNotificatioCoordinatorProtocol?
    private let notificationService: LocationNotificationServiceUseCase
    
    init(coordinator: LocationNotificatioCoordinatorProtocol,
         dto: LocationNotificationDTO?,
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
    }
    
    func viewDidLoad() {
        imageDidSet?(image)
        guard let dto else { return }
        shouldEditeDTO?(dto)
        self.image = imageStorage.loadImage(id: dto.id)
        setRegion(for: dto)
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
        guard isValidTitle() else { return }
        guard
            let title,
            let image,
            let region,
            let circularRegionCenter,
            let circularRegionRadius
        else { return }
        
        if dto != nil, let id = dto?.id {
            dto?.mapCenterLatitude = region.center.latitude
            dto?.mapCenterLongitude = region.center.longitude
            dto?.mapSpanLatitude = region.span.latitudeDelta
            dto?.mapSpanLongitude = region.span.longitudeDelta
            imageStorage.saveImage(id: id, image: image)
            
            let region = CLCircularRegion(center: circularRegionCenter,
                                          radius: circularRegionRadius,
                                          identifier: id)
            
            notificationService.makeLocationNotification(circleRegion: region, dto: dto!)
            
            storage.updateOrCreate(dto: dto!, completion: nil)
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
            storage.updateOrCreate(dto: dto, completion: nil)
            
            let region = CLCircularRegion(center: circularRegionCenter,
                                           radius: circularRegionRadius,
                                           identifier: dto.id)
            
            notificationService.makeLocationNotification(circleRegion: region, dto: dto)
        }
        coordinator?.finish()
    }
    
    private func bind() {
        locationDidSet = { [weak self] data in
            self?.image = data.image
            self?.region = data.mapRegion
            self?.circularRegionCenter = data.captureCenter
            self?.circularRegionRadius = data.captureRadius
        }
    }
}

