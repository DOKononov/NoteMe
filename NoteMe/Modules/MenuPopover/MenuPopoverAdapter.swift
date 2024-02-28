//
//  MenuPopoverAdapter.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 27.02.24.
//

import UIKit



final class MenuPopoverAdapter: NSObject, MenuPopoverAdapterProtocol {
    var contentHeight: CGFloat {
        CGFloat(actions.count) * Const.rowHeight
    }
    
    private enum Const {
        static let rowHeight: CGFloat = 40
    }
    
    private var actions: [MenuPopoverVC.Action]
    var didSelectAction: ((MenuPopoverVC.Action) -> Void)?
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = Const.rowHeight
        return tableView
    }()
    
    init(actions: [MenuPopoverVC.Action]) {
        self.actions = actions
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuActionCell.self)
    }
    
}

extension MenuPopoverAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuActionCell = tableView.dequeue(at: indexPath)
        cell.setup(actions[indexPath.row])
        return cell
    }
}

extension MenuPopoverAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let action = actions[indexPath.row]
        didSelectAction?(action)
    }
}

