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
		guard let url = URL(string: "http://131.173.65.77:3000/store-details") else {
			print("Fehler")
			return
		}

		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				DispatchQueue.main.async {
					self.errorLoading = true
					print("Fehler beim Laden der Daten")
				}
				return
			}

			if let data = data {
				do {
					let decoder = JSONDecoder()
					let loadedData = try decoder.decode([StoreInfo].self, from: data)

					DispatchQueue.main.async {
						self.stores = loadedData
						self.errorLoading = false
					}
				} catch {
					DispatchQueue.main.async {
						self.errorLoading = true
						print("Fehler beim Laden der Daten")
					}
				}
			}
		}.resume()
	}

}



