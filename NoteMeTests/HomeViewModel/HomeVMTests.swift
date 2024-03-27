//
//  HomeVMTests.swift
//  NoteMeTests
//
//  Created by Dmitry Kononov on 26.03.24.
//

import XCTest
@testable import NoteMe

final class HomeVMTests: XCTestCase {
    
    private let adapterSpy = HomeAdapterSpy()
    private let storageStub = HomeStorageStub()
    private let frcSpy = HomeFRCServiceSpy()
    private let coordinatorSpy = HomeCoordinatorSpy()
    
    private func makeSut() -> HomeVM {
        return HomeVM(adapter: adapterSpy,
                      storage: storageStub,
                      coordinator: coordinatorSpy,
                      frcService: frcSpy)
    }
    
    private func clearData() {
        frcSpy.startHandleCalled = false
        adapterSpy.reloadDataCalled = false
        adapterSpy.reloadDataDTOList = []
    }
    
    func test_viewDidLoad() {
        clearData()
        let sut = makeSut()
        frcSpy.fetchedDTOs = [HomeDTOMock(), HomeDTOMock()]
        
        sut.viewDidLoad()
        
        XCTAssert(frcSpy.startHandleCalled)
        XCTAssert(adapterSpy.reloadDataCalled)
        XCTAssertEqual(frcSpy.fetchedDTOs.count, adapterSpy.reloadDataDTOList.count)
    }
    
}
