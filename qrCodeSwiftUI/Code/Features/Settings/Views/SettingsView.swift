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

						Section(header: Text("Adressbuch")) {
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
							.accessibilityLabel("deleteAll")
							.alert(isPresented: $showingDeleteConfirmation) {
								Alert(
									title: Text("Alle Adressen löschen"),
									message: Text("Sind Sie sicher, dass Sie alle Adressen löschen möchten?"),
									primaryButton: .destructive(Text("Löschen"), action: {
										DispatchQueue.main.async {
											deleteAll()
										}
									}),
									secondaryButton: .cancel(Text("Abbrechen"))
								)
							}
							Button(action:{
								removeIntroState()

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

	private func removeIntroState(){

		UserDefaults.standard.removeObject(forKey: "IntroState")
		introState = false

	}

	struct SettingsView_Previews: PreviewProvider {
		static var previews: some View {

			let addressBook = AddressBook()

			SettingsView(introState: .constant(false), addressBook: addressBook)
		}
	}
}
