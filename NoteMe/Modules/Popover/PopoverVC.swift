//
//  PopoverVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 11.02.24.
//

import UIKit

protocol PopoverVCDelegate: AnyObject {
    func didSelectCalendar()
    func didSelectDelete()
    func didSelectEdit()
    func didSelectLocation()
    func didSelectTimer()
}

final class PopoverVC: UIViewController {
    
    enum MenuType {
        case create, edit
    }
    
    private var rows: [PopoverRow] = []
    weak var delegate: PopoverVCDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    private init(sourceView: UIView) {
        super.init(nibName: nil, bundle: nil)
        configPopoverController(for: sourceView)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PopoverCell.self)
    }
    
    private func configPopoverController(for sourceView: UIView) {
        modalPresentationStyle = .popover
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.delegate = self
        popoverPresentationController?.permittedArrowDirections = .down
        popoverPresentationController?.sourceRect = CGRect(x: sourceView.bounds.midX,
                                                           y: sourceView.bounds.midY,
                                                           width: .zero, height: .zero)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        preferredContentSize = CGSize(width: 180, height: rows.count * 40)
        tableView.snp.makeConstraints {$0.edges.equalToSuperview()}
    }
    
}

//MARK: -UIPopoverPresentationControllerDelegate
extension PopoverVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

//MARK: -UITableViewDataSource
extension PopoverVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PopoverCell = tableView.dequeue(at: indexPath)
        cell.configCell(for: rows[indexPath.row])
        return cell
    }
    
    
}

//MARK: -UITableViewDelegate
extension PopoverVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true)
        switch rows[indexPath.row] {
        case .calendar: delegate?.didSelectCalendar()
        case .delete: delegate?.didSelectDelete()
        case .edit: delegate?.didSelectEdit()
        case .location: delegate?.didSelectLocation()
        case .timer: delegate?.didSelectTimer()
        }
    }
}

//MARK: -init
extension PopoverVC {
    
    static func make(type: MenuType, for sorceView: UIView) -> PopoverVC {
        let vc = PopoverVC(sourceView: sorceView)
        switch type {
        case .create: vc.rows = [.calendar, .location, .timer]
        case .edit: vc.rows = [.edit, .delete]
        }
        return vc
    }
}

