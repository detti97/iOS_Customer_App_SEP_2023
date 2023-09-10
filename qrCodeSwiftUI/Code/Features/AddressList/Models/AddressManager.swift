//
//  AddressManager.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 13.08.23.
//

import Foundation

/// A structure representing an address with street, house number, zip code, and city.
struct Address: Codable {

	/// The street name.
	var street: String

	/// The house number.
	var houseNumber: String

	/// The zip code.
	var zip: String

	/// The city.
	var city: String

}

/// A structure representing a recipient with a unique identifier, first name, last name, address, and an optional label.
struct Recipient: Identifiable, Codable {

	/// The unique identifier for the recipient.
	var id = UUID()

	/// The first name of the recipient.
	var firstName: String

	/// The last name of the recipient.
	var lastName: String

	/// The recipient's ``Address``.
	var address: Address

	/// An optional label for the recipient.
	var label: String?

	/// Converts the recipient's name to a formatted string.
	func toString() -> String {
		return "\(lastName) \(firstName)"
	}

	/// Converts the recipient's information to a string for generating a QR code.
	func toStringQrString() -> String {
		return "\(lastName)&\(firstName)&\(address.street)&\(address.houseNumber)&\(address.zip)&\(address.city)"
	}
}

/// A class representing an address book that manages a collection of ``Recipient``.
class AddressBook: ObservableObject {

	/// An array of ``Recipient`` in the address book.
	@Published var addressBook: [Recipient] = []

	/// Initializes an empty address book and loads saved data if available.
	init() {
		loadData()
	}

	/// Adds a new recipient to the address book and saves the data.
	/// - Parameter address: The recipient to add.
	func addAddress(_ address: Recipient) {
		addressBook.append(address)
		saveData()
	}

	/// Deletes recipients at specified indexes from the address book and saves the data.
	/// - Parameter indexSet: The indexes of recipients to delete.
	func deleteAddress(at indexSet: IndexSet) {
		addressBook.remove(atOffsets: indexSet)
		saveData()
	}

	/// Loads saved recipient data from UserDefaults.
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

	/// Saves the recipient data to UserDefaults.
	func saveData() {
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(addressBook)
			UserDefaults.standard.set(data, forKey: "addressBook")
		} catch {
			print("Error saving data: \(error)")
		}
	}

	/// Deletes all recipients from the address book and saves the data.
	func deleteAllAddresses() {
		addressBook.removeAll()
		saveData()
	}
}
