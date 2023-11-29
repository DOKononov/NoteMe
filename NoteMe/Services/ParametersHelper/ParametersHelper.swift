//
//  ParametersHelper.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import Foundation

final class ParametersHelper {
    private init() {}
    
    enum ParameterKey: String {
        case authenticated
        case unbordered
    }
    
    private static var ud: UserDefaults = .standard
    
    static func set(_ key: ParameterKey, value: Bool) {
        ud.setValue(value, forKey: key.rawValue)
    }
    
    static func get(_ key: ParameterKey) -> Bool {
        ud.bool(forKey: key.rawValue)
    }
}
