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
}

final class NotificationsMapVC: UIViewController {
    
    private var viewmodel: NotificationsMapViewModelProtocol
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(self,
                    #selector(dismissDidTap))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
   @objc private func dismissDidTap() {
        viewmodel.dismissDidTap()
    }
}
