//
//  LocationPin.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 8.04.24.
//

import Foundation
import MapKit

final class LocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var id: String
    
    init(coordinate: CLLocationCoordinate2D,
         id: String,
         title: String? = nil,
         subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.id = id
    }
}
