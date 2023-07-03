//
//  SettingsView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.07.23.
//

import SwiftUI

struct SettingsView: View {

	@State var showEditAddress = false


	var body: some View {

		NavigationView{

			Form{

				Section(header: Text("Adresse")) {
					Button(action: {
						showEditAddress = true
					}) {
						Text("Adresse hinzufügen")
					}
					.sheet(isPresented: $showEditAddress) {
						addressFormView(addressBook: AddressBook())
					}
				}
				Section(header: Text("Daten löschen")){
					Button(action: {
						DispatchQueue.main.async {
							deleteAll()
						}
					}){
						Text("Alle Adressen löschen")
							.foregroundColor(Color.red)
					}

				}
			}
			.navigationTitle("Einstellungen")
		}
	}

	private func deleteAll() {
		UserDefaults.standard.removeObject(forKey: "addressBook")
		UserDefaults.standard.synchronize()
	}

	struct SettingsView_Previews: PreviewProvider {
		static var previews: some View {
			SettingsView()
		}
	}
}
