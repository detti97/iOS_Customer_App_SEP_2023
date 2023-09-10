//
//  ModelData.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import Foundation

/// A class responsible for managing and loading store data.
class DataManager: ObservableObject {

	/// A flag indicating whether an error occurred while loading data.
	@Published var errorLoading = false

	/// An array of ``StoreDetails``
	@Published var stores: [StoreDetails] = []

	/// Enum defining API endpoints.
	enum api_endpoints {
		/// The endpoint for retrieving store details.
		static let storeDetail = "http://131.173.65.77:8080/api/store-details"
	}

	/// Decodes the response data and updates the `stores` array on success.
	///
	/// - Parameter data: The data received from the server that will be decoded
	func decodeResponse(_ data: Data?) {
		if let data = data {
			print(data)
			do {
				let decoder = JSONDecoder()
				let loadedData = try decoder.decode([StoreDetails].self, from: data)

				DispatchQueue.main.async {
					self.stores = loadedData
					self.errorLoading = false
					print(loadedData)
				}
			} catch {
				DispatchQueue.main.async {
					self.errorLoading = true
					print("Fehler beim Decodieren der Daten")
				}
			}
		}
	}

	/// Loads data from a specified URL and handles timeouts and errors.
	///
	/// - Parameter url: The URL to load data from.
	func loadData(url: String) {
		guard let url = URL(string: url) else {
			print("Fehler")
			return
		}

		var request = URLRequest(url: url)
		request.timeoutInterval = 2.0

		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error as NSError?, error.code == NSURLErrorTimedOut {
				DispatchQueue.main.async {
					self.errorLoading = true
					print("Zeitüberschreitung beim Laden der Daten")
				}
				return
			}

			if error != nil {
				DispatchQueue.main.async {
					self.errorLoading = true
					print("Fehler beim Laden der Daten")
				}
				return
			}
			print("Response data:", String(data: data!, encoding: .utf8) ?? "")
			self.decodeResponse(data)
		}
		task.resume()
	}
}


class AppState: ObservableObject {
	@Published var addressEntered = false
}



