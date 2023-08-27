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
	@State static var returnedBool: Bool?
	@State private var showingDeleteConfirmation = false
	@Binding var introState: Bool
	@ObservedObject var addressBook: AddressBook

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
								showingDeleteConfirmation = true
							}){
								Text("Alle Adressen löschen")
									.foregroundColor(Color.red)
							}
							.alert(isPresented: $showingDeleteConfirmation) {
								Alert(
									title: Text("Alle Adressen löschen"),
									message: Text("Sind Sie sicher, dass Sie alle Adressen löschen möchten?"),
									primaryButton: .destructive(Text("Löschen"), action: {
										DispatchQueue.main.async {
											deleteAll()
										}
									}),
									secondaryButton: .cancel()
								)
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
		addressBook.deleteAllAddresses()
	}

	struct SettingsView_Previews: PreviewProvider {
		static var previews: some View {

			let addressBook = AddressBook()

			SettingsView(introState: .constant(false), addressBook: addressBook)
		}
	}
}
