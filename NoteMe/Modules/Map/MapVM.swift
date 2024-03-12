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

final class MapVM: MapViewModelProtocol {
    var snapshotDidChanged: ((UIImage?) -> Void)?
    
    private let coordinator: MapCoordinatorProtocol
    private lazy var locationManager: CLLocationManager = .init()
    weak var delegate: MapModuleDelegate?
    var isSelected: Bool { (snapshot != nil) }
    private var snapshot: UIImage? { didSet { snapshotDidChanged?(snapshot) } }
    private let region: MKCoordinateRegion?
    
    
    init(coordinator: MapCoordinatorProtocol,
         delegate: MapModuleDelegate?,
         region: MKCoordinateRegion?
    ) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.region = region
        locationManager.requestWhenInUseAuthorization()
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
        let center = calculateCenter(for: captureView, in: mapView)
        let radius = calculateRadius(for: captureView, in: mapView)
        let region = mapView.region
        
        let locationData = LocationData(image: snapshot,
                                        captureCenter: center,
                                        captureRadius: radius,
                                        mapRegion: region)
        delegate?.locationDidSet?(locationData)
        
        coordinator.finish()
    }
}

//MARK: -private methods
extension MapVM {
    private func makeCircularRegion(for captureView: UIView,
                                    in mapView: MKMapView,
                                    with id: String) -> CLCircularRegion {
        let center = calculateCenter(for: captureView, in: mapView)
        let radius = calculateRadius(for: captureView, in: mapView)
        let circularRegion = CLCircularRegion(center: center,
                                              radius: radius,
                                              identifier: id)
        return circularRegion
    }
    
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
    
    private func calculateCenter(for captureView: UIView,
                                 in mapView: MKMapView) ->  CLLocationCoordinate2D {
        let mapRegion = mapView.convert(captureView.bounds,
                                        toRegionFrom: captureView)
        return mapRegion.center
    }
}
