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
						StoreListView()
							.tabItem {
								Label("Erkunden", systemImage: "location")
							}
						SettingsView(introState: $introshown)
							.tabItem {
								Label("Einstellungen", systemImage: "gear")
									.foregroundColor(.white)
							}

					}
					.onAppear {
						let appearance = UITabBarAppearance()
						appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
						appearance.backgroundColor = UIColor(Color.accentColor.opacity(0.2))

						UITabBar.appearance().standardAppearance = appearance
						UITabBar.appearance().scrollEdgeAppearance = appearance

					}

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

