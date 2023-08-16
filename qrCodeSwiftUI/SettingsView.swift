//
//  SettingsView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.07.23.
//

import SwiftUI

struct SettingsView: View {

	@State var showEditAddress = false
	@AppStorage("isDarkMode") private var isDarkMode = false
	@State static var returnedBool: Bool?
	@Binding var introState: Bool

	var body: some View {

		NavigationView{

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
				.navigationTitle("Einstellungen")

				VStack{

					VStack(alignment: .center, spacing: 20) {

						HStack{
							Image(systemName: "shippingbox")
							Text("Impressum")
						}
						.foregroundColor(.purple)
						.font(.largeTitle)
						.fontWeight(.heavy)

						VStack (alignment: .center, spacing: 5){

							Text("Diese App wurde von Studierenden")
							Text("der Hochschule Osnabrück, im Rahmen des Sofwareentwicklungsprojekts, entwickelt.")

							Text("Alaa Chraih\nSadik Bajrami\nJan Dettler\nAmirali Haghighatkhah\nRania Mohammad\nChristian Minich ")

						}
						.fontWeight(.heavy)
						.multilineTextAlignment(.center)
						.background(
							RoundedRectangle(cornerRadius: 10) // Radius für die abgerundeten Ecken
								.fill(Color.white) // Hintergrundfarbe des Rechtecks
								.shadow(radius: 5) // Schatten für das Rechteck
						)

					}

				}
			}

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
