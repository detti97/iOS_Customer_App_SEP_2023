//
//  StoreDetails.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import Foundation
import SwiftUI
import CoreLocation

/// Represents one store with its details
struct StoreDetails: Decodable, Identifiable {

	/// Unique identifier for the store.
	/// - Parameter id: The unique identifier for the store.
	var id: String

	/// Store's name.
	/// - Parameter name: The name of the store.
	var name: String

	/// Owner's name.
	/// - Parameter owner: The name of the owner.
	var owner: String

	/// Address of the store.
	/// - Parameter address: The address of the store.
	var address: Address

	/// Telephone number.
	/// - Parameter telephone: The telephone number of the store.
	var telephone: String

	/// e-mail.
	/// - Parameter email: The email ID of the store.
	var email: String

	/// Logo's resource URL.
	/// - Parameter logo: The URL of the store's logo resource.
	var logo: String

	/// Background image's resource ID or URI.
	/// - Parameter backgroundImage: The resource ID or URI of the store's background image.
	var backgroundImage: String

	private var coordinates: Coordinates

	/// Geographical coordinates of the store.
	var locationCoordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(
			latitude: coordinates.latitude,
			longitude: coordinates.longitude)
	}

	/// Represents the geographical coordinates of the store.
	struct Coordinates: Hashable, Codable {

		/// Latitude of the store's location.
		/// - Parameter latitude: The latitude of the store's location.
		var latitude: Double

		/// Longitude of the store's location.
		/// - Parameter longitude: The longitude of the store's location.
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
