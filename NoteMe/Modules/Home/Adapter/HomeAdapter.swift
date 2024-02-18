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
    
    private var dtoList: [any DTODescription] = [] { didSet {collectionView.reloadData()} }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCell.self)
    }
    
    func relodeData(_ dtoList: [any DTODescription]) {
        self.dtoList = dtoList
    }
    
    func makeCollectionView() -> UICollectionView {
        collectionView
    }
}

extension HomeAdapter: UICollectionViewDelegate {
    
}

extension HomeAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        dtoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dto = dtoList[indexPath.row]
        switch dto {
        case is DateNotificationDTO:
            let cell: DateCell = collectionView.dequeue(at: indexPath)
            cell.buttonDidTapped = { [weak self] sender in
                self?.tapButtonOnDTO?(sender, dto)
            }
            cell.config(for: dto as! DateNotificationDTO)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

extension HomeAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dto = dtoList[indexPath.row]
        switch dto {
        case is DateNotificationDTO:
            return CGSize(width: collectionView.frame.width, height: 82)
        case is LocationNotificationDTO:
            return CGSize(width: collectionView.frame.width, height: 237)
        case is TimerNotificationDTO:
            return CGSize(width: collectionView.frame.width, height: 120)
        default:
            return .zero
        }
    }
}
