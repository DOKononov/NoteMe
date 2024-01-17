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

protocol ProfileAlertServiceUseCase {
    func showAlert(title: String, message: String, okTitile: String)
}

protocol ProfileAuthServiceUseCase {
    func getCurrentUserEmail() -> String?
    func logout(completion: @escaping  ((Result<Void, Error>) -> Void))
}

final class ProfileVM: ProfileViewModelProtocol {
    var buttons: [ProfileCellEntity] = []
    
    let authService: ProfileAuthServiceUseCase
    private weak var coordinator: ProfileCoordinatorProtocol?
    private let alertService: ProfileAlertServiceUseCase
    
    init(authService: ProfileAuthServiceUseCase,
         coordinator: ProfileCoordinatorProtocol,
         alertService: ProfileAlertServiceUseCase
    ) {
        self.authService = authService
        self.coordinator = coordinator
        self.alertService = alertService
        setButtons()
    }
    
    func configCell(_ tableView: UITableView, 
                    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "\(ProfileAccountCell.self)",
                for: indexPath) as? ProfileAccountCell
            
            cell?.email = setUserName()
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "\(ProfileSettingsCell.self)",
                for: indexPath) as? ProfileSettingsCell
            
            cell?.configCell(for: buttons[indexPath.row],
                             for: indexPath,
                             in: tableView)
            return cell ?? UITableViewCell()
        }
    }
}

//MARK: -private methods
private extension ProfileVM {
    
    private func setUserName() -> String {
        let username = authService.getCurrentUserEmail()
        return username ?? .Profile.unregistered_user
    }
    func logout() {
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
    
    func setButtons() {
        buttons = [
            .init(title: .Profile.notificactions,
                              image: .Profile.notificactions,
                              status: nil, action: { print("notificactions") }),
            
            .init(title: .Profile.export,
                              image: .Profile.export,
                              status: "Last export: 20 Sep 2023",
                              action: { print("export") }),
            
            .init(title: .Profile.logout,
                              image: .Profile.logout,
                              status: nil,
                              action: { [weak self] in self?.logout() })
        ]
    }
}
