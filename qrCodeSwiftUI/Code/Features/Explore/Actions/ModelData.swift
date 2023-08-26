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

	func loadData() {
		guard let url = URL(string: "http://131.173.65.77:8080/api/store-details") else {
			print("Fehler")
			return
		}

		URLSession.shared.dataTask(with: url) { data, response, error in
			if error != nil {
				DispatchQueue.main.async {
					self.errorLoading = true
					print("Fehler beim Laden der Daten")
				}
				return
			}
			print("Response data:", String(data: data!, encoding: .utf8) ?? "")
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
						print("Fehler beim decodiern der Daten")
					}
				}
			}
		}.resume()
	}

}

class AppState: ObservableObject {
	@Published var addressEntered = false
}



