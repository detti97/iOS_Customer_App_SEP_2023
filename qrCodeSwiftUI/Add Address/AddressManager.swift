//
//  AddressManager.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 13.08.23.
//

import Foundation


struct Address: Identifiable, Codable {
	var id = UUID()
	var firstName: String
	var lastName: String
	var street: String
	var houseNumber: String
	var zip: String
	var label: String?

	func toString() -> String {
			var result = "\n\(lastName) \(firstName) \n"
			result += "\(street) \(houseNumber)\n"

			if let label = label {
				result += "\(label)"
			}
			return result
		}
	func toStringQrString() -> String {
		let result = "\(lastName)&\(firstName)&\(street)&\(houseNumber)&\(zip)"
			return result
		}
}

class AddressBook: ObservableObject {
	@Published var addresses: [Address] = []

	init() {
		loadData()
	}

	func addAddress(_ address: Address) {
		addresses.append(address)
		saveData()
	}

	func deleteAddress(at indexSet: IndexSet) {
		addresses.remove(atOffsets: indexSet)
		saveData()
	}

	func loadData() {
		if let data = UserDefaults.standard.data(forKey: "addressBook") {
			do {
				let decoder = JSONDecoder()
				addresses = try decoder.decode([Address].self, from: data)
			} catch {
				print("Error loading data: \(error)")
			}
		}
	}

	func saveData() {
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(addresses)
			UserDefaults.standard.set(data, forKey: "addressBook")
		} catch {
			print("Error saving data: \(error)")
		}
	}
}
