//
//  Container.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 16.01.24.
//

import Foundation

final class Container {
    
    private var container: [String: Any] = [:]
    private var lazyContainer: [String: () -> Any] = [:]
    

    func register<Type: Any>(_ initialazer: @escaping () -> Type) {
        lazyContainer["\(Type.self)"] = initialazer
    }
    
    func resolve<Type: Any>() -> Type {
        if let cache = container["\(Type.self)"] as? Type {
            return cache
        }
        let new = lazyContainer["\(Type.self)"]?() as! Type
        container["\(Type.self)"] = new
        return new
    }
}
