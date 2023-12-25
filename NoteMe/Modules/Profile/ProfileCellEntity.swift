//
//  ProfileCellEntity.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 22.12.23.
//

import UIKit

struct ProfileCellEntity {
    let title: String
    let image: UIImage
    let status: String?
    var action: () -> Void
}
