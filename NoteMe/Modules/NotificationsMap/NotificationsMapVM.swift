//
//  NotificationsMapVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 18.03.24.
//

import Foundation
import Storage
import CoreLocation
import MapKit


protocol NotificationsMapCoordinatorProtocol {
    func finish()
    func startEdite(location dto: LocationNotificationDTO)
}

protocol NotificationsMapFRCUseCase {
    var didChangeContent: (([any DTODescription]) -> Void)? { get set }
    var fetchedDTOs: [any DTODescription] { get }
    func startHandle()
}


final class NotificationsMapVM: NotificationsMapViewModelProtocol {
    var defaultRegion: ((MKCoordinateRegion) -> Void)?
    var updateAnatations: (([LocationAnnotation]) -> Void)?
    
    private var dtos: [LocationNotificationDTO] = [] {
        didSet {
            updateAnatations?(convertToPins(dtos: dtos))
        }
    }
    private let coordinator: NotificationsMapCoordinatorProtocol
    private var frc: NotificationsMapFRCUseCase
    private lazy var locationManager: CLLocationManager = .init()
    
    init(coordinator: NotificationsMapCoordinatorProtocol,
         frc: NotificationsMapFRCUseCase) {
        self.coordinator = coordinator
        self.frc = frc
        bind()
    }
    
    func viewDidLoad() {
        frc.startHandle()
        self.dtos = filter(dtos: frc.fetchedDTOs)
        updateAnatations?(convertToPins(dtos: dtos))
        setDefaultRegion()
    }
    
    func dismissDidTap() {
        coordinator.finish()
    }
    
    private func setDefaultRegion() {
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation,
                                                latitudinalMeters: 1000,
                                                longitudinalMeters: 1000)
            defaultRegion?(viewRegion)
        }
    }
    
    
    
    func didSelectLocation(id: String) {
        guard let dto =  dtos.first(where: { $0.id == id }) else { return }
        coordinator.startEdite(location: dto)
    }
    
    
    private func bind() {
        frc.didChangeContent = { [weak self] dtos in
            self?.dtos = self?.filter(dtos: dtos) ?? []
        }
    }
    
    
    private func filter(dtos: [any DTODescription]) -> [LocationNotificationDTO] {
        let filtered = dtos.filter { dto in
            return dto is LocationNotificationDTO
        }
        return filtered.compactMap { dtodescription in
            return dtodescription as? LocationNotificationDTO
        }
    }
    
    private func convertToPins(dtos: [LocationNotificationDTO]) -> [LocationAnnotation] {
        var pins: [LocationAnnotation] = []
        dtos.forEach { dto in
            let pin = LocationAnnotation(coordinate: CLLocationCoordinate2D(
                latitude: dto.mapCenterLatitude,
                longitude: dto.mapCenterLongitude),
                                         id: dto.id,
                                         title: dto.title,
                                         subtitle: dto.subtitle)
            
            pins.append(pin)
        }
        return pins
    }
    
}
