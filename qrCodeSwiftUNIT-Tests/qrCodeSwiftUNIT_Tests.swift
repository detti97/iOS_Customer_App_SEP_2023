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
        return addressBook.addresses.isEmpty
    }
    
    //Funktion überprüfen
    func testShouldShowAddressAlertWhenAddressBookIsEmpty() {
        let addressBook = AddressBook()
        addressBook.addresses = []
        
        let result = shouldShowAddressAlert(addressBook: addressBook)
        
        XCTAssertTrue(result)
    }
    
}

//
//  qrcode-Test

class QRCodeGeneratorTests: XCTestCase {
    
    func testGenerateQRCode() {
        let qrCode = qrCodeView(addressString: "Test")
        let generatedImage = qrCode.generateQRCode(from: "Test")
        
        XCTAssertNotNil(generatedImage, "Generated image should not be nil")
        XCTAssertTrue(generatedImage.size.width > 0, "Generated image should have non-zero width")
        XCTAssertTrue(generatedImage.size.height > 0, "Generated image should have non-zero height")
    }

}


//adressFromView Testing

class AddressFormViewTests: XCTestCase {

    // Test for the `toStringQrString` method of the `recipient` structure
    
    func testRecipientToQRString() {
        let recipientInstance = recipient(
            lastName: "Doe",
            firstName: "John",
            street: "Baker Street",
            streetNr: "221B",
            plz: "12345"
        )
        let expectedOutput = "John&Doe&Baker Street&221B&12345"
        XCTAssertEqual(recipientInstance.toStringQrString(), expectedOutput)
    }

    // Test for the `addAddress` and `deleteAddress` methods of the `AddressBook` class
    
    func testAddressBookAddAndDelete() {
        let addressBook = AddressBook()
        let initialCount = addressBook.addresses.count
        
        let newAddress = recipient(
            lastName: "Doe",
            firstName: "John",
            street: "Baker Street",
            streetNr: "221B",
            plz: "12345"
        )
        addressBook.addAddress(newAddress)
        XCTAssertEqual(addressBook.addresses.count, initialCount + 1)
        
        addressBook.deleteAddress(at: [initialCount])
        XCTAssertEqual(addressBook.addresses.count, initialCount)
    }

}

// StoreDetail

class StoreDetailTests: XCTestCase {
    
    // Test for the telephone tap interaction in `StoreDetail`
    func testTelephoneTapAction() {
        let mockStoreInfo = StoreInfo(
            id: "1" ,
            name: "Apple Store", owner: "Steve Jobs", street: "Kaiserstraße", houseNumber: "12", zip: "12345", city: "Lingen", telephone: "0123456789", email: "test@osna.de", logo: "https://img.freepik.com/freie-ikonen/mac-os_318-10374.jpg", coordinates: StoreInfo.Coordinates(latitude: 37.7749, longitude: -122.4194)       )
        
        let storeDetailView = StoreDetail(store: mockStoreInfo)
        
    }
    
}

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
        addressListView = nil
        mockAddressBook = nil
        super.tearDown()
    }
    
    // Test to check if addresses are correctly loaded from the addressBook
    func testLoadAddresses() {
        let testAddress = recipient(lastName: "Doe", firstName: "John", street: "Main Street", streetNr: "123", plz: "12345")
        mockAddressBook.addAddress(testAddress)
        
        
        XCTAssertEqual(mockAddressBook.addresses.count, 3)
        XCTAssertEqual(mockAddressBook.addresses.first?.lastName, "Doe")
    }
    
    // Test to check the functionality of the delete method
    func testDeleteAddress() {
        let testAddress = recipient(lastName: "Doe", firstName: "John", street: "Main Street", streetNr: "123", plz: "12345")
        mockAddressBook.addAddress(testAddress)
        
        addressListView.delete(at: IndexSet(integer: 0))
        
        XCTAssertEqual(mockAddressBook.addresses.count, 0)
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
