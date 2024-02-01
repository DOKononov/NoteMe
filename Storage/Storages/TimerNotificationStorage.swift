//
//  TimerNotificationStorage.swift
//  Storage
//
//  Created by Dmitry Kononov on 1.02.24.
//

import CoreData

public final class TimerNotificationStorage {
    public typealias CompletionHandler = (Bool) -> Void
    public init() {}
    
    //MARK: -fetch
    public func fetch(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [] ) -> [TimerNotificationDTO] {
            return fetchMO(predicate: predicate,
                           sortDescriptors: sortDescriptors)
            .compactMap {TimerNotificationDTO(mo: $0) }
        }
    
    private func fetchMO(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [] ) -> [TimerNotificationMO] {
            let request: NSFetchRequest<TimerNotificationMO> = TimerNotificationMO.fetchRequest()
            let context = CoreDataService.shared.context
            
            let results = try? context.fetch(request)
            return results ?? []
        }
    
    //MARK: -create
    public func create(
        dto: TimerNotificationDTO,
        completion: CompletionHandler? = nil) {
            let context = CoreDataService.shared.context
            context.perform {
                let mo = TimerNotificationMO(context: context)
                mo.apply(dto: dto)
                CoreDataService.shared.saveContext(completion: completion)
            }
        }
    
    //MARK: -update
    public func update(dto: TimerNotificationDTO,
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
    
    func updateOrCreate(dto: TimerNotificationDTO,
                        completion: CompletionHandler? = nil) {
        if fetchMO(predicate: .Notification.notification(by: dto.id)).isEmpty {
            create(dto: dto, completion: completion)
        } else {
            update(dto: dto, completion: completion)
        }
    }
}
