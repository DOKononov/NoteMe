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

protocol LocationImageStorageUsecase {
    func download(id: String, completion: @escaping ((UIImage?)-> Void))
    func upload(id: String, image: UIImage, completion: ((Bool) -> Void)?)
}

protocol LocationNotificationWorkerUseCase {
    func createOrUpdate(dto: any DTODescription, completion: ((Bool) -> Void)?)
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
    
    private weak var coordinator: LocationNotificatioCoordinatorProtocol?
    private let worker: LocationNotificationWorkerUseCase
    private let imageStorage: LocationImageStorageUsecase
    
    init(coordinator: LocationNotificatioCoordinatorProtocol,
         worker: LocationNotificationWorkerUseCase,
         imageStorage: LocationImageStorageUsecase
    ) {
        self.coordinator = coordinator
        self.worker = worker
        self.imageStorage = imageStorage
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
        
        let dto = makeDTO(region: region,
                          title: title,
                          circularRadius: circularRadius)
        
        worker.createOrUpdate(dto: dto, completion: nil)
        imageStorage.upload(id: dto.id, image: image) { [weak self] _ in
            DispatchQueue.main.async {
                self?.coordinator?.finish()
            }
        }
        //TODO: -
        /// Написать воркер для сохранения файлов в две системы:
        /// - В файлменеджер
        /// - В FirebaseStorage
        ///
        /// Загрузка изображения
        /// - если на телефоне есть  то заугрзка идет с fileManager
        /// - иначе загрузка идет с облака (firebaseStorage)
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

