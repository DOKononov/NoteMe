//
//  NearByRequest.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 19.03.24.
//

import Foundation
import CoreLocation

/*
 
 {
     "results": [{
         "distance": 22,
             "geocodes": {
                 "main": {
                     "latitude": 53.926066,
                     "longitude": 27.592507
                 }
             },
         "name": "Молодёжный центр \"Айсберг\""
     }, ....
    ]
 }
 */

struct NearByResponseModel: Decodable {
    struct Result: Decodable {
        struct Geocodes: Decodable {
            struct Main: Decodable {
                let latitude: Double
                let longitude: Double
            }
            let main: Main
        }
        let distance: Int
        let geocodes: Geocodes
        let name: String
    }
    let results: [Result]
}

struct NearByrequestModel {
    let coordinates: CLLocationCoordinate2D
    let radius: Int32 = 500
}

struct NearByRequest: NetworkRequest {
    typealias ResponseModel = NearByResponseModel
    
    var url: URL {
        let baseUrl = ApiPaths.placesNearBy
        let ll = "\(model.coordinates.latitude),\(model.coordinates.longitude)"
        let radius = "\(model.radius)"
        let parameters = "ll=\(ll)&radius=\(radius)"
        return URL(string: baseUrl+"?"+parameters)!
    }
    var method: NetworkHTTPMethod { .get }
    var headers: [String : String] {
        ["Authorization": ApiToken.foursquareToken]
    }
    let model: NearByrequestModel
    
    var body: Data? { nil }
    
}
