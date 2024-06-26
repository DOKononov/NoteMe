//
//  MapVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 6.03.24.
//

import Foundation
import MapKit

protocol MapModuleDelegate: AnyObject {
    var locationDidSet: ((LocationData) -> Void)? { get set }
}

protocol MapCoordinatorProtocol {
    func finish()
}

protocol MapLocationNetworkServiceUseCase {
    func getNearBy(
        coordinates: CLLocationCoordinate2D,
        completion: @escaping ([NearByResponseModel.Result]) -> Void
    )
    
    func searchPlaces(
        for query: String,
        with coordinates: CLLocationCoordinate2D,
        completion: @escaping (([SearchPlacesResponseModel.Result]) -> Void)
    )
}

protocol MapAdapterProtocol {
    var didSelectRow: ((Place) -> Void)? { get set }
    func reloadData(with rows: [Place])
    func makeTableView() -> UITableView
}

final class MapVM: MapViewModelProtocol {
    var snapshotDidChanged: ((UIImage?) -> Void)?
    
    private let coordinator: MapCoordinatorProtocol
    private lazy var locationManager: CLLocationManager = .init()
    private var locationNetworkService: MapLocationNetworkServiceUseCase
    weak var delegate: MapModuleDelegate?
    var locationDidSelect: ((CLLocationCoordinate2D) -> Void)?
    var isSelected: Bool { (snapshot != nil) }
    private var snapshot: UIImage? { didSet { snapshotDidChanged?(snapshot) } }
    private let region: MKCoordinateRegion?
    private var adapter: MapAdapterProtocol
    private var places: [Place] = [] 
    
    
    init(coordinator: MapCoordinatorProtocol,
         delegate: MapModuleDelegate?,
         region: MKCoordinateRegion?,
         locationNetworkService: MapLocationNetworkServiceUseCase,
         adapter: MapAdapterProtocol
    ) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.region = region
        self.adapter = adapter
        self.locationNetworkService = locationNetworkService
        locationManager.requestWhenInUseAuthorization()
        bind()
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    func setDefaultMapPosition(for mapView: MKMapView) {
        
        if let region {
            mapView.setRegion(region, animated: true)
        } else {
            if let userLocation = locationManager.location?.coordinate {
                let viewRegion = MKCoordinateRegion(center: userLocation,
                                                    latitudinalMeters: 1000,
                                                    longitudinalMeters: 1000)
                mapView.setRegion(viewRegion, animated: true)
            }
        }
    }
    
    func dismissDidTap() {
        if snapshot != nil {
            self.snapshot = nil
        } else {
            coordinator.finish()
        }
    }
    
    func makeSnapshot(_ view: UIView,
                      mapView: MKMapView,
                      captureView: UIView) {
        let snapshotSize = CGSize(width: mapView.frame.width,
                                  height: captureView.frame.height*2)
        let origin = CGPoint(x: .zero,
                             y: -(captureView.center.y - snapshotSize.height/2))
        let contentRect = CGRect(origin: origin, size: view.bounds.size)
        
        UIGraphicsBeginImageContextWithOptions(snapshotSize,
                                               false,
                                               UIScreen.main.scale)
        
        view.drawHierarchy(in: contentRect, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.snapshot = image
    }
    
    func confirmDidTap(mapView: MKMapView, captureView: UIView) {
        let radius = calculateRadius(for: captureView, in: mapView)
        let region = mapView.region
        
        let locationData = LocationData(image: snapshot,
                                        captureRadius: radius,
                                        mapRegion: region)
        delegate?.locationDidSet?(locationData)
        
        coordinator.finish()
    }
    
    func viewDidLoad() {
        getNearBy()
    }
    
    
    private func getNearBy() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        locationNetworkService.getNearBy(coordinates: userLocation) { [weak self] result in
            DispatchQueue.main.async {
                self?.places =  result.compactMap { Place(result: $0) }
                self?.adapter.reloadData(with: self?.places ?? [])
            }
        }
    }
    
    func searchPlaces(for query: String) {
        if query.isEmpty {
            getNearBy()
        } else {
            guard let userLocation = locationManager.location?.coordinate else { return }
            locationNetworkService.searchPlaces(for: query, with: userLocation) { [weak self] result in
                DispatchQueue.main.async {
                    self?.places = result
                        .compactMap { Place(result: $0) }
                        .sorted { $0.distance < $1.distance }
                    self?.adapter.reloadData(with: self?.places ?? [])
                }
            }
        }
    }
    
    
    private func bind() {
        adapter.didSelectRow = { [weak self] place in
            self?.locationDidSelect?(place.location)
        }
    }
}

//MARK: -private methods
extension MapVM {
    private func calculateRadius(for captureView: UIView,
                                 in mapView: MKMapView) -> CLLocationDistance {
        let mapRegion = mapView.convert(captureView.bounds,
                                        toRegionFrom: captureView)
        let centerPoint = CLLocation(latitude: mapRegion.center.latitude,
                                     longitude: mapRegion.center.longitude)
        let topPoint = CLLocation(
            latitude: mapRegion.center.latitude - mapRegion.span.latitudeDelta/2,
            longitude: mapRegion.center.longitude)
        let radius = centerPoint.distance(from: topPoint)
        return radius
    }
}
