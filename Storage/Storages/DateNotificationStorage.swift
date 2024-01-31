//
//  DateNotificationStorage.swift
//  Storage
//
//  Created by Dmitry Kononov on 30.01.24.
//

import CoreData

public final class DateNotificationStorage {
    public typealias CompletionHandler = (Bool) -> Void
    public init() {}
    
    //MARK: -fetch
    public func fetch(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [] ) -> [DateNotificationDTO] {
            return fetchMO(predicate: predicate,
                           sortDescriptors: sortDescriptors)
            .compactMap {DateNotificationDTO(mo: $0) }
        }
    
    private func fetchMO(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [] ) -> [DateNotificationMO] {
            let request: NSFetchRequest<DateNotificationMO> = DateNotificationMO.fetchRequest()
            let context = CoreDataService.shared.context
            
            let results = try? context.fetch(request)
            return results ?? []
        }
    
    //MARK: -create
    public func create(
        dto: DateNotificationDTO,
        completion: CompletionHandler? = nil) {
            let context = CoreDataService.shared.context
            context.perform {
                let mo = DateNotificationMO(context: context)
                mo.apply(dto: dto)
                CoreDataService.shared.saveContext(completion: completion)
            }
        }
    
    //MARK: -update
    public func update(   dto: DateNotificationDTO,
                          completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.context
        context.perform { [weak self] in
            guard let mo = self?.fetchMO(
                predicate: .Notification.notification(by: dto.id)).first
            else { return }
            mo.apply(dto: dto)
            CoreDataService.shared.saveContext(completion: completion)
        }
    }
    
    func updateOrCreate(dto: DateNotificationDTO,
                        completion: CompletionHandler? = nil) {
        if fetchMO(predicate: .Notification.notification(by: dto.id)).isEmpty {
            create(dto: dto, completion: completion)
        } else {
            update(dto: dto, completion: completion)
        }
    }
    
    
}
