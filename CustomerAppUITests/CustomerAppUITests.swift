//
//  CustomerAppUITests.swift
//  CustomerAppUITests
//
//  Created by Jan Dettler on 17.08.23.
//

import XCTest

@testable import qrCodeSwiftUI
final class CustomerAppUITests: XCTestCase {

	override func setUpWithError() throws {

			continueAfterFailure = false
		}


    func testBasicFunctions() throws {
        // UI tests must launch the application that they test.


		//let testRecipient = Recipient(firstName: "UI", lastName: "Test", address: address)
		let firstName = "UI"
		let lastName = "Test"
		let street  = "Kaiserstraße"
		let houseNumber = "12"

        let app = XCUIApplication()
        app.launch()

		Thread.sleep(forTimeInterval: 5.0)

		let tabBar = app.tabBars["Tab Bar"]
		XCTAssert(tabBar.exists)

		let tabBarSettings = tabBar.buttons["Einstellungen"]
		XCTAssert(tabBarSettings.exists)
		tabBarSettings.tap()

		let deleteButton = app.buttons["deleteAll"]
		XCTAssert(deleteButton.exists)
		deleteButton.tap()

		Thread.sleep(forTimeInterval: 2.0)

		let deleteAlert = app.alerts["Alle Adressen löschen"]
		XCTAssert(deleteAlert.exists)
		deleteAlert.buttons["Löschen"].tap()

		let tabBarCode = tabBar.buttons["Lingen Code"]
		XCTAssert(tabBarCode.exists)
		tabBarCode.tap()


		let buttonAdd = app.buttons["Hinzufügen"]
		XCTAssertTrue(buttonAdd.exists)
		buttonAdd.tap()

		let firstNameField = app.textFields["Vorname"]
		XCTAssert(firstNameField.exists)
		firstNameField.tap()
		firstNameField.typeText(firstName)

		let lastNameField = app.textFields["Nachname"]
		XCTAssert(lastNameField.exists)
		lastNameField.tap()
		lastNameField.typeText(lastName)

		let streetField = app.textFields["Straße"]
		XCTAssert(streetField.exists)
		streetField.tap()
		streetField.typeText(street)

		let houseNumberField = app.textFields["Hausnummer"]
		XCTAssert(houseNumberField.exists)
		houseNumberField.tap()
		houseNumberField.typeText(houseNumber)

		let bezeichnungOptionalTextField = app.textFields["Bezeichnung (optional)"]
		XCTAssert(bezeichnungOptionalTextField.exists)
		bezeichnungOptionalTextField.tap()
		bezeichnungOptionalTextField.typeText("SEP 23")


		let nextButton = app/*@START_MENU_TOKEN@*/.buttons["Weiter"]/*[[".keyboards",".buttons[\"Weiter\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[1]]@END_MENU_TOKEN@*/
		XCTAssert(nextButton.exists)
		nextButton.tap()

		Thread.sleep(forTimeInterval: 2.0)

		let buttonSaveAddress = app.buttons["Adresse speichern"]
		XCTAssert(buttonSaveAddress.exists)
		buttonSaveAddress.tap()
		app.alerts["Adresse gespeichert"].scrollViews.otherElements.buttons["OK"].tap()

		app.navigationBars["Neue Adresse hinzufügen"]/*@START_MENU_TOKEN@*/.buttons["Zurück"]/*[[".otherElements[\"Zurück\"].buttons[\"Zurück\"]",".buttons[\"Zurück\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

		let collectionViewsQuery = app.collectionViews
		let firstListElement = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["1"]/*[[".cells.buttons[\"1\"]",".buttons[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		firstListElement.tap()

		let zurCkButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"]/*@START_MENU_TOKEN@*/.buttons["Zurück"]/*[[".otherElements[\"Zurück\"].buttons[\"Zurück\"]",".buttons[\"Zurück\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		zurCkButton.tap()


		let tabBarErkunden = tabBar.buttons["Erkunden"]
		XCTAssert(tabBarErkunden.exists)
		tabBarErkunden.tap()

		app.tabBars["Tab Bar"].buttons["Erkunden"].tap()
		app.collectionViews/*@START_MENU_TOKEN@*/.buttons["1"]/*[[".cells.buttons[\"1\"]",".buttons[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

		XCTAssertTrue(app.staticTexts["storeNameLabel"].exists)
		XCTAssertTrue(app.staticTexts["storeOwnerLabel"].exists)
		XCTAssertTrue(app.staticTexts["storeAddressLabel"].exists)
		XCTAssertTrue(app.staticTexts["storePhoneLabel"].exists)
		XCTAssertTrue(app.staticTexts["storeEmailLabel"].exists)

		app.navigationBars["Lingen Wirtschaft und Tourismus"].buttons["Teilnehmende Geschäfte"].tap()
		app.tabBars["Tab Bar"].buttons["Einstellungen"].tap()
		app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Impressum"]/*[[".cells.buttons[\"Impressum\"]",".buttons[\"Impressum\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

}

final class CustomerAppIntroUITest: XCTestCase {

	override func setUpWithError() throws {
			try super.setUpWithError()
			UserDefaults.standard.set(false, forKey: "IntroState")
			continueAfterFailure = false
		}

	func testIntroView() throws {


		let app = XCUIApplication()
		app.launch()

		Thread.sleep(forTimeInterval: 3.0)

		let nextButton = app.buttons["Next"]

		if(!nextButton.exists){

			app.tabBars["Tab Bar"].buttons["Einstellungen"].tap()
			app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Intro Reset - nur für Demo"]/*[[".cells.buttons[\"Intro Reset - nur für Demo\"]",".buttons[\"Intro Reset - nur für Demo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

		}


		XCTAssert(nextButton.exists)
		nextButton.tap()

		let addAddressButton = app.buttons["Adresse hinzufügen"]
		XCTAssert(addAddressButton.exists)
		addAddressButton.tap()

		let firstNameField = app.textFields["Vorname"]
		XCTAssert(firstNameField.exists)
		firstNameField.tap()
		firstNameField.typeText("UI")

		let lastNameField = app.textFields["Nachname"]
		XCTAssert(lastNameField.exists)
		lastNameField.tap()
		lastNameField.typeText("Test")

		let streetField = app.textFields["Straße"]
		XCTAssert(streetField.exists)
		streetField.tap()
		streetField.typeText("Kaiserstraße")

		let houseNumberField = app.textFields["Hausnummer"]
		XCTAssert(houseNumberField.exists)
		houseNumberField.tap()
		houseNumberField.typeText("12")

		let bezeichnungOptionalTextField = app.textFields["Bezeichnung (optional)"]
		XCTAssert(bezeichnungOptionalTextField.exists)
		bezeichnungOptionalTextField.tap()
		bezeichnungOptionalTextField.typeText("Mensa")

		let nextButton2 = app/*@START_MENU_TOKEN@*/.buttons["Weiter"]/*[[".keyboards",".buttons[\"Weiter\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[1]]@END_MENU_TOKEN@*/
				XCTAssert(nextButton2.exists)
				nextButton2.tap()

		app.buttons["Adresse speichern"].tap()

		let nextButton3 = app.buttons["Next"]
		XCTAssert(nextButton3.exists)
		nextButton3.tap()

	}


}
