//
//  TimerNotificationVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

protocol TimerNotificationViewModelProtocol {}

final class TimerNotificationVC: UIViewController {
    
    private var viewModel: TimerNotificationViewModelProtocol
    
    init(viewModel: TimerNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
