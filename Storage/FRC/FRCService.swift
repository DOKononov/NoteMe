//
//  FRCService.swift
//  Storage
//
//  Created by Dmitry Kononov on 7.02.24.
//

import Foundation
import CoreData

public final class FRCService<DTO: DTODescription>: NSObject, NSFetchedResultsControllerDelegate {
    
    public var didChangeContent: (([DTO]) -> Void)?
    
    private let request: NSFetchRequest<DTO.MO> = {
        return NSFetchRequest<DTO.MO>(entityName: "\(DTO.MO.self)")
    }()
    
    private lazy var frc: NSFetchedResultsController<DTO.MO> = {
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: CoreDataService.shared.mainContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }()
    
    public func config(predicate: NSPredicate? = nil,
                       sortDescriptors: [NSSortDescriptor]) {
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        frc.delegate = self
        try? frc.performFetch()
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        try? controller.performFetch()
        let dtos =  frc.fetchedObjects?.compactMap { DTO(mo: $0) }
        didChangeContent?(dtos ?? [] )
    }
}
