//
//  DateNotificationVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

protocol DateNotificationViewModelProtocol {}

final class DateNotificationVC: UIViewController {
    private var viewModel: DateNotificationViewModelProtocol
    
    init(viewModel: DateNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
    
    
    
}
