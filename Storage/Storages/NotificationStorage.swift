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
        sortDescriptors: [NSSortDescriptor] = [] ) -> [any DTODescription] {
            let context = CoreDataService.shared.mainContext
            return fetchMO(predicate: predicate,
                           sortDescriptors: sortDescriptors, context: context)
            .compactMap { $0.toDTO() }
        }
    
    private func fetchMO(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [],
        context: NSManagedObjectContext) -> [DTO.MO] {
            let request = NSFetchRequest<DTO.MO>(entityName: "\(DTO.MO.self)")
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            let results = try? context.fetch(request)
            return results ?? []
        }
    
    //MARK: -create
    public func create(
        dto: any DTODescription,
        completion: CompletionHandler? = nil,
        context: NSManagedObjectContext) {
            context.perform {
                let _ = dto.createMO(context: context)
                CoreDataService.shared.saveContext(context: context,
                                                   completion: completion)
            }
        }
    
    public func createDTOs(dtos:[any DTODescription], completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        context.perform {
            let _ = dtos.map { $0.createMO(context: context) }
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    
    
    //MARK: -update
    public func update(dto: any DTODescription,
                       completion: CompletionHandler? = nil,
                       context: NSManagedObjectContext) {
        context.perform { [weak self] in
            guard let mo = self?.fetchMO(
                predicate: .Notification.notification(by: dto.id),
                context: context).first
            else { return }
            mo.apply(dto: dto)
            
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    
    public func updateOrCreate(dto: any DTODescription,
                               completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        
        if fetchMO(predicate: .Notification.notification(by: dto.id), context: context).isEmpty {
            create(dto: dto, completion: completion, context: context)
        } else {
            update(dto: dto, completion: completion, context: context)
        }
    }
    
    public func updateDTOs(dtos: [any DTODescription],
                           completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        let ids = dtos.map { $0.id }
        context.perform { [weak self] in
            guard
                let mos = self?.fetchMO(predicate: .Notification.notifications(in: ids),
                                        context: context)
            else { return }
            
            mos.forEach { model in
                guard
                    let dto = dtos.first(where: { $0.id == model.identifier })
                else { return }
                model.apply(dto: dto)
            }
            CoreDataService.shared.saveContext(context: context, completion: completion)
        }
    }
    
    //MARK: -delete
    public func delete(dto: any DTODescription,
                       completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.mainContext
        context.perform { [weak self] in
            guard let mo = self?.fetchMO(
                predicate: .Notification.notification(by: dto.id),
                context: context).first
            else { return }
            context.delete(mo)
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    
    public func deleteAll(dtos: [any DTODescription],
                          completion: CompletionHandler? = nil) {
         let context = CoreDataService.shared.backgroundContext
        context.perform { [weak self] in
            let ids = dtos.map{ $0.id }
            let mos = self?.fetchMO(
                predicate: .Notification.notifications(in: ids),
                context: context)
            mos?.forEach { context.delete($0) }
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
}
