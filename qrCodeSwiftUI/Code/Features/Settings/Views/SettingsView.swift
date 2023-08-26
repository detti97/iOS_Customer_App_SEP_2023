//
//  SettingsView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.07.23.
//

import SwiftUI

struct SettingsView: View {

	@State private var showEditAddress = false
	@State private var showInfo = false
	@AppStorage("isDarkMode") private var isDarkMode = false
	@State static var returnedBool: Bool?
	@Binding var introState: Bool

	var body: some View {

		NavigationView{

			VStack{
				VStack{
					Form{

						Section(header: Text("Adresse")) {
							Button(action: {
								showEditAddress = true
							}) {
								Text("Adresse hinzufügen")
							}
							.sheet(isPresented: $showEditAddress) {
								AddressAddView(addressBook: AddressBook())
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
							Button(action:{
								introState = false
								UserDefaults.standard.removeObject(forKey: "IntroState")

							}){
								Text("Intro Reset - nur für Demo")
									.foregroundColor(.red)
							}
							Button(action: {
										   showInfo.toggle()
									   }) {
										   HStack{

											   Text("Impressum")
											   Image(systemName: "info.circle")
										   }

									   }
									   .sheet(isPresented: $showInfo) {
										   ImpressumView()
									   }
						}
					}

				}
				VStack(alignment: .trailing){


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
			SettingsView(introState: .constant(false))
		}
	}
}
