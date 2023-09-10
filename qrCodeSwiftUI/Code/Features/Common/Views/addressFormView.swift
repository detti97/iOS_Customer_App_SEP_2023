//
//  AddressForm.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 16.08.23.
//

import SwiftUI

import SwiftUI

/// A SwiftUI view for entering address information.
struct AddressFormView: View {

	/// An observed object representing the ``AddressBook``
	@ObservedObject var addressBook: AddressBook

	/// The recipient's information.
	@State var recipient = Recipient(firstName: "", lastName: "", address: Address(street: "", houseNumber: "", zip: "49809", city: "Lingen"))

	/// A binding to indicate the success of the operation.
	@Binding var success: Bool

	/// A label for the recipient (optional).
	@State var label = ""

	/// A flag to show a success alert.
	@State private var showSuccessAlert = false

	/// The environment value for dismissing the view.
	@Environment(\.dismiss) var dismiss

	/// An array of available zip codes.
	let zipCodes = ["49808", "49809", "49811"]

	/// The state variable for tracking the focused text field.
	@FocusState private var focusField: Field?

	/// Enumeration to represent different text fields.
	enum Field {
		case surname, name, street, housenumber, zip, discription
	}

	/// An array of state variables to track the state of each text field.
	@State var fields: [FieldTapped] = Array(repeating: FieldTapped(), count: 5)

	/// A state variable to indicate if a required title is missing.
	@State private var isTitleMissing: Bool = false

	/// A state variable for the input title.
	@State private var inputTitle: String = ""

	var body: some View {

		VStack {

			VStack {

				TextField("Vorname", text: $recipient.lastName)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "person"))
					.onTapGesture {
						checkForEmptyField()
						fields[0].fieldTapped = true
						fields[0].turnRed = false
					}
					.onChange(of: recipient.lastName) { _ in
						fields[0].textEntert = true
					}
					.overlay(RoundedRectangle(cornerRadius: 24)
						.stroke(fields[0].turnRed ? Color.red : Color.gray, lineWidth: 3)
					)
					.frame(maxWidth: .infinity)
					.focused($focusField, equals: .surname)
					.submitLabel(.next)
					.onSubmit {
						focusField = .name
					}

				TextField("Nachname", text: $recipient.firstName)
					.frame(height: 30)
					.padding(10)
					.frame(maxWidth: .infinity)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "figure.fall"))
					.onTapGesture {
						checkForEmptyField()
						fields[1].fieldTapped = true
						fields[1].turnRed = false
					}
					.onChange(of: recipient.firstName) { _ in
						fields[1].textEntert = true
					}
					.overlay(RoundedRectangle(cornerRadius: 24)
						.stroke(fields[1].turnRed ? Color.red : Color.gray, lineWidth: 3)
					)
					.focused($focusField, equals: .name)
					.submitLabel(.next)
					.onSubmit {
						focusField = .street
					}

				TextField("Straße", text: $recipient.address.street)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 24)
							.stroke(Color.gray, lineWidth: 3)
					)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "house"))
					.onTapGesture {
						checkForEmptyField()
						fields[2].fieldTapped = true
						fields[2].turnRed = false
					}
					.onChange(of: recipient.address.street) { _ in
						fields[2].textEntert = true
					}
					.overlay(RoundedRectangle(cornerRadius: 24)
						.stroke(fields[2].turnRed ? Color.red : Color.gray, lineWidth: 3)
					)
					.focused($focusField, equals: .street)
					.submitLabel(.next)
					.onSubmit {
						focusField = .housenumber
					}

				TextField("Hausnummer", text: $recipient.address.houseNumber)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 24)
							.stroke(Color.gray, lineWidth: 3)
					)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "figure.skiing.downhill"))
					.onTapGesture {
						checkForEmptyField()
						fields[3].fieldTapped = true
						fields[3].turnRed = false
					}
					.onChange(of: recipient.address.houseNumber) { _ in
						fields[3].textEntert = true
					}
					.onChange(of: recipient.address.houseNumber) { newValue in
						if newValue.count > 5 {
							recipient.address.houseNumber = String(newValue.prefix(5))
						}
					}
					.overlay(RoundedRectangle(cornerRadius: 24)
						.stroke(fields[3].turnRed ? Color.red : Color.gray, lineWidth: 3)
					)
					.focused($focusField, equals: .housenumber)
					.submitLabel(.next)
					.onSubmit {
						focusField = .zip
					}

				Picker("Postleitzahl", selection: $recipient.address.zip) {
					ForEach(zipCodes, id: \.self) { plz in
						Text(plz)
					}
				}
				.pickerStyle(SegmentedPickerStyle())
				.focused($focusField, equals: .zip)
				.overlay(RoundedRectangle(cornerRadius: 24)
					.stroke(fields[4].turnRed ? Color.gray : Color.gray, lineWidth: 3)
				)

				TextField("Bezeichnung (optional)", text: $label)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 24)
							.stroke(Color.gray, lineWidth: 3)
					)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "square.and.pencil"))
					.focused($focusField, equals: .discription)
					.submitLabel(.next)
					.onSubmit {
						focusField = nil
					}
					.onTapGesture {
						checkForEmptyField()
					}
			}

			VStack {

				Button(action: {

					recipient.label = label

					addressBook.addAddress(recipient)

					showSuccessAlert = true
					success = true

				}) {
					HStack {
						Image(systemName: "square.and.arrow.down.fill")
						Text("Adresse speichern")
					}
					.font(.headline)
					.padding()
					.frame(maxWidth: .infinity)
					.background(Color.accentColor)
					.foregroundColor(.white)
					.cornerRadius(18)
					.padding()
				}
				.disabled(recipient.lastName.isEmpty || recipient.address.street.isEmpty || recipient.address.houseNumber.isEmpty || recipient.address.zip.isEmpty)
				.onTapGesture {
					checkForEmptyFieldFinal()
				}
			}
			.alert(isPresented: $showSuccessAlert, content: {
				Alert(
					title: Text("Adresse gespeichert"),
					message: nil,
					dismissButton: .default(
						Text("OK"),
						action: { dismiss() }
					)
				)
			})
		}
	}

	/// Checks for empty fields and marks them as red.
	func checkForEmptyField() {

		for index in fields.indices {

			if fields[index].fieldTapped && !fields[index].textEntert {
				fields[index].turnRed = true
				print("Field \(index): Nichts eingegeben!")
			}
		}
	}

	/// Checks for empty fields before submission and marks them as red.
	func checkForEmptyFieldFinal() {

		for index in fields.indices {

			if !fields[index].textEntert {
				fields[index].turnRed = true
			}
		}
	}
}

struct AddressFormView_Previews: PreviewProvider {
	static var previews: some View {

		let address = Recipient(firstName: "", lastName: "", address: Address(street: "", houseNumber: "", zip: "", city: ""))
		let success = false

		AddressFormView(addressBook: AddressBook(), recipient: address, success: Binding.constant(success))
	}
}

/// A structure representing the state of a text field.
struct FieldTapped {

	/// A flag to indicate if the text field should turn red.
	var turnRed: Bool = false

	/// A flag to indicate if the text field was tapped.
	var fieldTapped: Bool = false

	/// A flag to indicate if text was entered in the field.
	var textEntert: Bool = false
}


