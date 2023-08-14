//
//  IntroView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 11.07.23.
//

import SwiftUI

struct IntroView: View {
	@Binding var introState: Bool
	@ObservedObject var addressBook: AddressBook

	@State private var isActiveFirstStep = true
	@State private var isActiveSeccondStep = false
	@State private var isActiveThirdStep = false
	@State private var isActiveAddAddress = false
	let zipCodes = ["49808", "49809" , "49811"]

	@State private var name: String = ""
	@State private var surName: String = ""
	@State private var street: String = ""
	@State private var streetNr: String = ""
	@State private var plz: String = ""
	@State private var label: String = ""

	@FocusState private var focusField: Field?

	enum Field{
		case surname, name, street, housenumber, zip, discription
	}

	var body: some View {

			VStack{
				
				if isActiveFirstStep{
					
					VStack{
						
						Spacer()
							.frame(height: 40)
						
						Image("undraw_shopping_bags_iafb")
							.resizable()
							.scaledToFit()
						
						Spacer()
							.frame(height: 60)
						
						Text("Welcome to LingenLiefert 2.0")
							.font(.largeTitle)
							.fontWeight(.heavy)
							.padding()
							.multilineTextAlignment(.center)
						
						Spacer()
							.frame(height: 20)
						
						Text("Kaufen Sie in teilnehmenden lokalen Geschäften ein und lassen Sie sich Ihre Einkäufe nach Hause liefern")
							.font(.body)
							.fontWeight(.heavy)
							.padding()
							.multilineTextAlignment(.center)
							.foregroundColor(.purple)
						
						Spacer()
							.frame(height: 100)
						
						Button(action: {
							
							isActiveFirstStep = false
							isActiveSeccondStep = true

						}) {
							Text("Next")
								.font(.headline)
								.padding()
								.frame(maxWidth: .infinity)
								.background(Color.purple)
								.foregroundColor(.white)
								.cornerRadius(18)
								.padding()
						}


					}
				}

				if isActiveSeccondStep{

					VStack{

						Spacer()
							.frame(height: 40)

						Image("undraw_confirmed_re_sef7")
							.resizable()
							.scaledToFit()

						Spacer()
							.frame(height: 60)

						Text("Hinterlegen Sie Ihre Adresse")
							.font(.largeTitle)
							.fontWeight(.heavy)
							.padding()
							.multilineTextAlignment(.center)

						Spacer()
							.frame(height: 20)

						Text("Der erstellte Code wird nach Ihrem Einkauf gescannt und die Lieferung beauftragt ")
							.font(.body)
							.fontWeight(.heavy)
							.padding()
							.multilineTextAlignment(.center)

						Spacer()
							.frame(height: 100)

						Button(action: {

							isActiveSeccondStep = false
							isActiveAddAddress = true

						}) {
							Text("Adresse hinzufügen")
								.font(.headline)
								.padding()
								.frame(maxWidth: .infinity)
								.background(Color.purple)
								.foregroundColor(.white)
								.cornerRadius(18)
								.padding()


						}

					}
				}
				if isActiveAddAddress{

					VStack {

						Image("undraw_delivery_address_re_cjca")
							.resizable()
							.frame(width: 220, height: 200)



						Text("Geben Sie hier Ihre Adresse ein")
							.font(.largeTitle)
							.fontWeight(.heavy)
							.padding()
							.multilineTextAlignment(.center)

						Spacer()
							.frame(height: 10)

						TextField("Vorname", text: $surName)
							.frame(height: 30)
							.frame(maxWidth: .infinity)
							.padding(10)
							.textFieldStyle(CustomTextFieldStyle(systemImageName: "person"))
							.overlay(
								RoundedRectangle(cornerRadius: 8)
									.stroke(Color.gray, lineWidth: 1)
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
							.overlay(
								RoundedRectangle(cornerRadius: 8)
									.stroke(Color.gray, lineWidth: 1)
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
								RoundedRectangle(cornerRadius: 8)
									.stroke(Color.gray, lineWidth: 1)
							)
							.textFieldStyle(CustomTextFieldStyle(systemImageName: "house"))
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
								RoundedRectangle(cornerRadius: 8)
									.stroke(Color.gray, lineWidth: 1)
							)
							.textFieldStyle(CustomTextFieldStyle(systemImageName: "figure.skiing.downhill"))
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
						TextField("Bezeichnung (optional)", text: $label)
							.frame(height: 30)
							.frame(maxWidth: .infinity)
							.padding(10)
							.overlay(
								RoundedRectangle(cornerRadius: 8)
									.stroke(Color.gray, lineWidth: 1)
							)
							.textFieldStyle(CustomTextFieldStyle(systemImageName: "square.and.pencil"))
							.focused($focusField, equals: .discription)
							.submitLabel(.next)
							.onSubmit {
								focusField = nil
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

							isActiveThirdStep = true
							isActiveAddAddress = false

							/*saveIntroState(true)
							introState = true*/
						}) {
							HStack {
								Image(systemName: "square.and.arrow.down.fill")
								Text("Adresse speichern")
							}
							.font(.headline)
							.padding()
							.frame(maxWidth: .infinity)
							.background(Color.purple)
							.foregroundColor(.white)
							.cornerRadius(18)
							.padding()
						}
						.disabled(name.isEmpty || street.isEmpty || streetNr.isEmpty || plz.isEmpty)
					}
					.padding(20)

				}

				if isActiveThirdStep {

					VStack{

						Spacer()
							.frame(height: 40)

						Image("undraw_completed_03xt")
							.resizable()
							.scaledToFit()

						Spacer()
							.frame(height: 60)

						Text("App ist bereit")
							.font(.largeTitle)
							.fontWeight(.heavy)
							.padding()
							.multilineTextAlignment(.center)

						Spacer()
							.frame(height: 20)

						Text("Die Einrichtung ist fertig und Sie können nun die App benutzen")
							.font(.body)
							.fontWeight(.heavy)
							.padding()
							.multilineTextAlignment(.center)

						Spacer()
							.frame(height: 100)

						Button(action: {

							saveIntroState(true)
							introState = true


						}) {
								Text("Next")
									.font(.headline)
									.padding()
									.frame(maxWidth: .infinity)
									.background(Color.purple)
									.foregroundColor(.white)
									.cornerRadius(18)
									.padding()

						}
					}

				}
			}
		}

	func saveIntroState(_ introState: Bool) {
		UserDefaults.standard.set(introState, forKey: "IntroState")
		
	}

		struct IntroView_Previews: PreviewProvider {



			static var previews: some View {
				IntroView(introState: .constant(false), addressBook: AddressBook())
			}
		}
	}

