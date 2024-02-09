//
//  LocationNotificationVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

protocol LocationNotificationViewModelProtocol {}

final class LocationNotificationVC: UIViewController {
    private var viewModel: LocationNotificationViewModelProtocol
    
    init(viewModel: LocationNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    
}
