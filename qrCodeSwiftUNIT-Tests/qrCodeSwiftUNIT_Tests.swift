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
//  qrcode-Test.swift

class QRCodeGeneratorTests: XCTestCase {
    
    func testGenerateQRCode() {
        let qrCode = qrCodeView(addressString: "Test")
        let generatedImage = qrCode.generateQRCode(from: "Test")
        
        XCTAssertNotNil(generatedImage, "Generated image should not be nil")
        XCTAssertTrue(generatedImage.size.width > 0, "Generated image should have non-zero width")
        XCTAssertTrue(generatedImage.size.height > 0, "Generated image should have non-zero height")
    }
    
}

