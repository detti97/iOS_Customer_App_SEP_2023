//
//  AddressManager.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 13.08.23.
//

import Foundation


struct recipient: Identifiable, Codable {
	var id = UUID()
	var lastName: String
	var firstName: String
	var street: String
	var streetNr: String
	var plz: String
	var label: String?

	func toString() -> String {
			var result = "\n\(firstName) \(lastName) \n"
			result += "\(street) \(streetNr)\n"

			if let label = label {
				result += "\(label)"
			}
			return result
		}
	func toStringQrString() -> String {
		let result = "\(firstName)&\(lastName)&\(street)&\(streetNr)&\(plz)"
			return result
		}
}

class AddressBook: ObservableObject {
	@Published var addresses: [recipient] = []

	init() {
		loadData()
	}

	func addAddress(_ address: recipient) {
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
				addresses = try decoder.decode([recipient].self, from: data)
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
