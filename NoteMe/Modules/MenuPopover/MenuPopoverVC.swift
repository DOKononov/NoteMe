//
//  MenuPopover.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 27.02.24.
//

import UIKit
import SnapKit

protocol MenuPopoverAdapterProtocol {
    var tableView: UITableView { get }
    var didSelectAction: ((MenuPopoverVC.Action) -> Void)? { get set }
    var contentHeight: CGFloat { get }
}

protocol MenuPopoverDelegate: AnyObject {
    func didSelect(action: MenuPopoverVC.Action)
}

final class MenuPopoverVC: UIViewController {
    
    private enum Const {
        static let contentWidth: CGFloat = 180
    }
    
    enum Action: MenuActionItem {
        case edite
        case delete
        case calendar
        case timer
        case location
        
        var title: String {
            switch self {
            case .edite: return .MainTabBar.edit
            case .delete: return .MainTabBar.delete
            case .calendar: return .MainTabBar.calendar
            case .timer: return .MainTabBar.timer
            case .location: return .MainTabBar.location
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .edite: return .MainTabBar.edit
            case .delete: return .MainTabBar.delete
            case .calendar: return .MainTabBar.calendar
            case .timer: return .MainTabBar.timer
            case .location: return .MainTabBar.location
            }
        }
    }
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .popover }
        set {}
    }
    
    private var adapter: MenuPopoverAdapterProtocol
    private lazy var tableView: UITableView = adapter.tableView
    private weak var delegate: MenuPopoverDelegate?
    
    init(delegate: MenuPopoverDelegate?,
         adapter: MenuPopoverAdapterProtocol,
         sourceView: UIView) {
        self.delegate = delegate
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)
        setupPopover(sourceView: sourceView)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }
    
    private func bind() {
        adapter.didSelectAction = { [weak self] action in
            self?.dismiss(animated: true) {
                self?.delegate?.didSelect(action: action)
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide.snp.verticalEdges)
            make.horizontalEdges.equalToSuperview()
        }
        
    }
    
    private func setupPopover(sourceView: UIView) {
        preferredContentSize = CGSize(width: Const.contentWidth,
                                      height: adapter.contentHeight)
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.delegate = self
        popoverPresentationController?.sourceRect = CGRect(x: sourceView.bounds.midX,
                                                           y: sourceView.bounds.midY,
                                                           width: .zero, height: .zero)
    }
}

extension MenuPopoverVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) 
    -> UIModalPresentationStyle {
        .none
    }
}
