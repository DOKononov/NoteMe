//
//  HomeAdapter.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 14.02.24.
//

import UIKit
import Storage


final class HomeAdapter: NSObject, HomeAdapterProtocol {
    
    private enum Const {
        static let headerHeight: CGFloat = 32+16
    }
    var filterDidSelect: ((NotificationFilterType) -> Void)?
    
    var tapButtonOnDTO: ((_ sender: UIButton, _ dto: any DTODescription) -> Void)?
    
    private var dtoList: [[any DTODescription]] = [] { didSet {tableView.reloadData()} }
    
    private lazy var tableHeaderView: NotificationFilterView = {
        let frame = CGRect(x: .zero, y: .zero, width: .zero, height: Const.headerHeight)
        let header = NotificationFilterView(frame: frame)
        header.delegate = self
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.addShadow()
        tableView.separatorStyle = .none
        tableView.cornerRadius = 5
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = tableHeaderView
        
        return tableView
    }()
    
    override init() {
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DateCell.self)
        tableView.register(TimerCell.self)
        tableView.register(LocationCell.self)
    }
    
    func relodeData(_ dtoList: [[any DTODescription]]) {
        self.dtoList = dtoList
    }
    
    func makeTableView() -> UITableView {
        tableView
    }
}

extension HomeAdapter: UITableViewDelegate {}

extension HomeAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dtoList.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dtoList[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        (dtoList[section].count > 1 && section == 1) ? "completed" : nil //TODO: fix
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dto = dtoList[indexPath.section][indexPath.row]
        return configCell(for: dto, in: indexPath)
    }
}


extension HomeAdapter: NotificationFilterViewDelegate {
    func notificationFilterView(
        _ filterView: NotificationFilterView,
        didSelect type: NotificationFilterType
    ) {
        filterDidSelect?(type)
    }
}

//MARK: -private methods
private extension HomeAdapter {
    func configCell(for dto: any DTODescription, in indexPath: IndexPath) -> UITableViewCell {
        switch dto {
        case is DateNotificationDTO:
            let cell: DateCell =  tableView.dequeue(at: indexPath)
            cell.config(for: dto as! DateNotificationDTO)
            cell.buttonDidTapped = { [weak self] sender in
                self?.tapButtonOnDTO?(sender, dto)
            }
            return cell
            
        case is TimerNotificationDTO:
            let cell: TimerCell = tableView.dequeue(at: indexPath)
            cell.config(for: dto as! TimerNotificationDTO)
            cell.buttonDidTapped = { [weak self] sender in
                self?.tapButtonOnDTO?(sender, dto)
            }
            return cell
            
        case is LocationNotificationDTO:
            let cell: LocationCell = tableView.dequeue(at: indexPath)
            cell.config(for: dto as! LocationNotificationDTO)
            cell.buttonDidTapped = { [weak self] sender in
                self?.tapButtonOnDTO?(sender, dto)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
