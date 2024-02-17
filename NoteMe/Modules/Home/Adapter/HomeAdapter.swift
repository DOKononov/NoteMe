//
//  HomeAdapter.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 14.02.24.
//

import UIKit
import Storage

final class HomeAdapter: NSObject, HomeAdapterProtocol {

    private var dtoList: [any DTODescription] = [] { didSet {tableView.reloadData()}}
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = .zero
        tableView.allowsSelection = false
        tableView.addShadow()
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

//extension HomeAdapter: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int) -> Int {
//        dtoList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        let dto = dtoList[indexPath.row]
//        switch dto {
//        case is DateNotificationDTO:
//            let cell: DateCell = collectionView.dequeue(at: indexPath)
//            cell.config(for: dtoList[indexPath.row] as! DateNotificationDTO)
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//    }
//

//
//    func makeCollectionView() -> UICollectionView {
//        return collectionView
//    }
//}

//MARK: -UICollectionViewDelegateFlowLayout
//extension HomeAdapter: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: collectionView.frame.width, height: 82)
//    }
//}

extension HomeAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension HomeAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dtoList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let dto = dtoList[indexPath.section]
        switch dto {
        case is DateNotificationDTO:
            let cell: DateCell = tableView.dequeue(at: indexPath)
            cell.config(for: dto as! DateNotificationDTO)

            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
}
