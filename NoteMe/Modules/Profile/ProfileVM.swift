//
//  ProfileVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func finish()
}

protocol ProfileAdapterProtocol {
    var didSelectRow: ((ProfileSettingsRows) -> Void)? { get set }
    func reloadData(with sections: [ProfileSections])
    func makeTableView() -> UITableView
}

protocol ProfileAlertServiceUseCase {
    func showAlert(title: String, message: String, okTitile: String)
    func showAlert(title: String?,
                   message: String?,
                   cancelTitile: String?,
                   cancelStyle: UIAlertAction.Style?,
                   okTitile: String?,
                   okHandler: (()-> Void)?,
                   okStyle: UIAlertAction.Style?)
}

protocol ProfileAuthServiceUseCase {
    func getCurrentUserEmail() -> String?
    func logout(completion: @escaping  ((Result<Void, Error>) -> Void))
}

final class ProfileVM: ProfileViewModelProtocol {
    private weak var coordinator: ProfileCoordinatorProtocol?
    private let authService: ProfileAuthServiceUseCase
    private let alertService: ProfileAlertServiceUseCase
    private var adapter: ProfileAdapterProtocol
    
    private var username: String = .Profile.unregistered_user
    
    private var sections: [ProfileSections] {
        [ .account(username),
          .notifications(.map),
          .settings([.notifications, .export, .logout])]
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    init(authService: ProfileAuthServiceUseCase,
         coordinator: ProfileCoordinatorProtocol,
         alertService: ProfileAlertServiceUseCase,
         adapter: ProfileAdapterProtocol) {
        self.authService = authService
        self.coordinator = coordinator
        self.alertService = alertService
        self.adapter = adapter
        commonInit()
        bind()
    }
}

//MARK: -private methods
private extension ProfileVM {
    private func commonInit() {
        setUserName()
        adapter.reloadData(with: sections)
    }
    
    private func bind() {
        adapter.didSelectRow = { [weak self] row in
            switch row {
            case .notifications: print("Notifications did tapped")
            case .export: print("Export did tapped")
            case .logout: self?.logout()
            case .map: print("map did tap")
            }
        }
    }
    
    private func setUserName() {
        username = authService.getCurrentUserEmail() ?? .Profile.unregistered_user
    }
    func logout() {
        alertService.showAlert(title: .AlertBuilder.logout,
                               message: .AlertBuilder.are_you_want_to_logout + "\n\(username)",
                               cancelTitile: .AlertBuilder.cancel,
                               cancelStyle: .default,
                               okTitile: .AlertBuilder.logout,
                               okHandler: { [weak self] in
            self?.didSelectLogout()
        }, okStyle: .destructive)
    }
    
    private func didSelectLogout() {
        authService.logout { [weak self] result in
            switch result {
            case .success(_):
                ParametersHelper.set(.authenticated, value: false)
                self?.coordinator?.finish()
            case .failure(let error):
                self?.alertService.showAlert(title: .AlertBuilder.error,
                                             message: error.localizedDescription,
                                             okTitile: .AlertBuilder.ok)
            }
        }
    }
}
