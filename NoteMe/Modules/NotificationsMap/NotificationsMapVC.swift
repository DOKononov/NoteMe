//
//  NotificationsMapVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 18.03.24.
//

import UIKit
import SnapKit
import MapKit

protocol NotificationsMapViewModelProtocol {
    func dismissDidTap()
    func viewDidLoad()
    var updateAnatations: (([LocationAnnotation]) -> Void)? { get set }
    func didSelectLocation(id: String)
    var defaultRegion: ((MKCoordinateRegion) -> Void)? { get set }
}

final class NotificationsMapVC: UIViewController {
    
    private var viewmodel: NotificationsMapViewModelProtocol
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.shouldGroupAccessibilityChildren = true
        return mapView
    }()
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(self,
                    #selector(dismissDidTap))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewmodel.viewDidLoad()
    }
    
    
    init(viewmodel: NotificationsMapViewModelProtocol) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        view.backgroundColor = .appBlack
        cancelButton.backgroundColor = .appBlack
        view.addSubview(mapView)
        view.addSubview(cancelButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeArea)
            make.top.equalTo(safeArea)
            make.bottom.equalTo(cancelButton.snp.centerY)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.bottom.equalTo(safeArea.snp.bottom)
        }
    }
    
    private func bind() {
        viewmodel.updateAnatations = { [weak self] pins in
            if let oldAnnotations = self?.mapView.annotations {
                self?.mapView.removeAnnotations(oldAnnotations)
            }
            
            self?.mapView.addAnnotations(pins)
        }
        
        viewmodel.defaultRegion = { [weak self] region in
            self?.mapView.setRegion(region, animated: true)
        }
    }
    
    @objc private func dismissDidTap() {
        viewmodel.dismissDidTap()
    }
}


extension NotificationsMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: "\(LocationPinView.self)"
        )
        
        if annotationView == nil {
            annotationView = LocationPinView(
                annotation: annotation,
                reuseIdentifier: "\(LocationPinView.self)")
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, 
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let location = view.annotation as? LocationAnnotation else { return }
        let id = location.id
        viewmodel.didSelectLocation(id: id)
    }
}
