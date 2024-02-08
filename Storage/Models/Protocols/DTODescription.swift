//
//  DTODescription.swift
//  Storage
//
//  Created by Dmitry Kononov on 7.02.24.
//

import Foundation
import CoreData

public protocol DTODescription {
    associatedtype DTO
    associatedtype MO: MOdescription
    var id: String { get set }

    init?(mo: MO)
}

public protocol MOdescription: NSManagedObject, NSFetchRequestResult {
    func apply(_ dto: any DTODescription)
}
