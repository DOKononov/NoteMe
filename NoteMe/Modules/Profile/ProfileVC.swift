//
//  ProfileVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit
import SnapKit

protocol ProfileViewModelProtocol {
    var buttons: [ProfileCellEntity] { get }
    func configCell(_ tableView: UITableView,
                    cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

final class ProfileVC: UIViewController {
    private var viewModel: ProfileViewModelProtocol
    
    private lazy var contentView: UIView = .contentView()
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(ProfileSettingsCell.self,
                           forCellReuseIdentifier: "\(ProfileSettingsCell.self)")
        tableView.register(ProfileAccountCell.self,
                           forCellReuseIdentifier: "\(ProfileAccountCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.addShadow()
        return tableView
    }()
        
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
        bind()
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
        contentView.addSubview(tableView)
    }
    
    func setupLayouts() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: .Profile.profile,
                                       image: .Profile.profile,
                                       tag: .zero)
    }
}

//MARK: -private methods
private extension ProfileVC {
    func bind() {}
    
}

//MARK: -tableView
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configCell(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : viewModel.buttons.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileTableViewHeader()
        switch section {
        case 0: header.text = .Profile.account
        case 1: header.text = .Profile.settings
        default: break
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, 
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.buttons[indexPath.row].action()
    }
}
