//
//  NotificationStorage.swift
//  Storage
//
//  Created by Dmitry Kononov on 7.02.24.
//

import Foundation
import CoreData


public class NotificationStorage<DTO: DTODescription> {
    public typealias CompletionHandler = (Bool) -> Void
    public init() {}
    
    //MARK: -fetch
    public func fetch(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [] ) -> [DTO] {
            return fetchMO(predicate: predicate,
                           sortDescriptors: sortDescriptors)
            .compactMap {DTO(mo: $0) }
        }
    
    private func fetchMO(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [] ) -> [DTO.MO] {
            let request = NSFetchRequest<DTO.MO>(entityName: "\(DTO.MO.self)")
            let context = CoreDataService.shared.mainContext
            let results = try? context.fetch(request)
            return results ?? []
        }
    
    //MARK: -create
    public func create(
        dto: DTO.MO.DTO,
        completion: CompletionHandler? = nil) {
            let context = CoreDataService.shared.backgroundContext
            context.perform {
                let mo = DTO.MO(context: context)
                mo.apply(dto: dto)
                CoreDataService.shared.saveContext(context: context,
                                                   completion: completion)
            }
        }
    
    //MARK: -update
    public func update(dto: DTO.MO.DTO,
                       completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        context.perform { [weak self] in
            guard let mo = self?.fetchMO(
                predicate: .Notification.notification(by: dto.id)).first
            else { return }
            mo.apply(dto: dto)
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    
    func updateOrCreate(dto: DTO.MO.DTO,
                        completion: CompletionHandler? = nil) {
        if fetchMO(predicate: .Notification.notification(by: dto.id)).isEmpty {
            create(dto: dto, completion: completion)
        } else {
            update(dto: dto, completion: completion)
        }
    }
}
