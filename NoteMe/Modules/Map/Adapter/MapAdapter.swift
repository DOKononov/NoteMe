//
//  Adapter.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 23.03.24.
//

import UIKit

final class MapAdapter: NSObject {
    
    var rows: [Place] = [] { didSet {tableView.reloadData()}}
    var didSelectRow: ((Place) -> Void)?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(MapPlaceCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}


extension MapAdapter: MapAdapterProtocol {
    func reloadData(with rows: [Place]) {
        self.rows = rows
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
}

extension MapAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        didSelectRow?(row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MapAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MapPlaceCell = tableView.dequeue(at: indexPath)
        cell.confiCell(for: rows[indexPath.row])
        return cell
    }
}

