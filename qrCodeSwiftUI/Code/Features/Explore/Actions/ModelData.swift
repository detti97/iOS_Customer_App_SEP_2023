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

	enum api_endpints {

		static let storeDetail = "http://131.173.65.77:8080/api/store-details"


	}



	func decodeResponse(_ data: Data?) {
		if let data = data {
			print(data)
			do {
				let decoder = JSONDecoder()
				let loadedData = try decoder.decode([StoreInfo].self, from: data)

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



