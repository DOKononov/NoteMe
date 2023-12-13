//
//  ProfileVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit
import SnapKit

protocol ProfileViewModelProtocol {}

final class ProfileVC: UIViewController {
    private var viewModel: ProfileViewModelProtocol
    
    private lazy var contentView: UIView = .contentView()
        
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayouts()
    }
}


//MARK: -UI
private extension ProfileVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
    }
    
    func setupLayouts() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: .Profile.profile,
                                       image: .Profile.profile,
                                       tag: .zero)
    }
}
