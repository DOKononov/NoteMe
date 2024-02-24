//
//  HomeAdapter.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 14.02.24.
//

import UIKit
import Storage


final class HomeAdapter: NSObject, HomeAdapterProtocol {
    var tapButtonOnDTO: ((_ sender: UIButton, _ dto: any DTODescription) -> Void)?
    
    private var dtoList: [any DTODescription] = [] { didSet {tableView.reloadData()} }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.addShadow()
        tableView.sectionFooterHeight = 10
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init() {
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DateCell.self)
    }
    
    func relodeData(_ dtoList: [any DTODescription]) {
        self.dtoList = dtoList
    }
    
    func makeTableView() -> UITableView {
        tableView
    }
}

extension HomeAdapter: UITableViewDelegate {
    
}

extension HomeAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dtoList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dto = dtoList[indexPath.section]
        switch dto {
        case is DateNotificationDTO:
            let cell: DateCell =  tableView.dequeue(at: indexPath)
            cell.config(for: dto as! DateNotificationDTO)
            cell.buttonDidTapped = { [weak self] sender in
                self?.tapButtonOnDTO?(sender, dto)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
}
