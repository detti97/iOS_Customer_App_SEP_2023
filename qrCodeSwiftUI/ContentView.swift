//
//  ContentView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.04.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var addressBook = AddressBook()
    @State private var showAddressAlert = false
	@State private var introshown = false

	@StateObject private var dataManager = DataManager()


    var body: some View {


		Group{

			if !introshown && !getIntroState() {

				IntroView(introState: $introshown, addressBook: addressBook)

				}else{

				VStack {
					TabView {
						AddressListView(addressBook: addressBook)
							.tabItem {
								Label("Lingen Code", systemImage: "qrcode")
							}
						StoreList()
							.tabItem {
								Label("Erkunden", systemImage: "location")
							}
						SettingsView(introState: $introshown)
							.tabItem {
								Label("Einstellungen", systemImage: "gear")
							}
					}
					.onAppear {
						if addressBook.addresses.isEmpty {
							showAddressAlert = true
						}
					}
				}
				.alert(isPresented: $showAddressAlert) {
					Alert(
						title: Text("Herzlich Willkommen in der Lingen-Liefert App"),
						message: Text("Bitte geben Sie eine Adresse ein, indem Sie auf den + Button unten drücken"),
						dismissButton: .default(Text("OK"))
					)
				}

			}

		}

    }
    
	func getIntroState() -> Bool {

		let state = UserDefaults.standard.bool(forKey: "IntroState")
		let myOptional: Bool? = nil
		if state == myOptional {
			return false
		}else{
			return state
		}
	}


	struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

