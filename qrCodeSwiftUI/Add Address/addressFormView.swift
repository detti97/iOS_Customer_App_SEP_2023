//
//  addressFormView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI

struct FieldTapped{

	var turnRed: Bool = false
	var fieldTapped: Bool = false
	var textEntert: Bool = false

}


struct addressFormView: View {

	let zipCodes = ["49808", "49809" , "49811"]

	@State private var name: String = ""
	@State private var surName: String = ""
	@State private var street: String = ""
	@State private var streetNr: String = ""
	@State private var plz: String = "49809"
	@State private var label: String = ""

	@State var fields: [FieldTapped] = Array(repeating: FieldTapped(), count: 5)

	@State private var isTitleMissing: Bool = false
	@State private var inputTitle: String = ""
	@State private var fieldTapped: Bool = false

	@State private var showSuccessAlert = false
	@ObservedObject var addressBook: AddressBook

	@Environment(\.dismiss) var dismiss
	@Environment(\.presentationMode) private var presentationMode

	@FocusState private var focusField: Field?

	@EnvironmentObject var appState: AppState

	enum Field{
		case surname, name, street, housenumber, zip, discription
	}

	var body: some View {

		NavigationView {

			VStack {

				Image("undraw_delivery_address_re_cjca")
					.resizable()
					.frame(width: 220, height: 180)

				TextField("Vorname", text: $surName)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.textFieldStyle(CustomTextFieldStyle(systemImageName: "person"))
					.onTapGesture{
						checkForEmptyField()
						fields[0].fieldTapped = true
						fields[0].turnRed = false

					}
					.onChange(of: surName) { _ in

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

				TextField("Nachname", text: $name)
					.frame(height: 30)
					.padding(10)
					.frame(maxWidth: .infinity)
					.textFieldStyle(CustomTextFieldStyle(systemImageName: "figure.fall"))
					.onTapGesture{
						checkForEmptyField()
						fields[1].fieldTapped = true
						fields[1].turnRed = false


					}
					.onChange(of: name) { _ in

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

				TextField("Straße", text: $street)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 24)
							.stroke(Color.gray, lineWidth: 3)
					)
					.textFieldStyle(CustomTextFieldStyle(systemImageName: "house"))
					.onTapGesture{
						checkForEmptyField()
						fields[2].fieldTapped = true
						fields[2].turnRed = false


					}
					.onChange(of: street) { _ in

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

				TextField("Hausnummer", text: $streetNr)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 24)
							.stroke(Color.gray, lineWidth: 3)
					)
					.textFieldStyle(CustomTextFieldStyle(systemImageName: "figure.skiing.downhill"))
					.onTapGesture{
						checkForEmptyField()
						fields[3].fieldTapped = true
						fields[3].turnRed = false
					}
					.onChange(of: streetNr) { _ in

						fields[3].textEntert = true
					}
					.overlay(RoundedRectangle(cornerRadius: 24)
						.stroke(fields[3].turnRed ? Color.red : Color.gray, lineWidth: 3)
					)
					.focused($focusField, equals: .housenumber)
					.submitLabel(.next)
					.onSubmit {
						focusField = .zip
					}
				Picker("Postleitzahl", selection: $plz) {
					ForEach(zipCodes, id: \.self) { plz in
						Text(plz)
					}
				}
				.pickerStyle(SegmentedPickerStyle())
				.focused($focusField, equals: .zip)
				.overlay(RoundedRectangle(cornerRadius: 24)
					.stroke(fields[4].turnRed ? Color.red : Color.gray, lineWidth: 3)
				)

				TextField("Bezeichnung (optional)", text: $label)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 24)
							.stroke(Color.gray, lineWidth: 3)
					)
					.textFieldStyle(CustomTextFieldStyle(systemImageName: "square.and.pencil"))
					.focused($focusField, equals: .discription)
					.submitLabel(.next)
					.onSubmit {
						focusField = nil
					}
					.onTapGesture{
						checkForEmptyField()
					}

				Button(action: {
					let address = recipient(lastName: name, firstName: surName, street: street, streetNr: streetNr, plz: plz, label: label.isEmpty ? nil : label)
					addressBook.addAddress(address)

					name = ""
					surName = ""
					street = ""
					streetNr = ""
					plz = ""
					label = ""

					showSuccessAlert = true

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
				.disabled(name.isEmpty || street.isEmpty || streetNr.isEmpty || plz.isEmpty)
				.onTapGesture{
					checkForEmptyFieldFinal()
				}
			}
			.navigationBarTitle("Neue Adresse hinzufügen")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarItems(leading: cancelButton)
			.padding(20)
		}

		.alert(isPresented: $showSuccessAlert, content: {
			Alert(
				title: Text("Adresse gespeichert"),
				message: nil,
				dismissButton: .default(
					Text("OK"),
					action: { dismiss()
					}
				)
			)
		})
	}

	private var cancelButton: some View {
		Button(action: {
			presentationMode.wrappedValue.dismiss()
		}) {
			Text("Zurück")
		}
	}

	func checkForEmptyField() {

		for index in fields.indices {

			if fields[index].fieldTapped && !fields[index].textEntert{
				fields[index].turnRed = true
				print("Field \(index): Nichts eingegeben!")
			}
		}


	}
	func checkForEmptyFieldFinal() {

		for index in fields.indices {

			if !fields[index].textEntert {
				fields[index].turnRed = true
			}
		}
	}
}


struct addressFormView_Previews: PreviewProvider {

	static var previews: some View {
		addressFormView(addressBook: AddressBook())
	}
}
