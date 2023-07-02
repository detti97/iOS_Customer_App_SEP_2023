//
//  ModelData.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import Foundation

class DataManager: ObservableObject {
	@Published var errorLoading = false
	@Published var stores: [StoreInfo] = []

	init() {
		loadData()
	}

	func loadData() {
		do {
			stores = try load("http://131.173.65.77:3000/store-details")
			errorLoading = false
		} catch {
			print("Fehler beim Laden der Daten: \(error)")
			errorLoading = true
		}
	}

	func load<T: Decodable>(_ url: String) throws -> T {
		guard let url = URL(string: url) else {
			throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
		}

		let data: Data

		do {
			data = try Data(contentsOf: url)
		} catch {
			throw error
		}

		do {
			let decoder = JSONDecoder()
			return try decoder.decode(T.self, from: data)
		} catch {
			throw error
		}
	}
}



