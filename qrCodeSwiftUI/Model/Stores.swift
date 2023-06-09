//
//  Stores.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import Foundation
import SwiftUI
import CoreLocation


struct StoreInfo: Identifiable, Codable, Hashable {
    
    var id: String
    var name: String
    var owner: String
    var street: String
    var houseNumber: String
    var zip: String
    var city: String
    var telephone: String
    var email: String
    var logo: String
    
    private var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude)
        }
    

        struct Coordinates: Hashable, Codable {
            var latitude: Double
            var longitude: Double
        }
    
}
