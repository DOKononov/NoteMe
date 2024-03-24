//
//  MapViewController.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 6.03.24.
//

import UIKit
import MapKit
import SnapKit

protocol MapViewModelProtocol {
    func dismissDidTap()
    func setDefaultMapPosition(for mapView: MKMapView)
    func makeSnapshot(_ view: UIView,
                      mapView: MKMapView,
                      captureView: UIView)
    var snapshotDidChanged: ((UIImage?) -> Void)? { get set }
    var isSelected: Bool { get }
    func confirmDidTap(mapView: MKMapView, captureView: UIView)
    func viewDidLoad()
    func makeTableView() -> UITableView
    
    func searchPlaces(for query: String)
    var locationDidSelect: ((CLLocationCoordinate2D) -> Void)? { get set }
}

final class MapVC: UIViewController {
    
    private var viewmodel: MapViewModelProtocol
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = .Map.search
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var tableView: UITableView = viewmodel.makeTableView()
    
    private lazy var captureImageView: UIImageView = {
        let imageView = UIImageView(image: .Map.capture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var snapshotView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        return imageView
    }()
    
    private lazy var flashView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    
    private lazy var selectButton: UIButton =
        .yellowRoundedButton(.Map.select)
        .withAction(self, #selector(selectDidTap))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(self,
                    #selector(dismissDidTap))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewmodel.viewDidLoad()
        viewmodel.setDefaultMapPosition(for: mapView)
    }
    
    init(viewmodel: MapViewModelProtocol) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    private func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(searchBar)
        view.addSubview(mapView)
        view.addSubview(captureImageView)
        view.addSubview(snapshotView)
        view.addSubview(flashView)
        view.addSubview(tableView)
        view.addSubview(selectButton)
        view.addSubview(cancelButton)

        
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(selectButton.snp.centerY)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(selectButton.snp.centerY)
        }
        
        snapshotView.snp.makeConstraints { make in
            make.center.equalTo(captureImageView.snp.center)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(95*2)
        }
        
        captureImageView.snp.makeConstraints { make in
            make.center.equalTo(mapView.snp.center)
            make.size.equalTo(95)
        }
        flashView.snp.makeConstraints { make in
            make.edges.equalTo(mapView)
        }
        
        selectButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.bottom.equalTo(cancelButton.snp.top).inset(-8)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
    @objc private func selectDidTap() {
        if viewmodel.isSelected  {
            viewmodel.confirmDidTap(mapView: mapView, captureView: captureImageView)
        } else {
            makeSnapshot()
        }
    }
    
    private func makeSnapshot() {
        viewmodel.makeSnapshot(view, mapView: mapView, captureView: captureImageView)
        flashView.alpha = 1
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.flashView.alpha = 0
            self?.mapView.alpha = 0
            self?.snapshotView.alpha = 1
        }
    }
    
    @objc private func dismissDidTap() {
        mapView.alpha = 1
        snapshotView.alpha = 0
        viewmodel.dismissDidTap()
    }
    
    private func bind() {
        viewmodel.snapshotDidChanged = { [weak self] image in
            self?.snapshotView.image = image
            self?.selectButton.setTitle(image == nil ? .Map.select : .Map.confirm, for: .normal)
        }
        
        viewmodel.locationDidSelect = { [weak self] location in
            self?.mapView.setRegion(
                MKCoordinateRegion(center: location,
                                   latitudinalMeters: 250,
                                   longitudinalMeters: 250),
                animated: true)
            self?.searchBar.text = nil
            self?.searchBar.resignFirstResponder()
            self?.tableView.isHidden = true
        }
    }
}


extension MapVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.isHidden = false
        viewmodel.searchPlaces(for: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
    }
}


