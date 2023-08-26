//
//  Stores.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import Foundation
import SwiftUI
import CoreLocation


struct StoreInfo: Decodable, Identifiable {

    var id: String
    var name: String
    var owner: String
	var address: Address
    var telephone: String
    var email: String
    var logo: String
	var backgroundImage: String
    
    private var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(
				latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
    

        struct Coordinates: Hashable, Codable {

			var latitude: Double
			var longitude: Double
        }

	init(id: String, name: String, owner: String, address: Address, telephone: String, email: String, logo: String, backgroundImage: String, coordinates: Coordinates) {
			self.id = id
			self.name = name
			self.owner = owner
			self.address = address
			self.telephone = telephone
			self.email = email
			self.logo = logo
			self.backgroundImage = backgroundImage
			self.coordinates = coordinates
		}

    
}
