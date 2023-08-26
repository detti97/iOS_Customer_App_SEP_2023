//
//  AddressForm.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 16.08.23.
//

import SwiftUI

struct addressFormView: View {

	@ObservedObject var addressBook: AddressBook
	@State var address = Recipient(firstName: "", lastName: "", address: Address(street: "", houseNumber: "", zip: "49809", city: "lingen"))
	@Binding var success: Bool
	@State var label = ""
	@State private var showSuccessAlert = false
	@Environment(\.dismiss) var dismiss
	let zipCodes = ["49808", "49809" , "49811"]
	@FocusState private var focusField: Field?

	enum Field{
		case surname, name, street, housenumber, zip, discription
	}
	
	@State var fields: [FieldTapped] = Array(repeating: FieldTapped(), count: 5)
	@State private var isTitleMissing: Bool = false
	@State private var inputTitle: String = ""



	
	var body: some View {

		VStack{

			VStack{

				TextField("Vorname", text: $address.lastName)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "person"))
					.onTapGesture{
						checkForEmptyField()
						fields[0].fieldTapped = true
						fields[0].turnRed = false

					}
					.onChange(of: address.lastName) { _ in

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

				TextField("Nachname", text: $address.firstName)
					.frame(height: 30)
					.padding(10)
					.frame(maxWidth: .infinity)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "figure.fall"))
					.onTapGesture{
						checkForEmptyField()
						fields[1].fieldTapped = true
						fields[1].turnRed = false


					}
					.onChange(of: address.firstName) { _ in

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

				TextField("Straße", text: $address.address.street)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 24)
							.stroke(Color.gray, lineWidth: 3)
					)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "house"))
					.onTapGesture{
						checkForEmptyField()
						fields[2].fieldTapped = true
						fields[2].turnRed = false


					}
					.onChange(of: address.address.street) { _ in

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

				TextField("Hausnummer", text: $address.address.houseNumber)
					.frame(height: 30)
					.frame(maxWidth: .infinity)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 24)
							.stroke(Color.gray, lineWidth: 3)
					)
					.textFieldStyle(CustomTextFieldStyleView(systemImageName: "figure.skiing.downhill"))
					.onTapGesture{
						checkForEmptyField()
						fields[3].fieldTapped = true
						fields[3].turnRed = false
					}
					.onChange(of: address.address.houseNumber) { _ in

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
				Picker("Postleitzahl", selection: $address.address.zip) {
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
					.onTapGesture{
						checkForEmptyField()
					}
			}

			VStack{

				Button(action: {

					address.label = label

					addressBook.addAddress(address)

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
				.disabled(address.lastName.isEmpty || address.address.street.isEmpty || address.address.houseNumber.isEmpty || address.address.zip.isEmpty)
				.onTapGesture{
					checkForEmptyFieldFinal()
				}


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

struct AddressFormView_Previews: PreviewProvider {
    static var previews: some View {

		let address = Recipient(firstName: "", lastName: "", address: Address(street: "", houseNumber: "", zip: "", city: ""))
		let success = false

		addressFormView(addressBook: AddressBook(), address: address, success: Binding.constant(success)  )
    }
}

struct FieldTapped{

	var turnRed: Bool = false
	var fieldTapped: Bool = false
	var textEntert: Bool = false

}
