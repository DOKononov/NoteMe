//
//  LocationData.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 11.03.24.
//

import UIKit
import MapKit

struct LocationData {
    let image: UIImage?
    let center: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let region: MKCoordinateRegion
}
