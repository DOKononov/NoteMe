//
//  HomeVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit
import SnapKit

protocol HomeViewModelProtocol: AnyObject {
    func makeCollectionView() -> UICollectionView
}

final class HomeVC: UIViewController {
    private var viewModel: HomeViewModelProtocol
    
    private lazy var contentView: UIView = .contentView()
    private lazy var collectionView = viewModel.makeCollectionView()
        
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayouts()
    }
}

//MARK: -UI
private extension HomeVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(collectionView)
    }
    
    func setupLayouts() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: .Home.home,
                                       image: .Home.home,
                                       tag: .zero)
    }
}
