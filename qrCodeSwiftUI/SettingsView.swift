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
								Text("Intro Reset")
									.foregroundColor(.red)
							}
							Section() {
								Toggle(isOn: $isDarkMode) {
									Text("Dark Mode")
								}
							}
						}
					}

				}
				VStack(alignment: .trailing){

					Button(action: {
								   showInfo.toggle()
							   }) {
								   Image(systemName: "info.circle")
									   .font(.system(size: 30))
							   }
							   .sheet(isPresented: $showInfo) {
								   ImpressumView()
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
			SettingsView(introState: .constant(false))
		}
	}
}
