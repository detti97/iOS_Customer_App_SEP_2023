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


//Performance Test

class QRCodeGenerationTests: XCTestCase {


	let recipientInstance = Recipient(
		firstName: "John", lastName: "Doe",
		address: Address(street: "Baker Street",
						 houseNumber: "221B",
						 zip: "12345",
						 city: "Lingen"))


	func testGenerateQRCodePerformance() {
		let stringToEncode = recipientInstance.toStringQrString()
		let amount = 1000
		var totalDuration: Double = 0.0

		for _ in 1...amount {
			let startDate = Date()

			let image = QRCodeView.generateQRCode(from: stringToEncode)

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

	let recipientInstance = Recipient(
		firstName: "John", lastName: "Doe",
		address: Address(street: "Baker Street",
						 houseNumber: "221B",
						 zip: "12345",
						 city: "Lingen"))

	func testRecipientToQRString() {

		let expectedOutput = "Doe&John&Baker Street&221B&12345&Lingen"
		XCTAssertEqual(recipientInstance.toStringQrString(), expectedOutput)
	}

	func testRecipientToString() {

		let expectedOutput = "Doe John"
		XCTAssertEqual(recipientInstance.toString(), expectedOutput)

	}

	// Test for the `addAddress` and `deleteAddress` methods of the `AddressBook` class

	func testAddressBookAddAndDelete() {
		let addressBook = AddressBook()
		let initialCount = addressBook.addressBook.count

		addressBook.addAddress(recipientInstance)
		XCTAssertEqual(addressBook.addressBook.count, initialCount + 1)

		addressBook.deleteAddress(at: [initialCount])
		XCTAssertEqual(addressBook.addressBook.count, initialCount)
	}

	func testDeleteAll() {
		let addressBook = AddressBook()
		let amount = Int.random(in: 1..<5000)

		for _ in 1 ... amount {
			addressBook.addAddress(recipientInstance)
		}
		XCTAssertEqual(addressBook.addressBook.count, amount, "\(amount) addresses added")
		addressBook.deleteAllAddresses()

		XCTAssertEqual(addressBook.addressBook.count, 0, "All address should be deleted")
		print(amount)


	}

}


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

		let recipientInstance = Recipient(
			firstName: "John", lastName: "Doe",
			address: Address(street: "Baker Street",
							 houseNumber: "221B",
							 zip: "12345",
							 city: "Lingen"))
		
		mockAddressBook.addAddress(recipientInstance)


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

		mockAddressBook.deleteAllAddresses()

		for _ in 1...amount {
			let recipientInstance = Recipient(
				firstName: "John", lastName: "Doe",
				address: Address(street: "Baker Street",
								 houseNumber: "221B",
								 zip: "12345",
								 city: "Lingen"))
			mockAddressBook.addAddress(recipientInstance)
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

class DataManagerTests: XCTestCase {

	func testDecodeResponse_Success() {
		// Arrange
		let manager = DataManager()
		let expectation = XCTestExpectation(description: "Decode response expectation")

		// Create a sample JSON data
		let jsonData = """
  [{"id":"1","name":"Lingen Wirtschaft und Tourismus","owner":"Jan Koormann","address":{"street":"Kaiserstraße ","houseNumber":"12","zip":"49809","city":"Lingen"},"telephone":"0591 9144144","email":"raneaxxl@gmail.com","logo":"http://131.173.65.77:8080/Images/c6008a1b-9784-48d6-b7ea-1d203dc368c8.jpg","backgroundImage":"http://131.173.65.77:8080/Images/db77c38e-616d-48a8-b22d-ed4334b46667.jpg","coordinates":{"latitude":52.5203376,"longitude":7.3250601}},{"id":"2","name":"Willenbrock - Wein, wie ich ihn will.","owner":"Hendrick Willenbrock","address":{"street":"Bernd-Rosemeyer-Straße","houseNumber":"40","zip":"49808","city":"Lingen"},"telephone":"0591 963360","email":" ","logo":"http://131.173.65.77:8080/Images/d0c2c780-ce4c-4dca-9e4e-15152c9a0b85.jpg","backgroundImage":"http://131.173.65.77:8080/Images/b7f15ec0-1d7a-43bf-b52c-07dcafe8bf9a.jpg","coordinates":{"latitude":52.5182588,"longitude":7.3181351}},{"id":"3","name":"newStore","owner":"newStore","address":{"street":"Kaiserstraße","houseNumber":"5","zip":"49808","city":"Lingen"},"telephone":"345345","email":"sdfg@gmail.com","logo":"http://131.173.65.77:8080/Images/778a1bf9-083e-4204-838e-c47b0b6dadda.jpg","backgroundImage":"http://131.173.65.77:8080/Images/92270135-0d77-4906-9802-a4667c61dcad.jpg","coordinates":{"latitude":52.517303,"longitude":7.3203453}}]
  """.data(using: .utf8)

		// Act
		manager.decodeResponse(jsonData)

		// Assert
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			XCTAssertFalse(manager.errorLoading)
			XCTAssertEqual(manager.stores.count, 3)

			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 5.0)
	}

	func testDecodeResponse_Failure() {
			let manager = DataManager()
			let expectation = XCTestExpectation(description: "Decode response expectation")

			let invalidJsonData = "Invalid JSON".data(using: .utf8)

			manager.decodeResponse(invalidJsonData)

			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

				XCTAssertTrue(manager.errorLoading)

				expectation.fulfill()
			}

			wait(for: [expectation], timeout: 5.0)
		}

	func testLoadData() {

		let manager = DataManager()
		let expectation = XCTestExpectation(description: "LoadData expectation")

		manager.loadData(url: DataManager.api_endpoints.storeDetail)

		DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {

			XCTAssertFalse(manager.errorLoading)
			XCTAssertEqual(manager.stores.count, 3)

			expectation.fulfill()

		}

		wait(for: [expectation], timeout: 5.0)

	}

	func testLoadDataError() {

		let manager = DataManager()
		let expectation = XCTestExpectation(description: "LoadData expectation")

		manager.loadData(url: "http://131.173.65.77:8080/api/store-detail")


		DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {

			XCTAssertTrue(manager.errorLoading)
			XCTAssertEqual(manager.stores.count, 0)

			expectation.fulfill()

		}

		wait(for: [expectation], timeout: 5.0)

	}

	func testLoadDataTimeOut() {

		let manager = DataManager()
		let expectation = XCTestExpectation(description: "LoadData Timeout expectation")

		manager.loadData(url: "abc")


		DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {

			XCTAssertTrue(manager.errorLoading)
			XCTAssertEqual(manager.stores.count, 0)

			expectation.fulfill()

		}

		wait(for: [expectation], timeout: 5.0)

	}

}
