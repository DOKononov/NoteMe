//
//  HomeAdapterSpy.swift
//  NoteMeTests
//
//  Created by Dmitry Kononov on 26.03.24.
//

import UIKit
@testable import NoteMe
import Storage

final class HomeAdapterSpy: HomeAdapterProtocol {
    
    var reloadDataCalled: Bool = false
    var reloadDataDTOList: [any DTODescription] = []
    
    func relodeData(_ dtoList: [any DTODescription]) {
        reloadDataCalled = true
        reloadDataDTOList = dtoList
    }
    func makeTableView() -> UITableView { return .init() }
    var tapButtonOnDTO: ((UIButton, any DTODescription) -> Void)?
    var filterDidSelect: ((NoteMe.NotificationFilterType) -> Void)?
}
