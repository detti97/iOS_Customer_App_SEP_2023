//
//  addressFormView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI

struct recipient: Identifiable, Codable {
    var id = UUID()
    var lastName: String
    var firstName: String
    var street: String
    var streetNr: String
    var plz: String
    var label: String?
    
    func toString() -> String {
            var result = "\n\(firstName) \(lastName) \n"
            result += "\(street) \(streetNr)\n"
            
            if let label = label {
                result += "\(label)"
            }
            return result
        }
    func toStringQrString() -> String {
        let result = "\(firstName)&\(lastName)&\(street)&\(streetNr)&\(plz)"
            return result
        }
}

class AddressBook: ObservableObject {
	@Published var addresses: [recipient] = []

	init() {
		loadData()
	}

	func addAddress(_ address: recipient) {
		addresses.append(address)
		saveData()
	}

	func deleteAddress(at indexSet: IndexSet) {
		addresses.remove(atOffsets: indexSet)
		saveData()
	}

	func loadData() {
		if let data = UserDefaults.standard.data(forKey: "addressBook") {
			do {
				let decoder = JSONDecoder()
				addresses = try decoder.decode([recipient].self, from: data)
			} catch {
				print("Error loading data: \(error)")
			}
		}
	}

	func saveData() {
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(addresses)
			UserDefaults.standard.set(data, forKey: "addressBook")
		} catch {
			print("Error saving data: \(error)")
		}
	}
}


struct addressFormView: View {
    
    let zipCodes = ["49808", "49809" , "49811"]
    
    @State private var name: String = ""
    @State private var surName: String = ""
    @State private var street: String = ""
    @State private var streetNr: String = ""
    @State private var plz: String = ""
    @State private var label: String = ""
    
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
            Form {
                Section(header: Text("Adresse")) {
                    TextField("Vorname", text: $surName)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "person"))
						.focused($focusField, equals: .surname)
						.submitLabel(.next)
						.onSubmit {
							focusField = .name
						}
                    TextField("Nachname", text: $name)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "figure.fall"))
						.focused($focusField, equals: .name)
						.submitLabel(.next)
						.onSubmit {
							focusField = .street
						}
                    TextField("Straße", text: $street)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "house"))
						.focused($focusField, equals: .street)
						.submitLabel(.next)
						.onSubmit {
							focusField = .housenumber
						}
                    TextField("Hausnummer", text: $streetNr)
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
                    .pickerStyle(MenuPickerStyle())
					.focused($focusField, equals: .zip)
                    TextField("Bezeichnung (optional)", text: $label)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "square.and.pencil"))
						.focused($focusField, equals: .discription)
						.submitLabel(.next)
						.onSubmit {
							focusField = nil
						}
                    
                }
                Button(action: {
                    let address = recipient(lastName: name, firstName: surName, street: street, streetNr: streetNr, plz: plz, label: label.isEmpty ? nil : label)
                    addressBook.addAddress(address)
                    
                    showSuccessAlert = true
					appState.addressEntered = true
                    name = ""
                    surName = ""
                    street = ""
                    streetNr = ""
                    plz = ""
                    label = ""
					print(appState.addressEntered)

                }) {
                    HStack{
                        Image(systemName: "square.and.arrow.down.fill")
                        Text("Adresse speichern")
                    }
                }
                .disabled(name.isEmpty || street.isEmpty || streetNr.isEmpty || plz.isEmpty)
            }
            .navigationBarTitle("Neue Adresse")
			.navigationBarItems(leading: cancelButton)
            
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
			// Schließe die Ansicht und kehre zum Einstellungsmenü zurück
			presentationMode.wrappedValue.dismiss()
		}) {
			Text("Zurück")
		}
	}
}


struct addressFormView_Previews: PreviewProvider {

    static var previews: some View {
        addressFormView(addressBook: AddressBook())
    }
}
