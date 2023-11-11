//
//  InputValidator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit

final class InputValidator: NSObject {
    
    func validate(email: String?) -> Bool {
        return validate(string: email,
                        pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
    
    func validate(password: String?) -> Bool {
        return validate(string: password,
                        pattern: "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$")
    }
    
    
    private func validate(string: String?, pattern: String) -> Bool {
        guard
            let string,
            let regex = try? NSRegularExpression(pattern: pattern,
                                                 options: .caseInsensitive)
        else { return false }
        
        let match = regex.firstMatch(in: string,
                                     options: [],
                                     range: NSRange(location: 0, length: string.count))
        return match != nil
    }
}
