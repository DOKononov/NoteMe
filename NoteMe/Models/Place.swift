//
//  Place.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 23.03.24.
//

import Foundation
import CoreLocation

struct Place {
    
    let location: CLLocationCoordinate2D
    let distance: Int
    let name: String
    let address: String?
    
    init(result: NearByResponseModel.Result) {
        self.name = result.name
        self.distance = result.distance
        self.location = .init(
            latitude: result.geocodes.main.latitude,
            longitude: result.geocodes.main.longitude
        )
        self.address = nil
    }
    
    init(result: SearchPlacesResponseModel.Result) {
        self.name = result.name
        self.distance = result.distance
        self.location = .init(
            latitude: result.geocodes.main.latitude,
            longitude: result.geocodes.main.longitude
        )
        self.address = result.location.address
    }
}
