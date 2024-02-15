//
//  DTODescription.swift
//  Storage
//
//  Created by Dmitry Kononov on 7.02.24.
//

import Foundation
import CoreData

public protocol DTODescription {
//    associatedtype DTO //?
    associatedtype MO: MODescription //?
    
    var id: String { get set }
    var date: Date  { get set }
    var title: String  { get set }
    var subtitle: String?  { get set }
    var completedDate: Date?  { get set }
    
    init?(mo: MO) //?

}



public protocol MODescription: NSManagedObject, NSFetchRequestResult {
    associatedtype DTO: DTODescription
    
    func apply(dto: DTO)
}
