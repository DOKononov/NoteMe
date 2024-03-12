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
    let captureCenter: CLLocationCoordinate2D
    let captureRadius: CLLocationDistance //Double
    let mapRegion: MKCoordinateRegion
    
    private var mapCenterLatitude: Double { mapRegion.center.latitude }
    private var mapCenterLongitude: Double { mapRegion.center.longitude }
    private var mapSpanLatitude: Double { mapRegion.span.latitudeDelta }
    private var mapSpanLongitude: Double { mapRegion.span.longitudeDelta }
}
