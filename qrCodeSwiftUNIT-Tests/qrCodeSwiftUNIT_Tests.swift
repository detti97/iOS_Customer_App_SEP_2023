//
//  File.swift
//  qrCodeSwiftUNIT-Tests
//
//  Created by Amirali on 11.07.23.
//

import Foundation
import XCTest
import SwiftUI
@testable import qrCodeSwiftUI

//ContentViewTest

class ContentViewTests: XCTestCase {

	//Logik in einer separaten Funktion extrahiert, weil die showAddressAlert-Variable und die onAppear-Funktion privat sind und keinen Zugriff von außen ermöglichen!
	func shouldShowAddressAlert(addressBook: AddressBook) -> Bool {
		return addressBook.addressBook.isEmpty
	}

	//Funktion überprüfen
	func testShouldShowAddressAlertWhenAddressBookIsEmpty() {
		let addressBook = AddressBook()
		addressBook.addressBook = []

		let result = shouldShowAddressAlert(addressBook: addressBook)

		XCTAssertTrue(result)
	}

}

//
//  qrcode-Test

/*class QRCodeGeneratorTests: XCTestCase {


 func testGenerateQRCode() {
 let qrCode = qrCodeView(addressString: "Test")
 let generatedImage = qrCode.generateQRCode(from: "Test")

 XCTAssertNotNil(generatedImage, "Generated image should not be nil")
 XCTAssertTrue(generatedImage.size.width > 0, "Generated image should have non-zero width")
 XCTAssertTrue(generatedImage.size.height > 0, "Generated image should have non-zero height")
 }

 }*/
//Performance Test

class QRCodeGenerationTests: XCTestCase {


	let test = QRCodeView(address: Recipient(firstName: "", lastName: "", address: Address(street: "", houseNumber: "", zip: "")))

	func testGenerateQRCodePerformance() {
		let stringToEncode = "Some string to encode"
		let amount = 1000
		var totalDuration: Double = 0.0

		for _ in 1...amount {
			let startDate = Date()

			let image = test.generateQRCode(from: stringToEncode)

			let endDate = Date()
			let duration = endDate.timeIntervalSince(startDate)
			totalDuration += duration

			XCTAssertNotNil(image)
		}

		let averageDuration = totalDuration / 100.0
		print("Average time to generate QR code: \(averageDuration) seconds")
		print("Total time to generate \(amount) QR codes: \(totalDuration) seconds")
	}
}


//adressFromView Testing

class AddressFormViewTests: XCTestCase {

	// Test for the `toStringQrString` method of the `recipient` structure

	func testRecipientToQRString() {
		let recipientInstance = Recipient(
			firstName: "John", lastName: "Doe",
			street: "Baker Street",
			houseNumber: "221B",
			zip: "12345"
		)
		let expectedOutput = "Doe&John&Baker Street&221B&12345"
		XCTAssertEqual(recipientInstance.toStringQrString(), expectedOutput)
	}

	func testAddresstoString() {

		let recipientInstance = Recipient(
			firstName: "John", lastName: "Doe",
			street: "Baker Street",
			houseNumber: "221B",
			zip: "12345",
			label: "Garage"
		)
		print(recipientInstance.toString())

		let expectedString = """
		Doe John
		Baker Street 221B
		Garage
		"""

		XCTAssertEqual(recipientInstance.toString(), expectedString)


	}

	// Test for the `addAddress` and `deleteAddress` methods of the `AddressBook` class

	func testAddressBookAddAndDelete() {
		let addressBook = AddressBook()
		let initialCount = addressBook.addressBook.count

		let newAddress = Recipient(
			firstName: "John", lastName: "Doe",
			street: "Baker Street",
			houseNumber: "221B",
			zip: "12345"
		)
		addressBook.addAddress(newAddress)
		XCTAssertEqual(addressBook.addressBook.count, initialCount + 1)

		addressBook.deleteAddress(at: [initialCount])
		XCTAssertEqual(addressBook.addressBook.count, initialCount)
	}

}

// StoreDetail

/*class StoreDetailTests: XCTestCase {

 // Test for the telephone tap interaction in `StoreDetail`
 func testTelephoneTapAction() {
 let mockStoreInfo = StoreInfo(
 id: "1" ,
 name: "Apple Store", owner: "Steve Jobs", street: "Kaiserstraße", houseNumber: "12", zip: "12345", city: "Lingen", telephone: "0123456789", email: "test@osna.de", logo: "https://img.freepik.com/freie-ikonen/mac-os_318-10374.jpg", coordinates: StoreInfo.Coordinates(latitude: 37.7749, longitude: -122.4194)       )

 let storeDetailView = StoreDetail(store: mockStoreInfo)

 }

 }*/

//AddressListView


class AddressListViewTests: XCTestCase {

	var addressListView: AddressListView!
	var mockAddressBook: AddressBook!

	override func setUp() {
		super.setUp()
		mockAddressBook = AddressBook()
		addressListView = AddressListView(addressBook: mockAddressBook)
	}

	override func tearDown() {

		for index in (0..<mockAddressBook.addressBook.count).reversed() {
			mockAddressBook.deleteAddress(at: IndexSet(integer: index))
		}

		addressListView = nil
		mockAddressBook = nil
		super.tearDown()
	}

	// Test to check if addresses are correctly loaded from the addressBook
	func testLoadAddresses() {

		let testAddress = Recipient(firstName: "John", lastName: "Doe", street: "Main Street", houseNumber: "123", zip: "12345", label: "Garage")
		
		mockAddressBook.addAddress(testAddress)


		XCTAssertEqual(mockAddressBook.addressBook.count, 1)
		XCTAssertEqual(mockAddressBook.addressBook.first?.firstName, "John")
	}

	// Test to check the functionality of the delete method
	func testDeleteAddress() {

		addressListView.delete(at: IndexSet(integer: 0))

		XCTAssertEqual(mockAddressBook.addressBook.count, 0)
	}

	func testAddAndDeleteAddresses() {
		let startTime = Date()
		let amount = 1000


		for _ in 1...amount {
			let testAddress = Recipient(firstName: "John", lastName: "Doe", street: "Main Street", houseNumber: "123", zip: "12345", label: "Garage")
			mockAddressBook.addAddress(testAddress)
		}

		XCTAssertEqual(mockAddressBook.addressBook.count, amount)

		for index in (0..<mockAddressBook.addressBook.count).reversed() {
			addressListView.delete(at: IndexSet(integer: index))
		}

		XCTAssertEqual(mockAddressBook.addressBook.count, 0)

		let endTime = Date()
		let timeInterval = endTime.timeIntervalSince(startTime)
		print("Time taken for \(amount) Addresses: \(timeInterval) seconds")
	}

	// Spy class for AddressBook to check if methods are called
	class SpyAddressBook: AddressBook {
		var loadDataCalled = false
		var saveDataCalled = false

		override func loadData() {
			loadDataCalled = true
		}

		override func saveData() {
			saveDataCalled = true
		}
	}
}

