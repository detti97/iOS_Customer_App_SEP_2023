//
//  addressFormView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI

struct address: Identifiable {
    var id = UUID()
    var name: String
    var surName: String
    var street: String
    var streetNr: String
    var plz: String
    var label: String?
    
    func toString() -> String {
            var result = "\n\(surName) \(name) \n"
            result += "\(street) \(streetNr)\n"
            
            if let label = label {
                result += "\(label)"
            }
            return result
        }
    func toStringQrString() -> String {
        let result = "\(surName)&\(name)&\(street)&\(streetNr)&\(plz)"
            return result
        }
}

class AddressBook: ObservableObject {
   @Published var addresses: [address] = []
    
     func addAddress(_ address: address) {
        addresses.append(address)
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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ihre Adresse")) {
                    TextField("Vorname", text: $surName)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "person"))
                    TextField("Nachname", text: $name)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "figure.fall"))
                    TextField("Straße", text: $street)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "house"))
                    TextField("Hausnummer", text: $streetNr)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "figure.skiing.downhill"))
                    Picker("Postleitzahl", selection: $plz) {
                        ForEach(zipCodes, id: \.self) { plz in
                            Text(plz)
                        }
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    TextField("Bezeichnung (optional)", text: $label)
                        .textFieldStyle(CustomTextFieldStyle(systemImageName: "square.and.pencil"))
                    
                }
                Button(action: {
                    let address = address(name: name, surName: surName, street: street, streetNr: streetNr, plz: plz, label: label.isEmpty ? nil : label)
                    addressBook.addAddress(address)
                    
                    showSuccessAlert = true
                    name = ""
                    surName = ""
                    street = ""
                    streetNr = ""
                    plz = ""
                    label = ""
                }) {
                    HStack{
                        Image(systemName: "square.and.arrow.down.fill")
                        Text("Adresse speichern")
                    }
                }
                .disabled(name.isEmpty || street.isEmpty || streetNr.isEmpty || plz.isEmpty)
            }
            .navigationBarTitle("Neue Adresse")
            
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


struct addressFormView_Previews: PreviewProvider {
    static var previews: some View {
        addressFormView(addressBook: AddressBook())
    }
}
