//
//  StoreList.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 07.04.23.


import SwiftUI

struct StoreList: View {

	@StateObject public var dataManager = DataManager()
	@State private var showErrorAlert = false

	var body: some View {

			NavigationView{

				List(dataManager.stores) { store in
					NavigationLink{
						StoreDetail(store: store)
					} label: {
						StoreRow(store: store)
					}
				}
				.navigationTitle("Teilnehmende Geschäfte")
				.refreshable {
					print("reload")
					dataManager.loadData()
						   }
			}

			if dataManager.errorLoading {
				Text("Fehler beim Laden der Daten")
					.foregroundColor(.red)
			}

		}
	
}

struct StoreList_Previews: PreviewProvider {
	static var previews: some View {
		StoreList()
	}
}

