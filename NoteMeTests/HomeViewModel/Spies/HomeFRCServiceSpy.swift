//
//  HomeFRCServiceSpy.swift
//  NoteMeTests
//
//  Created by Dmitry Kononov on 26.03.24.
//

import Foundation
@testable import NoteMe
import Storage

final class HomeFRCServiceSpy: HomeFRCServiceUseCase {
    
    var startHandleCalled: Bool = false
    
    var didChangeContent: (([any DTODescription]) -> Void)?
    
    var fetchedDTOs: [any DTODescription] = []
    
    func startHandle() { 
        startHandleCalled = true
    }
    
}
