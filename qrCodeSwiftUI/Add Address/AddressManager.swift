//
//  AddressManager.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 13.08.23.
//

import Foundation

struct Address: Codable {

	var street: String
	var houseNumber: String
	var zip: String
	var city: String

}


struct Recipient: Identifiable, Codable {
	var id = UUID()
	var firstName: String
	var lastName: String
	var address: Address
	var label: String?

	func toString() -> String {
		var result = "\(lastName) \(firstName)\n\(address.street) \(address.houseNumber)\n"

			if let label = label {
				result += "\(label)"
			}
			return result
		}
	func toStringQrString() -> String {
		let result = "\(lastName)&\(firstName)&\(address.street)&\(address.houseNumber)&\(address.zip)&Lingen"
			return result
		}
}

class AddressBook: ObservableObject {
	@Published var addressBook: [Recipient] = []

	init() {
		loadData()
	}

	func addAddress(_ address: Recipient) {
		addressBook.append(address)
		saveData()
	}

	func deleteAddress(at indexSet: IndexSet) {
		addressBook.remove(atOffsets: indexSet)
		saveData()
	}

	func loadData() {
		if let data = UserDefaults.standard.data(forKey: "addressBook") {
			do {
				let decoder = JSONDecoder()
				addressBook = try decoder.decode([Recipient].self, from: data)
			} catch {
				print("Error loading data: \(error)")
			}
		}
	}

	func saveData() {
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(addressBook)
			UserDefaults.standard.set(data, forKey: "addressBook")
		} catch {
			print("Error saving data: \(error)")
		}
	}
}
