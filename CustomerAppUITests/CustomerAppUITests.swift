//
//  CustomerAppUITests.swift
//  CustomerAppUITests
//
//  Created by Jan Dettler on 17.08.23.
//

import XCTest

final class CustomerAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }


    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

		

		Thread.sleep(forTimeInterval: 5.0)

		let buttonAdd = app.buttons["Hinzufügen"]
		XCTAssertTrue(buttonAdd.exists)

		buttonAdd.tap()

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
		streetField.typeText("Kaiserstrasse")

		let houseNumberField = app.textFields["Hausnummer"]
		XCTAssert(houseNumberField.exists)
		houseNumberField.tap()
		houseNumberField.typeText("12")

		let bezeichnungOptionalTextField = app.textFields["Bezeichnung (optional)"]
		XCTAssert(bezeichnungOptionalTextField.exists)
		bezeichnungOptionalTextField.tap()
		bezeichnungOptionalTextField.typeText("Mensa")


		let nextButton = app/*@START_MENU_TOKEN@*/.buttons["Weiter"]/*[[".keyboards",".buttons[\"Weiter\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[1]]@END_MENU_TOKEN@*/
		XCTAssert(nextButton.exists)
		nextButton.tap()

		Thread.sleep(forTimeInterval: 2.0)

		let buttonSaveAddress = app.buttons["Adresse speichern"]
		XCTAssert(buttonSaveAddress.exists)
		buttonSaveAddress.tap()

		app.alerts["Adresse gespeichert"].scrollViews.otherElements.buttons["OK"].tap()

		app.navigationBars["Neue Adresse hinzufügen"]/*@START_MENU_TOKEN@*/.buttons["Zurück"]/*[[".otherElements[\"Zurück\"].buttons[\"Zurück\"]",".buttons[\"Zurück\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

		let tabBar = app.tabBars["Tab Bar"]
		XCTAssert(tabBar.exists)

		let tabBarCode = tabBar.buttons["Lingen Code"]
		XCTAssert(tabBarCode.exists)

		let tabBarErkunden = tabBar.buttons["Erkunden"]
		XCTAssert(tabBarErkunden.exists)

		let tabBarSettings = tabBar.buttons["Einstellungen"]
		XCTAssert(tabBarSettings.exists)


	    let collectionViewsQuery = app.collectionViews
		//let janSettlerKaiserstraE39UniButton = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Jan Settler\nKaiserstraße 39\nUni"]/*[[".cells.buttons[\"Jan Settler\\nKaiserstraße 39\\nUni\"]",".buttons[\"Jan Settler\\nKaiserstraße 39\\nUni\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		//janSettlerKaiserstraE39UniButton.swipeLeft()

		let navigationBarEditButton = app.navigationBars["Addresses"]/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".otherElements[\"Edit\"].buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		XCTAssert(navigationBarEditButton.exists)
		navigationBarEditButton.tap()
		collectionViewsQuery.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"remove").element.tap()


		tabBarErkunden.tap()

		collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["McDonalds"]/*[[".cells.buttons[\"McDonalds\"]",".buttons[\"McDonalds\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

		XCTAssertTrue(app.images.matching(identifier: "storeLogoImage").element.exists)

		XCTAssertTrue(app.staticTexts["storeNameLabel"].exists)
		XCTAssertTrue(app.staticTexts["storeOwnerLabel"].exists)
		XCTAssertTrue(app.staticTexts["storeAddressLabel"].exists)
		XCTAssertTrue(app.staticTexts["storePhoneLabel"].exists)
		XCTAssertTrue(app.staticTexts["storeEmailLabel"].exists)
		XCTAssertTrue(app.maps["mapView"].exists)


		let app = XCUIApplication()
		let collectionViewsQuery = app.collectionViews
		let didFigsDsfDassaultDddButton = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Did Figs\nDSF Dassault\nDdd"]/*[[".cells.buttons[\"Did Figs\\nDSF Dassault\\nDdd\"]",".buttons[\"Did Figs\\nDSF Dassault\\nDdd\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		didFigsDsfDassaultDddButton.swipeLeft()

		let zurCkButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"]/*@START_MENU_TOKEN@*/.buttons["Zurück"]/*[[".otherElements[\"Zurück\"].buttons[\"Zurück\"]",".buttons[\"Zurück\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		zurCkButton.tap()
		didFigsDsfDassaultDddButton.swipeLeft()
		zurCkButton.tap()
		app.navigationBars["Addresses"]/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".otherElements[\"Edit\"].buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"remove").element.tap()
				


/*
		let scrollViewsQuery = app.scrollViews
		let elementsQuery = scrollViewsQuery.otherElements
		let vkpointfeatureMap = elementsQuery/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"VKPointFeature").element/*[[".maps.containing(.other, identifier:\"Map pin\").element",".maps.containing(.other, identifier:\"VKPointFeature\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		vkpointfeatureMap.tap()
		vkpointfeatureMap.tap()
*/

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
